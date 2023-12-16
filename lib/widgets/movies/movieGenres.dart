import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/genres.dart';

class MovieGenres extends StatelessWidget {
  const MovieGenres({super.key, required this.baseurl});

  final String baseurl;

  Future<List<Genre>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/movies/by_genre')),
    ]);
    Map<String, dynamic> showGenres = jsonDecode(responses[0].body);

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