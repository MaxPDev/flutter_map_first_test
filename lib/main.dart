import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

void main() {
  runApp(MaterialApp(
    home: OSMTest(),
  )
  );
}

class OSMTest extends StatefulWidget {
  const OSMTest({Key? key}) : super(key: key);

  @override
  State<OSMTest> createState() => _OSMTestState();
}

class _OSMTestState extends State<OSMTest> {

  MapController mapController = MapController(
                          initMapWithUserPosition: false,
                          initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
                          // areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),
                      );


  @override
  Widget build(BuildContext context) {

    return Container(
      child:  OSMFlutter( 
        controller: mapController,
        trackMyPosition: false,
        initZoom: 12,
        minZoomLevel: 8,
        maxZoomLevel: 14,
        stepZoom: 1.0,
        // userLocationMarker: UserLocationMaker(
        //     personMarker: MarkerIcon(
        //         icon: Icon(
        //             Icons.location_history_rounded,
        //             color: Colors.red,
        //             size: 48,
        //         ),
        //     ),
        //     directionArrowMarker: MarkerIcon(
        //         icon: Icon(
        //             Icons.double_arrow,
        //             size: 48,
        //         ),
        //     ),
        // ),
        //  roadConfiguration: RoadConfiguration(
        //         startIcon: MarkerIcon(
        //           icon: Icon(
        //             Icons.person,
        //             size: 64,
        //             color: Colors.brown,
        //           ),
        //         ),
        //         roadColor: Colors.yellowAccent,
        // ),
        // markerOption: MarkerOption(
        //     defaultMarker: MarkerIcon(
        //         icon: Icon(
        //           Icons.person_pin_circle,
        //           color: Colors.blue,
        //           size: 56,
        //           ),
        //         )
        // ),
    )
,
    );
  }
}
