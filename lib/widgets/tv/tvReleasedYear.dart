import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/releasedYear.dart';

class TvReleasedYear extends StatelessWidget {
  const TvReleasedYear({super.key});

    Future<Map<String, dynamic>> fetchData() async {

    Map<String, dynamic> tvReleasedYear = await getData('tv/by_released_year');

    return tvReleasedYear;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ReleasedYear(data: snapshot.data!, tv: true);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}