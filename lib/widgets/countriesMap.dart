import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class CountriesMap extends StatelessWidget {
  const CountriesMap({super.key, required this.data, required this.tv});

  final Map<String, dynamic> data;
  final bool tv;

  Color getCountryColor(int maxDiffMin, int value) {

    // Base opacity is taken as 0.2 and then opacity is increased according to value

    double steps = (0.8) / (maxDiffMin);

    double colorOpacity = value * steps;

    return Colors.blue.withOpacity(0.2 + colorOpacity);
  }

  @override
  Widget build(BuildContext context) {

    int largestValue = data.values.fold(0, (previousValue, newValue) => previousValue > newValue ? previousValue : newValue);
    int lowestValue = data.values.fold(0, (previousValue, newValue) => previousValue < newValue ? previousValue : newValue);
    int maxDiffMin = largestValue - lowestValue;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(children: [
        Container(margin: const EdgeInsets.all(16),padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 48, 52, 54))), child: Text("${tv ? "TV SHOW" : "MOVIE"} COUNTRIES", style: const TextStyle(fontFamily: 'ProximaNova', fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),)),
        SfMaps(layers: [
          MapShapeLayer(source: 
          MapShapeSource.asset(
            'assets/world-map.json',
            shapeDataField: 'admin',
            dataCount: data.length,
            primaryValueMapper: (int index) => data.keys.elementAt(index),
            shapeColorValueMapper: (int index) => getCountryColor(maxDiffMin, data.values.elementAt(index)),
          ),
          zoomPanBehavior: MapZoomPanBehavior(
            enablePinching: true,
            enableDoubleTapZooming: true
          ),
          color: const Color.fromARGB(255, 38, 42, 43),
          strokeColor: Colors.black,
          tooltipSettings: const MapTooltipSettings(
            color: Colors.black
          ),
          shapeTooltipBuilder: (BuildContext ctx, int index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white54),
                
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text( data.keys.elementAt(index), textAlign: TextAlign.center, style: GoogleFonts.varela(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16), overflow: TextOverflow.ellipsis,),
                  Text("${data.values.elementAt(index)} ${tv ? "shows" : "movies"}", textAlign: TextAlign.center, style: GoogleFonts.varela(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 10)),
                ],
                
              ),
            );
  })
        ]
        )
      ]
      )
    );
  }
}