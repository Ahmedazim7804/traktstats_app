import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/topItems.dart';

class TopMovies extends StatelessWidget {
  const TopMovies({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/movies/users_top_10')),
    ]);
    Map<String, dynamic> userTopMovies = jsonDecode(responses[0].body);

    return userTopMovies;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TopItems(data: snapshot.data!, tv: false,);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      } 
    );
  }
}