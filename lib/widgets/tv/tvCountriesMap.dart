import 'dart:convert';
import 'dart:math';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:countries_world_map/data/maps/world_map.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class TvCountriesMap extends StatelessWidget {
  const TvCountriesMap({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    String baseurl = 'http://192.168.1.10:8455';
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/by_country')),
    ]);

    Map<String, dynamic> tvCountriesMap = await jsonDecode(responses[0].body);
    
    return tvCountriesMap;
  }

  Color getCountryColor(int maxDiffMin, int value) {

    // Base opacity is taken as 0.2 and then opacity is increased according to value

    double steps = (0.8) / (maxDiffMin);

    double colorOpacity = value * steps;

    return Colors.blue.withOpacity(0.2 + colorOpacity);
  }

    

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              int largestValue = snapshot.data!.values.fold(0, (previousValue, newValue) => previousValue > newValue ? previousValue : newValue);
              int lowestValue = snapshot.data!.values.fold(0, (previousValue, newValue) => previousValue < newValue ? previousValue : newValue);
              int maxDiffMin = largestValue - lowestValue;


              return Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(children: [
                  Container(margin: const EdgeInsets.all(16),padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: const Text("TV SHOW COUNTRIES", style: TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
                  SfMaps(layers: [
                    MapShapeLayer(source: 
                    MapShapeSource.asset(
                      'assets/world-map.json',
                      shapeDataField: 'admin',
                      dataCount: snapshot.data!.length,
                      primaryValueMapper: (int index) => snapshot.data!.keys.elementAt(index),
                      shapeColorValueMapper: (int index) => getCountryColor(maxDiffMin, snapshot.data!.values.elementAt(index)),
                    ),
                    color: const Color.fromARGB(255, 38, 42, 43),
                    strokeColor: Colors.black,
                    )
                  ])  
                ],),
                );
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}