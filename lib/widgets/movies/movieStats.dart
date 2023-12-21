import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/stats.dart';

class MovieStats extends StatelessWidget {
  const MovieStats({super.key});

  Future<Map<String, dynamic>> fetchData() async {

    Map<String, dynamic> movieStats = await getData('movies/stats');
    return movieStats;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stats(data: snapshot.data!, tv: false);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}