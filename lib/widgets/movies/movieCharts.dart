import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traktstats/widgets/charts.dart';

class MovieCharts extends StatelessWidget {
  const MovieCharts({super.key, required this.baseurl});
  
  final String baseurl;

    Future<Map<String, List<Data>>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/movies/plays')),
    ]);

    Map<String, dynamic> movieChartData = await jsonDecode(responses[0].body);
    
    final List<Data> byYear = [];
    final List<Data> byMonth = [];
    final List<Data> byDayOfWeek = [];
    final List<Data> byHour = [];

    movieChartData['by_year'].forEach((key, value) {byYear.add(Data(label: key, value: value));});
    movieChartData['by_month'].forEach((key, value) {byMonth.add(Data(label: key, value: value));});
    movieChartData['by_day_of_week'].forEach((key, value) {byDayOfWeek.add(Data(label: key, value: value));});
    movieChartData['by_hour'].forEach((key, value) {byHour.add(Data(label: key, value: value));});

    return {
      'by_year': byYear,
      'by_month': byMonth,
      'by_day_of_week': byDayOfWeek,
      'by_hour': byHour
    };
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Charts(data: snapshot.data!, tv: false,);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}