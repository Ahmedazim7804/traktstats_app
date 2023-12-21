import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/traktMostWatched.dart';


class TraktMostWatchedShows extends StatelessWidget{
  const TraktMostWatchedShows({super.key});

  Future<(Map<dynamic, dynamic>, String)> fetchData() async {
    Map<dynamic, dynamic> traktMostWatchedShows = await getData('trakt/most_watched_shows');
    String username = await getData<String>('username');
    
    return (traktMostWatchedShows, username);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TraktMostWatched(data: snapshot.data!.$1, username: snapshot.data!.$2, tv: true);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}