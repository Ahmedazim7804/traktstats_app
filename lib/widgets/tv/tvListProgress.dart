import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';

class TvListProgress extends StatelessWidget {
  const TvListProgress({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/list_progress')),
    ]);

    Map<String, dynamic> tvNetworks = await jsonDecode(responses[0].body);
    print(tvNetworks);    
    return tvNetworks;
  }
    

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              Map<String, dynamic> list = snapshot.data!;

              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: const Text("LIST PROGRESS", style: TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
                    ListProgressWidget(listName: 'Trakt', total: list['trakt']['total'], watched: list['trakt']['watched']),
                    ListProgressWidget(listName: 'IMDb', total: list['imdb']['total'], watched: list['imdb']['watched']),
                    ListProgressWidget(listName: 'RollingStone', total: list['rollingstone']['total'], watched: list['rollingstone']['watched'])
                  ],
                )
              );
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}

class ListProgressWidget extends StatelessWidget {
  const ListProgressWidget({super.key, required this.listName, required this.total, required this.watched});

  final String listName;
  final int total;
  final int watched;

  @override
  Widget build(BuildContext context) {

    final int percentage = ((watched / total) * 100).toInt();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: CircularPercentIndicator(
        radius: 128,
        progressColor: const Color.fromARGB(200, 239, 49, 56),
        percent: percentage/100,
        lineWidth: 16,
        center: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/${listName}List.png' , width: 96 , height: 64,),
              Text('$listName Top $total', style: const TextStyle(color: Colors.white, fontFamily: 'ProximaNova', fontWeight: FontWeight.w400),),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Divider(color: Colors.white),
              ),
              Text('$percentage%', style: const TextStyle(fontFamily: 'ProximaNova', color: Colors.white, fontSize: 48, fontWeight: FontWeight.w600),),
              Text('WATCHED $watched OF $total', style: const TextStyle(color: Colors.white30),)
            ],
          ),
        ),
      ),
    );
  }
}