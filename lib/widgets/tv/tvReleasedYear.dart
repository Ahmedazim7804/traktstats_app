import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class TvReleasedYear extends StatelessWidget {
  const TvReleasedYear({super.key});

    Future<Map<String, dynamic>> fetchData() async {
    String baseurl = 'http://192.168.1.10:8455';
    var responses = await Future.wait([
      http.get(Uri.parse('$baseurl/tv/by_released_year')),
    ]);

    Map<String, dynamic> tvReleasedYear = await jsonDecode(responses[0].body);
    print(tvReleasedYear.entries);

    return tvReleasedYear;
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
                  BarChartWidget(data: snapshot.data!, title: "EPISODE PLAYS BY YEAR'",),
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

class BarChartWidget extends StatelessWidget{
  const BarChartWidget({super.key, required this.data, required this.title});

  final Map<String, dynamic> data;
  final String title;

  @override
  Widget build(BuildContext context) {

    List<MapEntry<String, dynamic>> barData = data.entries.toList();
    barData.sort((item1, item2) => item1.key.compareTo(item2.key));

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
            Text(data.key, style: const TextStyle(color: Colors.white60),)
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
        series: <ColumnSeries<MapEntry<String, dynamic>, String>>[
          ColumnSeries<MapEntry<String, dynamic>, String>(
            dataSource: barData,
            xValueMapper: (MapEntry<String, dynamic> data, _) => data.key,
            yValueMapper: (MapEntry<String, dynamic> data, _) => data.value,
            color: const Color.fromARGB(255, 153, 153, 153),
          )
        ]
      ),
    );
}
}