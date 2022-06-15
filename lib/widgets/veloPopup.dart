import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fr_piscadev_osmtest/models/velostan_carto.dart';
import 'package:fr_piscadev_osmtest/models/velostan_station.dart';
import 'package:fr_piscadev_osmtest/services/velostan.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:provider/provider.dart';

class veloPopup extends StatelessWidget {
  const veloPopup({
    Key? key,
    required List<Marker> veloMarkers,
    required Marker marker,
    // required VelostanCarto station,
  }) : _veloMarkers = veloMarkers, _marker = marker, super(key: key);

  final List<Marker> _veloMarkers;
  final Marker _marker;
  // final VelostanCarto _station;

  @override
  Widget build(BuildContext context) {
    VelostanCarto stationVelo = 
      Provider.of<Velostan>(context, listen: false).getVelostationFromCoordinates(_marker.point);

    // VelostanSation stationDynamicData = 
    //   Provider.of<Velostan>(context, listen: false).getStationDynamicData(stationVelo.id);

    Provider.of<Velostan>(context, listen: false).fetchVelostanStation(stationVelo.id!);

    return Container(
        alignment: Alignment.center,
        height: 50,
        width: 70,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 81, 189, 108), shape: BoxShape.rectangle),
        child: GestureDetector(
          // onTap: () => PopupController(
          //     initiallySelectedMarkers:
          //         _veloMarkers), 
          onTap: () => inspect(_marker),
          child: Text(
            // penser à mettre à jour ceci, alors que marker sont fixe (mise à jour plus rarement, et ceux affichés doivent être issues de la BD)
            "widget velo to do ${stationVelo.name}",
            style: TextStyle(
                color: Colors.white, fontSize: 10),
          ),
        ));
  }
}


