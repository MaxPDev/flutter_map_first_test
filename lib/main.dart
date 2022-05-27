import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

void main() {
  runApp(MapTest());
}

class MapTest extends StatefulWidget {
  MapTest({Key? key}) : super(key: key);

  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  final List<LatLng> _latLngList = [
    LatLng(48.647956, 6.144231),
    LatLng(48.703904, 6.176262),
    LatLng(48.696855, 6.170692),
    LatLng(48.694655, 6.177156),
    LatLng(48.693182, 6.177806),
    LatLng(48.694746, 6.184181),
  ];

  List<Marker> _markers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _markers = _latLngList
        .map((point) => Marker(
              point: point,
              width: 60,
              height: 60,
              builder: (context) => Icon(
                Icons.pin_drop,
                size: 60,
                color: Colors.blueAccent,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Container(
          child: FlutterMap(
            // mapController: ,
            options:
                MapOptions(center: LatLng(48.6907359, 6.1825126), zoom: 14.0, plugins: [MarkerClusterPlugin(),]),
            layers: [
              TileLayerOptions(
                minZoom: 1,
                maxZoom: 18,
                backgroundColor: Colors.black,
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                // attributionBuilder: (_) {
                //   return Text('Test');
                // }
              ),

              //# cluster. With cluster pakckage
              MarkerClusterLayerOptions(
                  maxClusterRadius: 120,
                  disableClusteringAtZoom: 12,
                  size: Size(50, 50),
                  fitBoundsOptions:
                      FitBoundsOptions(padding: EdgeInsets.all(50)),
                  markers: _markers,
                  polygonOptions: PolygonOptions(
                      borderColor: Colors.blueAccent,
                      color: Colors.black12,
                      borderStrokeWidth: 3),
                  builder: (context, markers) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 69, 66, 241), shape: BoxShape.circle),
                      child: Text('${markers.length}', style: TextStyle(color: Color.fromARGB(255, 233, 228, 228)) ),
                    );
                  }),

              //# defined up
              // MarkerLayerOptions(markers: _markers),

              //# define here
              //  MarkerLayerOptions(
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
