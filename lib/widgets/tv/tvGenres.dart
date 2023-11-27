import 'dart:convert';
import 'dart:math';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class TvGenres extends StatelessWidget {
  const TvGenres({super.key});

  Future<List<Genre>> fetchData() async {
    String baseurl = 'http://192.168.1.10:8455';
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/by_genre')),
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

          int totalShows = snapshot.data!.fold(0, (previousValue, element) => previousValue + element.showCount);
          int largestValue = snapshot.data!.fold(0, (previousValue, element) => previousValue > element.showCount ? previousValue : element.showCount);

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            color: Colors.grey.withAlpha(25),
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Container(margin: const EdgeInsets.all(16),padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: const Text("TV SHOWS", style: TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),))),
                  ...snapshot.data!.map((genre) => GenreBar(genre: genre, totalShows: totalShows, largestValue: largestValue))
                  ]
              ),
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      } 
    );
  }
}

class Genre {
  const Genre({required this.genre, required this.showCount});

  final String genre;
  final int showCount;
}

class GenreBar extends StatelessWidget {
  const GenreBar({super.key, required this.genre, required this.totalShows, required this.largestValue});

  final Genre genre;
  final int totalShows;
  final int largestValue;

  @override
  Widget build(BuildContext context) {
    var generatedColor = Random().nextInt(Colors.primaries.length);
    final String percentage = ((genre.showCount / totalShows) * 100).toStringAsFixed(0);
    final double screenWidth = MediaQuery.of(context).size.width;

    final double barWidth = (genre.showCount / largestValue) * screenWidth;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(genre.genre, style: const TextStyle(fontFamily: 'ProximaNova', color: Colors.white, fontWeight: FontWeight.bold),),
          Text("${genre.showCount.toString()} SHOWS", style: const TextStyle(fontFamily: 'ProximaNova', color: Colors.white, fontSize: 10 ),),
          Container(
            width: barWidth > 30 ? barWidth : 30, color: Colors.primaries[generatedColor],
            child: Text('$percentage%', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 15),),),
          const SizedBox(height: 5,),
          
        ],
      ),
    );
  }
}