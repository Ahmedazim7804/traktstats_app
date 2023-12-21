import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/countriesMap.dart';

class MovieCountriesMap extends StatelessWidget {
  const MovieCountriesMap({super.key});

  Future<Map<String, dynamic>> fetchData() async {

    Map<String, dynamic> moviesCountriesMap = await getData('movies/by_country');
    
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