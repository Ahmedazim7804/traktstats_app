import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/allRatings.dart';


class TvAllRatings extends StatelessWidget {
  const TvAllRatings({super.key});

  Future<Map<String, dynamic>> fetchData() async {

    Map<String, dynamic> allRatings = await getData('tv/all_ratings');
    
    allRatings = Map.from(allRatings)..removeWhere((key, value) => (value == 0));
    
    allRatings = SplayTreeMap<String, int>.from(
      allRatings, (key1, key2) => int.parse(key2).compareTo(int.parse(key1))
    );

    return allRatings;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return AllRatings(data: snapshot.data!, tv: true);
            
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        } 
      );
  }
}