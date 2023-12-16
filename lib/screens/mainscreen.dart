import 'package:flutter/material.dart';
import 'package:traktstats/widgets/movies/movieAllRatings.dart';
import 'package:traktstats/widgets/movies/movieCharts.dart';
import 'package:traktstats/widgets/movies/movieCountriesMap.dart';
import 'package:traktstats/widgets/movies/movieGenres.dart';
import 'package:traktstats/widgets/movies/movieHighestRated.dart';
import 'package:traktstats/widgets/movies/movieListProgress.dart';
import 'package:traktstats/widgets/movies/movieReleasedYear.dart';
import 'package:traktstats/widgets/movies/movieStats.dart';
import 'package:traktstats/widgets/movies/moviesTop.dart';
import 'package:traktstats/widgets/movies/moviesTraktMostWatched.dart';
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
import 'package:traktstats/widgets/tv/tvShowsTop.dart';
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

              MovieStats(baseurl: baseurl),
              MovieCharts(baseurl: baseurl),
              TopMovies(baseurl: baseurl),
              TraktMostWatchedMovies(baseurl: baseurl),
              MovieGenres(baseurl: baseurl),
              MoviesReleasedYear(baseurl: baseurl),
              MovieCountriesMap(baseurl: baseurl),
              MovieListProgress(baseurl: baseurl),
              MovieHighestRated(baseurl: baseurl),
              MovieAllRatings(baseurl: baseurl),

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