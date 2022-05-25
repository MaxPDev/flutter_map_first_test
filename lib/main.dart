import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MapTest());
}

class MapTest extends StatelessWidget {
  // const MapTest({Key? key}) : super(key: key);

  List<LatLng> _latLngList = [
    LatLng(48.647956, 6.144231),
    LatLng(48.703904, 6.176262),
    LatLng(48.696855, 6.170692),
    LatLng(48.694655, 6.177156),
    LatLng(48.693182, 6.177806),
    LatLng(48.694746, 6.184181),
   ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Container(
          child: FlutterMap(
            // mapController: ,
            options: MapOptions(
              center: LatLng(48.6907359, 6.1825126),
              zoom: 14.0
            ),
            layers: [
              TileLayerOptions(
                minZoom: 1,
                maxZoom: 18,
                backgroundColor: Colors.black,
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) {
                  return Text('Test');
                }
              ),
      //         MarkerLayerOptions(
      //   markers: [
      //     Marker(
      //       width: 80.0,
      //       height: 80.0,
      //       point: LatLng(48.693, 6.187),
      //       builder: (ctx) =>
      //       Container(
      //         child: FlutterLogo(),
      //       ),
      //     ),
      //   ],
      // ),

            ],
          ),
        ),
      ),
    );
    }
}

