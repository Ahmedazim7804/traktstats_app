import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/listProgress.dart';

class MovieListProgress extends StatelessWidget {
  const MovieListProgress({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/movies/list_progress')),
    ]);

    Map<String, dynamic> movieList = await jsonDecode(responses[0].body);

    return movieList;
  }
    

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              return ListProgress(data: snapshot.data!, tv: false);

            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}