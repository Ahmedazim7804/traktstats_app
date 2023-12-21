import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/genres.dart';

class MovieGenres extends StatelessWidget {
  const MovieGenres({super.key});

  Future<List<Genre>> fetchData() async {

    Map<String, dynamic> showGenres = await getData('movies/by_genre');

    List<Genre> listGenres = showGenres.entries.map((entry) => Genre(genre: entry.key, showCount: int.parse(entry.value.toString()))).toList();
    return listGenres;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Genres(data: snapshot.data!, tv: false);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      } 
    );
  }
}