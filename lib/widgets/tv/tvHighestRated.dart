import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/highestRated.dart';

class TvHighestRatedShows extends StatelessWidget {
  const TvHighestRatedShows({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    
    Map<String, dynamic> highestRated = await getData('tv/highest_rated');

    return highestRated;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          return HighestRated(data: snapshot.data!, tv: true);
          
        }
        else {
          return const Center(child: CircularProgressIndicator());
        }
      } 
    );
  }
}