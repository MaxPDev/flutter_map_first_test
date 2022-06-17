import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:fr_piscadev_osmtest/models/parking.dart';
// import 'package:fr_piscadev_osmtest/services/g_ny.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fr_piscadev_osmtest/services/busOSM.dart';
import 'package:fr_piscadev_osmtest/services/velostan.dart';
import 'package:provider/provider.dart';
import 'package:fr_piscadev_osmtest/screens/homeScreen.dart';
import 'package:fr_piscadev_osmtest/services/g_ny.dart';

import 'dart:developer';

import 'package:sqflite/sqflite.dart';

void main() async {
  // await deleteDatabase('parkings.db');

  //* Mettre dans le provider les services.
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GNy(),
        ),
        ChangeNotifierProvider(
          create: (context) => Velostan(),
        ),
        ChangeNotifierProvider(
          create: (context) => BusOSM(),
        )
      ],
      child: MaterialApp(
        home: MapTest(),
      )));
}

class MapTest extends StatefulWidget {
  MapTest({Key? key}) : super(key: key);

  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  // ConnectionState.none: It means that the future is null and initialData is used as defaultValue.
  // ConnectionState.active: It means the future is not null but it is not resolved yet.
  // ConnectionState.waiting: It means the future is being resolved, and we will get the result soon enough.
  // ConnectionState.done: It means that the future has been resolved.

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
    // return SafeArea(
    //   child: Container(
    //       child: FutureBuilder(
    //           future: GNy().fetchParkings(),
    //           builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
    //             if (snapshot.connectionState == ConnectionState.waiting) {
    //               return CenteredCircularProgressIdicator();
    //             }
    //             if (snapshot.hasError) {
    //               return Text('Main Error: ${snapshot.error}');
    //               // If got data
    //             }
    //             // In this case, future methode is void, so homeScreen
    //             // = hasData()
    //             return HomeScreen();
    //         }
    //       )
    //     ),
    // );
  }
}

//# Version FuturBuilder 1 ok
// child: FutureBuilder(
//   future: GNy().fetchParkings(),
//   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//     switch (snapshot.connectionState) {
//       case ConnectionState.waiting:
//       return Center(
//         child: SizedBox(
//           height: 27,
//           width: 27,
//           child: CircularProgressIndicator()));

//         break;
//       default:
//         if (snapshot.hasError)
//           return Text('Main Error: ${snapshot.error}');
//         return HomeScreen();
//     }
//   },
// ),

//# Version FuturBuilder 2
//# maybe better, but doesn't work
// child: FutureBuilder(
//   future: GNy().fetchParkings(),
//   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//     // Check if futur is resolved
//     if (snapshot.connectionState == ConnectionState.done) {
//       // If got an error
//       if (snapshot.hasError) {
//         return Text('Main Error: ${snapshot.error}');
//       // If got data
//       } else if (snapshot.hasData) {
//         // In this case, future methode is void, so homeScreen
//         return HomeScreen();
//       }
//     }

//# Version FuturBuilder 3 (ok)
// child: FutureBuilder(
//     future: GNy().fetchParkings(),
//     builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return CenteredCircularProgressIdicator();
//       }
//       if (snapshot.hasError) {
//         return Text('Main Error: ${snapshot.error}');
//         // If got data
//       }
//       // In this case, future methode is void, so homeScreen
//       // = hasData()
//       return HomeScreen();
//   }
// )

//     // one case left : ConnectionState.waiting
//     //# can't have a if, we need a return whatever
//     // if (snapshot.connectionState == ConnectionState.waiting) {
//     return Center(
//       child: SizedBox(
//         height: 27,
//         width: 27,
//         child: CircularProgressIndicator(),
//         ));
//     // };
//   },
// ),

//   @override
//   Widget build(BuildContext context) {
//     return HomeScreen();
//   }
// }

class CenteredCircularProgressIdicator extends StatelessWidget {
  const CenteredCircularProgressIdicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 27, width: 27, child: CircularProgressIndicator()));
  }
}
