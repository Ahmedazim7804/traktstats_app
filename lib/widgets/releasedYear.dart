import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReleasedYear extends StatelessWidget {
  const ReleasedYear({super.key, required this.data, required this.tv});

  final Map<String, dynamic> data;
  final bool tv;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(children: [
        Container(margin: const EdgeInsets.all(16),padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: Text("${tv ? "TV SHOW" : "MOVIE"} RELEASE YEAR", style: const TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: BarChartWidget(data: data),
        ),
      ],),
    );
  }
}

class BarChartWidget extends StatelessWidget{
  const BarChartWidget({super.key, required this.data});

  final Map<String, dynamic> data;

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
        
        zoomPanBehavior: ZoomPanBehavior(
          zoomMode: ZoomMode.x,
          enablePinching: true,
          maximumZoomLevel: 0.2,
          enablePanning: true,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          builder: toolTipBuilder,
          opacity: 0.6, 
        ),
        primaryYAxis: NumericAxis( 
                majorGridLines: const MajorGridLines(width: 0), 
            ),
        primaryXAxis: CategoryAxis(
          interval: 10,
          // autoScrollingMode: AutoScrollingMode.start,
          // autoScrollingDelta: 50,
          majorGridLines: const MajorGridLines(width: 0),
          labelPosition: ChartDataLabelPosition.outside,
          labelRotation: -75,
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