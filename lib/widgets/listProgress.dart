import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ListProgress extends StatelessWidget {
  const ListProgress({super.key, required this.data, required this.tv});

  final Map<String, dynamic> data;
  final bool tv;

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: const Text("LIST PROGRESS", style: TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
          ListProgressWidget(listName: 'Trakt', total: data['trakt']['total'], watched: data['trakt']['watched']),
          ListProgressWidget(listName: 'IMDb', total: data['imdb']['total'], watched: data['imdb']['watched']),
          ListProgressWidget(listName: tv ? "RollingStone" : "Reddit", total: data[tv ? "rollingstone" : "reddit"]['total'], watched: data[tv ? "rollingstone" : "reddit"]['watched'])
        ],
      )
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