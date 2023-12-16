import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/allRatings.dart';


class TvAllRatings extends StatelessWidget {
  const TvAllRatings({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/all_ratings')),
    ]);
    Map<String, dynamic> allRatings = jsonDecode(responses[0].body);
    
    allRatings = Map.from(allRatings)..removeWhere((key, value) => (value == 0));
    
    allRatings = SplayTreeMap<String, int>.from(
      allRatings, (key1, key2) => int.parse(key2).compareTo(int.parse(key1))
    );

    return allRatings;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return AllRatings(data: snapshot.data!, tv: true);
            
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        } 
      );
  }
}