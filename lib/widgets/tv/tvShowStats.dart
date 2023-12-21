import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/stats.dart';

class TvShowStats extends StatelessWidget {
  const TvShowStats({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    final data = await getData('tv/stats');

    return data;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stats(data: snapshot.data!, tv: true);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}