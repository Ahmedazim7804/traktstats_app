import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TvAllRatings extends StatelessWidget {
  const TvAllRatings({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/all_ratings')),
    ]);
    Map<String, dynamic> allRatings = jsonDecode(responses[0].body);
    
    allRatings = Map.from(allRatings)..removeWhere((key, value) => (value == 0));
    
    allRatings = SplayTreeMap<String, int>.from(
      allRatings, (key1, key2) => int.parse(key2).compareTo(int.parse(key1))
    );

    return allRatings;
  }

  double BarWidth(int value, int sumOfValues, BuildContext context) {

    final double screenWidth = MediaQuery.sizeOf(context).width;
    final int perc = ((value / sumOfValues) * 100).toInt();

    final double minimumBarWidth = (screenWidth * 0.2);
    final double availabeWidth = (screenWidth * 0.8);

    final double barWidth = ((availabeWidth * perc) / 100 + minimumBarWidth);

    return barWidth;

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            
            final sumOfValues = snapshot.data!.values.fold(0, (previousValue, newValue) => previousValue + newValue as int);
            bool upOrDown = true;

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              color: Colors.grey.withAlpha(25),
              child: Center(
                child: Column(
                  children: [
                    Container(margin: const EdgeInsets.all(16),padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: const Text("ALL RATINGS", style: TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data!.entries.map((e) {upOrDown = !upOrDown; return RatingBar(rating: int.parse(e.key),value: e.value,  width: BarWidth(e.value, sumOfValues, context), up: upOrDown);}).toList(),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        } 
      );
  }
}

class RatingBar extends StatelessWidget {
  const RatingBar({super.key, required this.rating, required this.value, required this.width, required this.up});

  final int rating;
  final int value;
  final double width;
  final bool up;

  static Map<int, String> RatingText = {
    10: "10 - TOTALLY NINJA",
    9: "9 - SUPERB",
    8: "8 - GREAT",
    7: "7 - GOOD",
    6: "6 - FAIR",
    5: "5- MEH",
    4: "4 - POOR",
    3: "3 - BAD",
    2: "2 - TERRIBLE",
    1: "1 - WEAK SAUCE"
  };

  static Map<int, Color> RatingColor = {
    10: const Color.fromARGB(255, 145, 8, 8),
    9: const Color.fromARGB(255, 140, 13, 13),
    8: const Color.fromARGB(255, 134, 20, 19),
    7: const Color.fromARGB(255, 126, 29, 29),
    6: const Color.fromARGB(255, 117, 38, 38),
    5: const Color.fromARGB(255, 106, 48, 48),
    4: const Color.fromARGB(255, 97, 56, 56),
    3: const Color.fromARGB(255, 87, 64, 64),
    2: const Color.fromARGB(255, 73, 79, 82),
    1: const Color.fromARGB(255, 72, 78, 81)
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: width,
          height: 72,
          color: RatingColor[rating],
          child: Text("$rating", style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'ProximaNova'),)
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 2, 0),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          width: width,
          height: 40,
          color: const Color.fromARGB(255, 15, 15, 15),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(RatingText[rating]!, style: const TextStyle(fontFamily: 'ProximaNova', color: Colors.white, fontWeight: FontWeight.bold), softWrap: false),
                  Text("$value SHOWS", style: const TextStyle(fontFamily: 'ProximaNova', color: Colors.white, fontSize: 10 ),)
                ]
              ),
        )
      ]
    );
  }
}