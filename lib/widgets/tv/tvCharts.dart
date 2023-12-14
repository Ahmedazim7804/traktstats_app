import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class TvCharts extends StatelessWidget {
  const TvCharts({super.key, required this.baseurl});
  
  final String baseurl;

    Future<Map<String, List<Data>>> fetchData() async {
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/plays')),
    ]);

    Map<String, dynamic> tvShowStats = await jsonDecode(responses[0].body);
    
    final List<Data> byYear = [];
    final List<Data> byMonth = [];
    final List<Data> byDayOfWeek = [];
    final List<Data> byHour = [];

    tvShowStats['by_year'].forEach((key, value) {byYear.add(Data(label: key, value: value));});
    tvShowStats['by_month'].forEach((key, value) {byMonth.add(Data(label: key, value: value));});
    tvShowStats['by_day_of_week'].forEach((key, value) {byDayOfWeek.add(Data(label: key, value: value));});
    tvShowStats['by_hour'].forEach((key, value) {byHour.add(Data(label: key, value: value));});

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
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(children: [ //FIXME: HOUR CONVERT TO AM AND PM INSTEAD OF NUMBER
                   BarChartWidget(barData: snapshot.data!['by_year']!, title: "EPISODE PLAYS BY YEAR'",),
                   BarChartWidget(barData: snapshot.data!['by_month']!, title: "EPISODE PLAYS BY MONTH",),
                   BarChartWidget(barData: snapshot.data!['by_day_of_week']!, title: "EPISODE PLAYS BY DAY OF THE WEEK",),
                   BarChartWidget(barData: snapshot.data!['by_hour']!, title: "EPISODE PLAYS BY TIME OF THE DAY",),
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

class Data{
  const Data({required this.label, required this.value});
  final String label;
  final int value;
}

class BarChartWidget extends StatelessWidget{
  const BarChartWidget({super.key, required this.barData, required this.title});

  final List<Data> barData;
  final String title;

  @override
  Widget build(BuildContext context) {


    Widget toolTipBuilder(dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
      return Container(
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
    border: Border.all(color: Colors.white38, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(5))
  ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${data.value} plays', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
            Text('${data.label}', style: const TextStyle(color: Colors.white60),)
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SfCartesianChart(
        // zoomPanBehavior: ZoomPanBehavior(
        //   enablePanning: true,
        //   enablePinching: true
        // ), 
        tooltipBehavior: TooltipBehavior(
          enable: true,
          builder: toolTipBuilder,
          opacity: 0.6, 
        ),
        primaryYAxis: NumericAxis( 
                majorGridLines: const MajorGridLines(width: 0), 
            ),
        primaryXAxis: CategoryAxis(
          title: AxisTitle(
            text: title,
            textStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)
          ),
          majorGridLines: const MajorGridLines(width: 0),
          labelPosition: ChartDataLabelPosition.outside,
          labelRotation: -75
        ),
        plotAreaBorderWidth: 0,
        series: <ColumnSeries<Data, String>>[
          ColumnSeries<Data, String>(
            dataSource:  barData,
            xValueMapper: (Data data, _) => data.label,
            yValueMapper: (Data data, _) => data.value,
            color: const Color.fromARGB(255, 153, 153, 153),
          )
        ]
      ),
    );
}
}