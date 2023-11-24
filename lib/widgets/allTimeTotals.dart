import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class allTimeTotals extends StatelessWidget {
  const allTimeTotals({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    String baseurl = 'http://192.168.0.111:8455';
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/all_time_stats')),
    ]);
    Map<String, dynamic> allTimeStats = jsonDecode(responses[0].body);
    return allTimeStats;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: Colors.grey.withAlpha(25),
                child: Center(
                            child: Column(
                              children: [
                                Container(padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: const Text("ALL TIME TOTALS", style: TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
                                const SizedBox(height: 25,),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    StatTextWidget(statName: "\ue602 PLAYS", statValue: snapshot.data!['plays']!.toString(),),
                                    StatTextWidget(statName: "\ue648 HOURS", statValue: snapshot.data!['hours']!.toString(),),
                                    StatTextWidget(statName: "\ue606 COLLECTED", statValue: snapshot.data!['collected']!.toString(),),
                                  ],),
                                  const SizedBox(height: 15,),
                                  Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    StatTextWidget(statName: "\ue63f RATINGS", statValue: snapshot.data!['ratings']!.toString(),),
                                    StatTextWidget(statName: "\ue61a COMMENT", statValue: snapshot.data!['comments']!.toString(),),
                                    StatTextWidget(statName: "\ue608 LISTS", statValue: snapshot.data!['lists']!.toString(),),
                                  ],)
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
      fontSize: 28,
      fontWeight: FontWeight.bold
    );

    TextStyle subtitleTextStyle = const TextStyle(
      fontFamily: 'trakt',
      fontFamilyFallback: ['ProximaNova'],
      fontWeight: FontWeight.bold,
      fontSize: 11,
      color: Colors.white60,
    );
    return Expanded(child: Column(children: [Text(statValue, style: textStyle), Text(statName, textAlign: TextAlign.center, style: subtitleTextStyle)]));
  }
}