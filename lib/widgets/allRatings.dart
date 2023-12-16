import 'package:flutter/material.dart';

class AllRatings extends StatelessWidget {
  const AllRatings({super.key, required this.data, required this.tv});

  final Map<String, dynamic> data;
  final bool tv;

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

    final sumOfValues = data.values.fold(0, (previousValue, newValue) => previousValue + newValue as int);

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
                children: data.entries.map((e) => RatingBar(rating: int.parse(e.key),value: e.value,  width: BarWidth(e.value, sumOfValues, context), tv: tv,)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  const RatingBar({super.key, required this.rating, required this.value, required this.width, required this.tv});

  final int rating;
  final int value;
  final double width;
  final bool tv;

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
                  Text("$value ${tv ? "SHOWS" : "MOVIES"}", style: const TextStyle(fontFamily: 'ProximaNova', color: Colors.white, fontSize: 10 ),)
                ]
              ),
        )
      ]
    );
  }
}