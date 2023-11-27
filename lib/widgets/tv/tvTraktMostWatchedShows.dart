import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


class TraktMostWatchedShows extends StatelessWidget{
  const TraktMostWatchedShows({super.key});

  Future<Map<dynamic  , dynamic>> fetchData() async {
    String baseurl = 'http://192.168.1.10:8455';
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
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ //FIXME: REPLACE "LISH" BY USERNAME
                  Container(color: const Color.fromARGB(255, 26, 28, 29),child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Image.asset('assets/images/trakt.png', width: 64, height: 64,), Text("TOP SHOWS", style: GoogleFonts.passionOne(color: const Color.fromARGB(255, 232, 230, 227), fontSize: 50))])),
                  Container(color: const Color.fromARGB(255, 16, 17, 17) , child: const Text("The top TV shows watched by the Trakt community for all time. TV shows that LISH watched in 1942 → 2023 are highlighted.", style: TextStyle(fontFamily: 'ProximaNova', color: Colors.white, fontSize: 16), textAlign: TextAlign.center,)),
                  ListView(scrollDirection: Axis.vertical, controller: ScrollController(keepScrollOffset: false), shrinkWrap: true, children: snapshot.data!.entries.map((item) => ListItem(index: item.key, title: item.value['title'], plays: item.value['play_count'], watched: item.value['watched'])).toList())
                ],
              ),
          );
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}


class ListItem extends StatelessWidget{
  const ListItem({super.key, required this.index, required this.title, required this.plays, required this.watched});

  final String index;
  final String title;
  final String plays;
  final bool watched;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: watched ? const Color.fromARGB(255, 114, 54, 138) : const Color.fromARGB(255, 26, 28, 29),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ListTile(
          leading: ClipOval(child: Material(color: const Color.fromARGB(255, 24, 26, 27), child: SizedBox(width: 20, height: 20 ,child: Center(child: Text(index, style: const TextStyle(color: Colors.white),))),),),
          title: Text(title, style: const TextStyle(color: Colors.white, fontFamily: 'ProximaNova', fontSize: 16),),
          trailing: Text(plays, style: const TextStyle(color: Colors.white, fontFamily: 'ProximaNova', fontSize: 16),),
        ),
    );
  }
}