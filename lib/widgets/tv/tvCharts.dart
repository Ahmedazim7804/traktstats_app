import 'package:flutter/material.dart';
import 'package:traktstats/getData.dart';
import 'package:traktstats/widgets/charts.dart';

class TvCharts extends StatelessWidget {
  const TvCharts({super.key});

    Future<Map<String, List<Data>>> fetchData() async {
    final tvChartData = await getData('tv/plays');
    
    final List<Data> byYear = [];
    final List<Data> byMonth = [];
    final List<Data> byDayOfWeek = [];
    final List<Data> byHour = [];

    tvChartData['by_year'].forEach((key, value) {byYear.add(Data(label: key, value: value));});
    tvChartData['by_month'].forEach((key, value) {byMonth.add(Data(label: key, value: value));});
    tvChartData['by_day_of_week'].forEach((key, value) {byDayOfWeek.add(Data(label: key, value: value));});
    tvChartData['by_hour'].forEach((key, value) {byHour.add(Data(label: key, value: value));});

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
              return Charts(data: snapshot.data!, tv: true,);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        );
  }
}