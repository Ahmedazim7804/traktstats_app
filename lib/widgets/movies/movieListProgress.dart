import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/listProgress.dart';

class MovieListProgress extends StatelessWidget {
  const MovieListProgress({super.key});

  Future<Map<String, dynamic>> fetchData() async {

    Map<String, dynamic> movieList = await getData('movies/list_progress');

    return movieList;
  }
    

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              return ListProgress(data: snapshot.data!, tv: false);

            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}