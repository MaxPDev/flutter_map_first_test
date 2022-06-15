// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fr_piscadev_osmtest/data/parking_database.dart';
import 'package:fr_piscadev_osmtest/models/velostan_carto.dart';
import 'package:fr_piscadev_osmtest/services/velostan.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fr_piscadev_osmtest/models/parking.dart';
import 'package:fr_piscadev_osmtest/services/g_ny.dart';
import 'package:fr_piscadev_osmtest/services/velostan.dart';
import 'package:fr_piscadev_osmtest/widgets/parkingPopup.dart';
import 'package:fr_piscadev_osmtest/widgets/veloPopup.dart';

import 'dart:developer';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final PopupController _popupController = PopupController(initiallySelectedMarkers: _markers);
  final MapController _mapController = MapController();

  final gny = Provider.of<GNy>;

  final velostan = Provider.of<Velostan>;

  bool isParkingsSelected = true;
  bool isBikeSelected = false;

  List<Marker> _markers = [];
  List<Marker> _parkingsMarkers = [];
  List<Marker> _veloMarkers = [];

  /**
   * Charge les parkings, les données dynamiques, et la créations des markers
   */
  _initParking() {
    gny(context, listen: false).fetchParkings().then((value) {
      gny(context, listen: false).fetchDynamicData().then((value) {
        gny(context, listen: false).createMarkers();
        setSelectedMarkers();
      });
    });
  }

  _initVelostanStations() {
    velostan(context, listen: false).fetchVelostanCarto().then((value) {
      velostan(context, listen: false).createMarkers();
    });
  }

  //todo event. gérer la liste des marker et leurs MAJ autrement. Choisir la solution des variables ?
  void setSelectedMarkers() {
    _markers.clear();

    if (this.isBikeSelected) {
      _markers.addAll(velostan(context, listen: false).getStationsMarkers());
      _veloMarkers = velostan(context, listen: false).getStationsMarkers();
    } else {
      _markers.clear();
    }

    if (this.isParkingsSelected) {
      // print(isParkingsSelected);
      _markers.addAll(gny(context, listen: false).getParkingsMarkers());
      _parkingsMarkers = gny(context, listen: false).getParkingsMarkers();
    }

    print("setSelectedMarkers()");
    inspect(_markers);
    setState(() {});

    // return _markers;
  }
  // final List<LatLng> _latLngList = [
  //   LatLng(48.647956, 6.144231),
  //   LatLng(48.703904, 6.176262),
  //   LatLng(48.696855, 6.170692),
  //   LatLng(48.694655, 6.177156),
  //   LatLng(48.693182, 6.177806),
  //   LatLng(48.694746, 6.184181),
  // ];

  // List<Marker> _markers = [];
  // List<Parking> parkings = [];

  @override
  initState() {
    // // seulement première fois
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<GNy>(context, listen: false).fetchParkings()
    //     .then((value) {
    //       Provider.of<GNy>(context, listen: false).createMarkers();
    //     });
    // //   _initProcess();

    // });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Provider.of<GNy>(context, listen: false).fetchParkings()
      //   .then((value) {
      //     Provider.of<GNy>(context, listen: false).createMarkers();
      //   });

      _initParking();
      _initVelostanStations();
      // _parkingsMarkers = gny(context, listen: false).getParkingsMarkers();
    });
    // TODO: implement initState
    super.initState();

    // Future.delayed(Duration.zero, () async {
    //     Provider.of<GNy>(context, listen: false).fetchParkings()
    //   .then((value) {
    //     Provider.of<GNy>(context, listen: false).createMarkers();
    //   });
    // });

    // void didChangeDependencies() {
    //     Provider.of<GNy>(context, listen: false).fetchParkings()
    //       .then((value) {
    //         Provider.of<GNy>(context, listen: false).createMarkers();
    //       });

    //   super.didChangeDependencies();
    // }
    //! adresse finding

    // if(mounted) {
    //     Provider.of<GNy>(context, listen: false).fetchParkings()
    //     .then((value) {
    //        Provider.of<GNy>(context, listen: false).createMarkers();
    //     });
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ParkingDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nancy Stationnement Test"),
      ),
      body: Container(child: Consumer<GNy>(builder: (context, GNy, child) {
        return FlutterMap(
          mapController: _mapController,

          // - `center`- Mention the center of the map, it will be the center when the map starts.
          // - `bounds`- It can take a list of geo-coordinates and show them all when the map starts. If both bounds & center are provided, then bounds will take preference.
          // - `zoom`- It is used to mention the initial zoom.
          // - `swPanBoundary`/`nePanBoundary`- These are two geocoordinate points, which can be used to have interactivity constraints.
          // - Callbacks such as `onTap`/`onLongPress`/`onPositionChanged` can also be used.

          options: MapOptions(
              center: LatLng(48.6907359, 6.1825126),
              zoom: 14.0,
              // bounds: LatLngBounds(LatLng(48.6292781, 6.0974121), LatLng(48.7589048, 6.3322449)), //# affiche la zone en délimitant des coins
              interactiveFlags: InteractiveFlag.pinchZoom |
                  InteractiveFlag.drag, // not rotate
              plugins: [
                MarkerClusterPlugin(),
              ]),
          layers: [
            TileLayerOptions(
              minZoom: 1,
              maxZoom: 18,
              backgroundColor: Colors.black,
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
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
                fitBoundsOptions: FitBoundsOptions(padding: EdgeInsets.all(50)),
                markers: _markers.toList(),
                polygonOptions: PolygonOptions(
                    borderColor: Colors.blueAccent,
                    color: Colors.black12,
                    borderStrokeWidth: 3),
                popupOptions: PopupOptions(
                    popupSnap: PopupSnap.markerTop,
                    popupController: isParkingsSelected
                        ? PopupController(
                            initiallySelectedMarkers: _parkingsMarkers)
                        : PopupController(), //!switch case ici + afficher les popup lors d'un certain zoom
                    // popupAnimation: PopupAnimation.fade(duration: Duration(milliseconds: 700), curve: Curves.ease), //! dosn't work with controller. Who cares
                    popupBuilder: (_, marker) {
                      if (isParkingsSelected && !isBikeSelected) {
                        return ParkingPopup(markers: _markers, marker: marker);
                      } else if (isBikeSelected && !isParkingsSelected) {
                        // VelostanCarto station = velostan(context, listen: false).getVelostationFromCoordinates(marker.point);
                        // inspect(station)
                        //? Probablement pas besoin des _veloMarkers en parm dans veloPopup
                        return veloPopup(veloMarkers: _veloMarkers, marker: marker);
                      } else {
                        return Text("prévoir ce cas");
                      }
                    }),
                builder: (context, markers) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 69, 66, 241),
                        shape: BoxShape.circle),
                    child: Text('${markers.length}',
                        style: TextStyle(
                            color: Color.fromARGB(255, 233, 228, 228))),
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
        );
      })),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(235, 241, 238, 49),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.directions_walk_outlined)),
            IconButton(
                onPressed: () {
                  setState(() {
                    isBikeSelected = isBikeSelected ? false : true;
                    setSelectedMarkers();
                  });
                },
                icon: Icon(Icons.pedal_bike_rounded)),
            IconButton(onPressed: () {}, icon: Icon(Icons.bus_alert)),
            IconButton(
                onPressed: () {
                  setState(() {
                    isParkingsSelected = isParkingsSelected ? false : true;
                    setSelectedMarkers();
                  });
                },
                icon: Icon(Icons.local_parking_outlined)),
            IconButton(
                onPressed: () {
                  // // GNy().fetchParkings().then((resp) => setState(() {
                  // //       parkings = Provider.of<GNy>(context).getParkings();
                  // //       _markers.clear();
                  // //       _markers = getMarkers().toList();
                  //   // //     }));
                  //   gny(context, listen: false).fetchParkings().then(
                  //         (value) => gny(context, listen: false).createMarkers(),
                  //       );
                  // },
                  setState(() {
                    gny(context, listen: false).fetchDynamicData();
                  });
                },
                icon: Icon(Icons.data_exploration_sharp)),
          ],
        ),
      ),
    );
  }
}
