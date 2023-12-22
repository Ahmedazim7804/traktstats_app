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
import 'package:traktstats/widgets/welcomeScreen.dart';
import 'package:traktstats/widgets/tv/tvCharts.dart';
import 'package:traktstats/widgets/tv/tvCountriesMap.dart';
import 'package:traktstats/widgets/tv/tvGenres.dart';
import 'package:traktstats/widgets/tv/tvReleasedYear.dart';
import 'package:traktstats/widgets/tv/tvShowStats.dart';
import 'package:traktstats/widgets/tv/tvShowsTop.dart';
import 'package:traktstats/widgets/tv/tvTraktMostWatchedShows.dart';
import 'package:traktstats/widgets/people/peopleWidget.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(children: [

              WelcomeWidget(),
              allTimeTotals(),
              FirstPlay(),

              TvShowStats(),
              TvCharts(),
              TopTvShows(),
              TraktMostWatchedShows(),
              TvGenres(),
              TvReleasedYear(),
              TvCountriesMap(),
              TvListProgress(),
              TvHighestRatedShows(),
              TvAllRatings(),

              MovieStats(),
              MovieCharts(),
              TopMovies(),
              TraktMostWatchedMovies(),
              MovieGenres(),
              MoviesReleasedYear(),
              MovieCountriesMap(),
              MovieListProgress(),
              MovieHighestRated(),
              MovieAllRatings(),

              PeopleWidget(endpoint: 'actors'),
              PeopleWidget(endpoint: 'actresses'),
              PeopleWidget(endpoint: 'directors',),
              PeopleWidget(endpoint: 'writers'),

              ],),
        )
      ),
    );
  }
}