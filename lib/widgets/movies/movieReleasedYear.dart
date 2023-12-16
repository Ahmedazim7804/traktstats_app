import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/releasedYear.dart';

class MoviesReleasedYear extends StatelessWidget {
  const MoviesReleasedYear({super.key, required this.baseurl});

  final String baseurl;

    Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/movies/by_released_year')),
    ]);

    Map<String, dynamic> moviesReleasedYear = await jsonDecode(responses[0].body);

    return moviesReleasedYear;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ReleasedYear(data: snapshot.data!, tv: false);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}