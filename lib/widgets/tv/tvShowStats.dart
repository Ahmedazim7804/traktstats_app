import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TvShowStats extends StatelessWidget {
  const TvShowStats({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/stats')),
    ]);
    Map<String, dynamic> tvShowStats = jsonDecode(responses[0].body);
    return tvShowStats;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                color: Colors.grey.withAlpha(25),
                child: Center(
                            child: Column(
                              children: [
                                Container(padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: const Text("TV SHOWS", style: TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
                                const SizedBox(height: 25,),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    StatTextWidget(statName: "HOURS WATCHED", statValue: snapshot.data!['hours']['total']!.toString(),),
                                    const Text('\ue616', style: TextStyle(fontFamily: 'trakt', color: Colors.white, fontSize: 18),),
                                    StatTextWidget(statName: "PER YEAR", statValue: snapshot.data!['hours']['per_year']!.toString(),),
                                  ],),
                                  Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    StatTextWidget(statName: "PER MONTH", statValue: snapshot.data!['hours']['per_month']!.toString(),),
                                    const Text('\ue616', style: TextStyle(fontFamily: 'trakt', color: Colors.white, fontSize: 18),),
                                    StatTextWidget(statName: "PER DAY", statValue: snapshot.data!['hours']['per_day']!.toString(),),
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
                                    StatTextWidget(statName: "EPISODE PLAYS", statValue: snapshot.data!['plays']['total']!.toString(),),
                                    const Text('\ue616', style: TextStyle(fontFamily: 'trakt', color: Colors.white, fontSize: 18),),
                                    StatTextWidget(statName: "PER YEAR", statValue: snapshot.data!['plays']['per_year']!.toString(),),
                                  ],),
                                  Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [                                    
                                    StatTextWidget(statName: "PER MONTH", statValue: snapshot.data!['plays']['per_month']!.toString(),),
                                    const Text('\ue616', style: TextStyle(fontFamily: 'trakt', color: Colors.white, fontSize: 18),),
                                    StatTextWidget(statName: "PER DAY", statValue: snapshot.data!['plays']['per_day']!.toString(),),
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
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
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