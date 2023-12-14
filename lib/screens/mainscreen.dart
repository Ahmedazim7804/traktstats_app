import 'package:flutter/material.dart';
import 'package:traktstats/widgets/tv/tvAllRatings.dart';
import 'package:traktstats/widgets/tv/tvHighestRated.dart';
import 'package:traktstats/widgets/tv/tvListProgress.dart';
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
import 'package:traktstats/widgets/people/peopleWidget.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.baseurl});

  final String baseurl;
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(children: [
              WelcomeWidget(baseurl: baseurl),
              allTimeTotals(baseurl: baseurl),
              FirstPlay(baseurl: baseurl),
              TvShowStats(baseurl: baseurl),
              TvCharts(baseurl: baseurl),
              TopTvShows(baseurl: baseurl),
              TraktMostWatchedShows(baseurl: baseurl),
              TvGenres(baseurl: baseurl),
              TvReleasedYear(baseurl: baseurl),
              TvCountriesMap(baseurl: baseurl),
              TvListProgress(baseurl: baseurl),
              TvHighestRatedShows(baseurl: baseurl),
              TvAllRatings(baseurl: baseurl),
              PeopleWidget(baseurl: baseurl, url: 'actors',),
              PeopleWidget(baseurl: baseurl, url: 'actresses',),
              PeopleWidget(baseurl: baseurl, url: 'directors',),
              PeopleWidget(baseurl: baseurl, url: 'writers',),
              ],),
        )
      ),
    );
  }
}