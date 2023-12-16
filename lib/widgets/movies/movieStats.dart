import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:traktstats/widgets/stats.dart';
import 'package:http/http.dart' as http;

class MovieStats extends StatelessWidget {
  const MovieStats({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/movies/stats')),
    ]);
    Map<String, dynamic> movieStats = jsonDecode(responses[0].body);
    return movieStats;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stats(data: snapshot.data!, tv: false);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}