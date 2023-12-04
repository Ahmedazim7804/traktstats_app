import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/allTimeTotals.dart';
import 'package:traktstats/widgets/firstPlay.dart';
import 'package:traktstats/screens/welcomeScreen.dart';
import 'package:traktstats/widgets/tv/tvCharts.dart';
import 'package:traktstats/widgets/tv/tvCountriesMap.dart';
import 'package:traktstats/widgets/tv/tvGenres.dart';
import 'package:traktstats/widgets/tv/tvReleasedYear.dart';
import 'package:traktstats/widgets/tv/tvShowStats.dart';
import 'package:traktstats/widgets/tv/tvTopShows.dart';
import 'package:traktstats/widgets/tv/tvTraktMostWatchedShows.dart';


class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  Future<Map<String, String>> fetchData() async {
    String baseurl = 'http://192.168.0.111:8455';
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/pfp')),
      http.get(Uri.parse('$baseurl/username')),
    ]);
    String pfp = responses[0].body;
    String username = responses[1].body;
    return {
      'pfp': pfp,
      'username': username
    };
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(shrinkWrap: true, children: const [
          TvCountriesMap()
          // WelcomeWidget(),
          // allTimeTotals(),
          // FirstPlay(),
          // TvShowStats(),
          // TvCharts(),
          // TopTvShows(),
          // TraktMostWatchedShows()
          // TvReleasedYear()
          ],)
      ),
    );
  }
}