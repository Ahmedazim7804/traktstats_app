import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/countriesMap.dart';

class MovieCountriesMap extends StatelessWidget {
  const MovieCountriesMap({super.key, required this.baseurl});

  final String baseurl;

  Future<Map<String, dynamic>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/movies/by_country')),
    ]);

    Map<String, dynamic> moviesCountriesMap = await jsonDecode(responses[0].body);
    
    return moviesCountriesMap;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              return CountriesMap(data: snapshot.data!, tv: false);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}