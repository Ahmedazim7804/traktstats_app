import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/traktMostWatched.dart';


class TraktMostWatchedShows extends StatelessWidget{
  const TraktMostWatchedShows({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<dynamic, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/trakt/most_watched_shows')),
    ]);

    Map<dynamic, dynamic> traktMostWatchedShows = jsonDecode(responses[0].body);
    
    return traktMostWatchedShows;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TraktMostWatched(data: snapshot.data!, tv: true);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}