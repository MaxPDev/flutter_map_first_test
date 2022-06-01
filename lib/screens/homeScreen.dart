// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fr_piscadev_osmtest/models/parking.dart';
import 'package:fr_piscadev_osmtest/services/g_ny.dart';

import 'dart:developer';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = true;


  // final PopupController _popupController = PopupController(initiallySelectedMarkers: _markers);
  final MapController _mapController = MapController();

  // final List<LatLng> _latLngList = [
  //   LatLng(48.647956, 6.144231),
  //   LatLng(48.703904, 6.176262),
  //   LatLng(48.696855, 6.170692),
  //   LatLng(48.694655, 6.177156),
  //   LatLng(48.693182, 6.177806),
  //   LatLng(48.694746, 6.184181),
  // ];

  List<Marker> _markers = [];
  List<Parking> parkings= [];

  /**
   * Construit les markers depuis les coordonnées des objets parkings.
   */
  List<Marker> getMarkers() {
    List<Marker> markers = [];
    for (var parking in parkings) {
      markers.add(Marker(
        //? attention point ne peux pas LatLng?, alors coordinates en required.
        //! Si coordonnées pas définit, plantage de toute l'appli ?
        point: LatLng(parking.geometryCoordinates[1], parking.geometryCoordinates[0]),
        width: 30,
        height: 30,
        builder: (context) => Icon(
          FontAwesomeIcons.squareParking,
          size: 30,
          color: Colors.blueAccent,
        )));
    }
    inspect(markers);
    return markers;
  }


  /**
   * Récupère et rénvoie la propriété available depuis les coordonnées
   */
  //! Contournement
  int? getAvailableFromCoordinates(LatLng point) {
    Parking parkingPopup = parkings.firstWhere((parking) 
      => parking.geometryCoordinates[1] 
        == point.latitude && parking.geometryCoordinates[0] == point.longitude);
    return parkingPopup.mgnAvailable;
  }

  /**
   * Récupère et rénvoie la propriété uiColor_en depuis les coordonnées
   */
  //! Contournement
  Color? getColorFromCoordinates(LatLng point) {
    Parking parkingPopup = parkings.firstWhere((parking) 
      => parking.geometryCoordinates[1] 
        == point.latitude && parking.geometryCoordinates[0] == point.longitude);

    switch (parkingPopup.uiColorEn) {
      case "blue": {
        return Colors.blue;
      }

      case "orange": {
        return Colors.orange;
      }

      case "green": {
        return Colors.green;
      }

      case "red": {
        return Colors.red;
      }

      default: {
        return Colors.black;
      }
    }
  }
  

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    // Récupère les parkings
    parkings = GNy().getParkings();

    // Nettoie la liste des markers, et la remplie
    _markers.clear(); //! à réfléchir dans la vraie app, genre rajouter si nouveau
    _markers = getMarkers().toList();

    // fait récupérer les parkings
    // getParkings();

    // _markers = _latLngList
    //     .map((point) => Marker(
    //           point: point,
    //           width: 60,
    //           height: 60,
    //           builder: (context) => Icon(
    //             Icons.pin_drop,
    //             size: 60,
    //             color: Colors.blueAccent,
    //           ),
    //         ))
    //     .toList();
  }

  //! adresse finding

  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Nancy Stationnement Test"),
      ),
      body: Container(
        child: FlutterMap(
          mapController: _mapController,



          // - `center`- Mention the center of the map, it will be the center when the map starts.
          // - `bounds`- It can take a list of geo-coordinates and show them all when the map starts. If both bounds & center are provided, then bounds will take preference.
          // - `zoom`- It is used to mention the initial zoom.
          // - `swPanBoundary`/`nePanBoundary`- These are two geocoordinate points, which can be used to have interactivity constraints.
          // - Callbacks such as `onTap`/`onLongPress`/`onPositionChanged` can also be used.

          options:
              MapOptions(
                center: LatLng(48.6907359, 6.1825126), 
                zoom: 14.0, 
                // bounds: LatLngBounds(LatLng(48.6292781, 6.0974121), LatLng(48.7589048, 6.3322449)), //# affiche la zone en délimitant des coins
                interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag, // not rotate
                plugins: [MarkerClusterPlugin(),
                ]),
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

                popupOptions: PopupOptions(
                  popupSnap:  PopupSnap.markerTop,
                  popupController: PopupController(initiallySelectedMarkers: _markers), //!switch case ici + afficher les popup lors d'un certain zoom
                  // popupAnimation: PopupAnimation.fade(duration: Duration(milliseconds: 700), curve: Curves.ease), //! dosn't work with controller. Who cares
                  popupBuilder: (_, marker) => Container(
                    alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: getColorFromCoordinates(marker.point), shape: BoxShape.circle),
                      child: GestureDetector(
                        onTap: () => PopupController(initiallySelectedMarkers: _markers), //! ou pas
                        child: Text(
                          "${getAvailableFromCoordinates(marker.point)}",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      )
                      ),
                  
                ),
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
          bottomNavigationBar: BottomAppBar(
      color: Color.fromARGB(235, 241, 238, 49),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.directions_walk_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.pedal_bike_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.bus_alert)),
          IconButton(onPressed: () {}, icon: Icon(Icons.local_parking_outlined)),
          // IconButton(onPressed: () {GNy().fetchParkings() ;setState(() {
            
          // });}, icon: Icon(Icons.data_exploration_sharp)),
        ],
      ) ,
    ),
    );
  }
}