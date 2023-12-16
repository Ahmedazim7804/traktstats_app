import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Charts extends StatelessWidget {
  const Charts({super.key, required this.data, required this.tv});
  
  final Map<String, List<Data>> data;
  final bool tv;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(children: [ //FIXME: HOUR CONVERT TO AM AND PM INSTEAD OF NUMBER
        BarChartWidget(barData: data['by_year']!, title: "${tv ? "EPISODE" : "MOVIE"} PLAYS BY YEAR'",),
        BarChartWidget(barData: data['by_month']!, title: "${tv ? "EPISODE" : "MOVIE"} PLAYS BY MONTH",),
        BarChartWidget(barData: data['by_day_of_week']!, title: "${tv ? "EPISODE" : "MOVIE"} PLAYS BY DAY OF THE WEEK",),
        BarChartWidget(barData: data['by_hour']!, title: "${tv ? "EPISODE" : "MOVIE"} PLAYS BY TIME OF THE DAY",),
      ],),
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