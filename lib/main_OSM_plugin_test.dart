import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

void main() {
  runApp(MaterialApp(
    home: OSMTest(),
  ));
}

class OSMTest extends StatefulWidget {
  const OSMTest({Key? key}) : super(key: key);

  @override
  State<OSMTest> createState() => _OSMTestState();
}

class _OSMTestState extends State<OSMTest> {
  MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 48.6907359, longitude: 6.1825126),
    // areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nancy Stationnement Test"),
      ),
      body: Container(
        child:  OSMFlutter( 
          controller: mapController,
          trackMyPosition: false,
          initZoom: 14,
          minZoomLevel: 7,
          maxZoomLevel: 17,
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
      ),
    bottomNavigationBar: BottomAppBar(
      color: Color.fromARGB(235, 241, 238, 49),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.directions_walk_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.pedal_bike_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.bus_alert)),
          IconButton(onPressed: () {}, icon: Icon(Icons.local_parking_outlined)),
        ],
      ) ,
    ),


    );
  }
}













//! CustomScrollView
      //     body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       floating: true,
      //       pinned: true,
      //       snap: false,
      //       centerTitle: false,
      //       title: Text('Nancy Stationnement Test'),
      //       // actions: [
      //       //   IconButton(onPressed: () {print("test");}, icon: Icon(Icons.park))
      //       // ],
      //       bottom: AppBar(
      //         title: Container(
      //           width: double.infinity,
      //           height: 40,
      //           color: Colors.white,
      //           child: Center(
      //               child: TextField(
      //             decoration: InputDecoration(
      //                 hintText: 'search',
      //                 prefix: Icon(Icons.search),
      //                 suffixIcon: Icon(Icons.mic)),
      //           )),
      //         ),
      //       ),
      //     ),
      //     SliverGrid(
      //       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //         maxCrossAxisExtent: 200.0,
      //         mainAxisSpacing: 10.0,
      //         crossAxisSpacing: 10.0,
      //         childAspectRatio: 4.0,
      //       ),
      //       delegate: SliverChildBuilderDelegate(
      //         (BuildContext context, int index) {
      //           return Container(
      //             alignment: Alignment.center,
      //             color: Colors.teal[100 * (index % 9)],
      //             child: Text('grid item $index'),
      //           );
      //         },
      //         childCount: 20,
      //       ),
      //     )
      //   ],
      // ),
