import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/traktMostWatched.dart';


class TraktMostWatchedMovies extends StatelessWidget{
  const TraktMostWatchedMovies({super.key});

  Future<(Map<dynamic, dynamic>, String)> fetchData() async {

    Map<dynamic, dynamic> traktMostWatchedMovies = await getData('trakt/most_watched_movies');
    String username = await getData('username');
    
    return (traktMostWatchedMovies, username);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TraktMostWatched(data: snapshot.data!.$1, username: snapshot.data!.$2, tv: false);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}