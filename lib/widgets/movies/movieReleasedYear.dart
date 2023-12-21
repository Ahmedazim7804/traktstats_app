import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/releasedYear.dart';

class MoviesReleasedYear extends StatelessWidget {
  const MoviesReleasedYear({super.key});

  Future<Map<String, dynamic>> fetchData() async {

    Map<String, dynamic> moviesReleasedYear = await getData('movies/by_released_year');

    return moviesReleasedYear;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ReleasedYear(data: snapshot.data!, tv: false);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}