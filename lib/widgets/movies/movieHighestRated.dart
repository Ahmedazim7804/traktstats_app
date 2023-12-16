import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/highestRated.dart';

class MovieHighestRated extends StatelessWidget {
  const MovieHighestRated({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/movies/highest_rated')),
    ]);
    Map<String, dynamic> highestRated = jsonDecode(responses[0].body);

    return highestRated;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          return HighestRated(data: snapshot.data!, tv: false);
          
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      } 
    );
  }
}