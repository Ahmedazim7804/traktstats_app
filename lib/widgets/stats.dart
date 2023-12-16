import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({super.key, required this.data, required this.tv});

  final Map<String, dynamic> data;
  final bool tv;

  @override
  Widget build(BuildContext context) {

    return Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            color: Colors.grey.withAlpha(25),
            child: Center(
              child: Column(
                children: [
                  Container(padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: Text(tv ? "TV SHOWS" : "MOVIES", style: const TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StatTextWidget(statName: "HOURS WATCHED", statValue: data['hours']['total']!.toString(),),
                      const Text('\ue616', style: TextStyle(fontFamily: 'trakt', color: Colors.white, fontSize: 18),),
                      StatTextWidget(statName: "PER YEAR", statValue: data['hours']['per_year']!.toString(),),
                    ],),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StatTextWidget(statName: "PER MONTH", statValue: data['hours']['per_month']!.toString(),),
                      const Text('\ue616', style: TextStyle(fontFamily: 'trakt', color: Colors.white, fontSize: 18),),
                      StatTextWidget(statName: "PER DAY", statValue: data['hours']['per_day']!.toString(),),
                    ],),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: DottedLine(
                      direction: Axis.horizontal,
                      dashLength: 1,
                      dashColor: Colors.white60,
                    ),
                  ),
                  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatTextWidget(statName: tv ? "EPISODE PLAYS" : "MOVIE PLAYS", statValue: data['plays']['total']!.toString(),),
                    const Text('\ue616', style: TextStyle(fontFamily: 'trakt', color: Colors.white, fontSize: 18),),
                    StatTextWidget(statName: "PER YEAR", statValue: data['plays']['per_year']!.toString(),),
                  ],),
                  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [                                    
                    StatTextWidget(statName: "PER MONTH", statValue: data['plays']['per_month']!.toString(),),
                    const Text('\ue616', style: TextStyle(fontFamily: 'trakt', color: Colors.white, fontSize: 18),),
                    StatTextWidget(statName: "PER DAY", statValue: data['plays']['per_day']!.toString(),),
                  ],),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: DottedLine(
                      direction: Axis.horizontal,
                      dashLength: 1,
                      dashColor: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
}

class StatTextWidget extends StatelessWidget {
  const StatTextWidget({super.key, required this.statName, required this.statValue});
  final String statName;
  final String statValue;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontFamily: 'ProximaNova',
      fontSize: 20,
      fontWeight: FontWeight.bold
    );

    TextStyle subtitleTextStyle = const TextStyle(
      fontFamily: 'trakt',
      fontFamilyFallback: ['ProximaNova'],
      fontWeight: FontWeight.bold,
      fontSize: 11,
      color: Colors.white60,
    );
    return Expanded(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(statValue, style: textStyle),
        Text(statName, textAlign: TextAlign.center, style: subtitleTextStyle,)
      ]));
  }
}