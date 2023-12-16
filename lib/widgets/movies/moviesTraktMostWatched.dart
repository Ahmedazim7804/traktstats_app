import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/traktMostWatched.dart';


class TraktMostWatchedMovies extends StatelessWidget{
  const TraktMostWatchedMovies({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<dynamic, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/trakt/most_watched_movies')),
    ]);

    Map<dynamic, dynamic> traktMostWatchedMovies = jsonDecode(responses[0].body);
    
    return traktMostWatchedMovies;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TraktMostWatched(data: snapshot.data!, tv: false);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}