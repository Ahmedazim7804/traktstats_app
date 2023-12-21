import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/countriesMap.dart';

class TvCountriesMap extends StatelessWidget {
  const TvCountriesMap({super.key});

  Future<Map<String, dynamic>> fetchData() async {

    Map<String, dynamic> tvCountriesMap = await getData('tv/by_country');
    
    return tvCountriesMap;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              return CountriesMap(data: snapshot.data!, tv: true);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}