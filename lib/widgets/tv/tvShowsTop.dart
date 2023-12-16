import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/topItems.dart';

class TopTvShows extends StatelessWidget {
  const TopTvShows({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/users_top_10')),
    ]);
    Map<String, dynamic> userTopShows = jsonDecode(responses[0].body);

    return userTopShows;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TopItems(data: snapshot.data!, tv: true,);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      } 
    );
  }
}