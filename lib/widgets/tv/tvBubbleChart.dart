import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bubble_chart/bubble_chart.dart';

class TvNetworkChart extends StatelessWidget {
  const TvNetworkChart({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    String baseurl = 'http://192.168.0.110:8455';
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/by_networks')),
    ]);

    Map<String, dynamic> tvNetworks = await jsonDecode(responses[0].body);
    
    return tvNetworks;
  }
    

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              final bubbles = BubbleNode.node(
    padding: 15,
    children: [
      BubbleNode.node(children: [
        BubbleNode.leaf(value: 1024, options: BubbleOptions(color: Colors.red,border: Border.all()))
      ]),
      BubbleNode.node(children: [
        BubbleNode.leaf(value: 200, options: BubbleOptions(color: Colors.white))
      ])
    ]
              );

              return SizedBox(
                width: 200,
                height: 200,
                child: BubbleChartLayout(
                  children: [
                    bubbles
                  ],
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