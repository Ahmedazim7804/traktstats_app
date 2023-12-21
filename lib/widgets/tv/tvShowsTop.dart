import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/topItems.dart';

class TopTvShows extends StatelessWidget {
  const TopTvShows({super.key, required this.baseurl});

  final String baseurl;

  Future<(Map<String, dynamic>, String)> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/users_top_10')),
      http.get(Uri.parse('$baseurl/username')),
    ]);
    Map<String, dynamic> userTopShows = jsonDecode(responses[0].body);
    String username = responses[1].body;

    return (userTopShows, username);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TopItems(data: snapshot.data!.$1, username:snapshot.data!.$2 ,tv: true,);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      } 
    );
  }
}