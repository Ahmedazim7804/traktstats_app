import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/genres.dart';

class TvGenres extends StatelessWidget {
  const TvGenres({super.key});

  Future<List<Genre>> fetchData() async {
    Map<String, dynamic> showGenres = await getData('tv/by_genre');

    List<Genre> listGenres = showGenres.entries.map((entry) => Genre(genre: entry.key, showCount: int.parse(entry.value.toString()))).toList();
    return listGenres;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Genres(data: snapshot.data!, tv: true);
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      } 
    );
  }
}