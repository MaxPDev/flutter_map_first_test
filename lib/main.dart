import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:fr_piscadev_osmtest/models/parking.dart';
// import 'package:fr_piscadev_osmtest/services/g_ny.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fr_piscadev_osmtest/screens/homeScreen.dart';
import 'package:fr_piscadev_osmtest/services/g_ny.dart';

import 'dart:developer';


void main() {
  runApp(MaterialApp(
    home: MapTest(),
  ));
}

class MapTest extends StatefulWidget {
  MapTest({Key? key}) : super(key: key);

  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: FutureBuilder(
          future: GNy().fetchParkings(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              return Center(
                child: SizedBox(
                  height: 27,
                  width: 27,
                  child: CircularProgressIndicator()));
                
                break;
              default:
                if (snapshot.hasError)
                  return Text('Main Error: ${snapshot.error}');
                return HomeScreen();
            }
          },
        ),
      ),
    );
  }
}

// tester autre structure du fulturebuilder !



//   @override
//   Widget build(BuildContext context) {
//     return HomeScreen();
//   }
// }

