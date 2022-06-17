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
  })  : _veloMarkers = veloMarkers,
        _marker = marker,
        super(key: key);

  final List<Marker> _veloMarkers;
  final Marker _marker;
  // final VelostanCarto _station;

  @override
  Widget build(BuildContext context) {
    VelostanCarto _stationData = new VelostanCarto(lat: 0, lng: 0);
    VelostanSation _stationDynamicData = new VelostanSation();

    /**
     * Initialise les données nécessaire pour remplir la popup des stations vélo
     * Le code est regroupé dans cette fonction pour être moins verbeux dans l'utilisation du futureBuilder
     */
    Future<void> _initStationDataPopup() async {
      if (_stationData.id == null) {
        // Récupère les données de la station
        await Provider.of<Velostan>(context, listen: false)
            .getVelostationFromCoordinates(_marker.point)
            .then((stationData) async {
          // // get previoud station id popup selected :
          // String oldId = Provider.of<Velostan>(context, listen: false)
          //   .stationIdFromPopupSelected;

          // if(stationData.id != oldId) {
          // print("station id already set, station id received :");
          // print(oldId);
          // print(stationData.id);

          // // Stock l'id de la station pour pouvoir la comparer
          // Provider.of<Velostan>(context, listen: false)
          //   .stationIdFromPopupSelected = stationData.id!;

          // une fois reçu, les stock dans la variable
          _stationData = stationData;

          // Avec l'id de la station, active le fetch des data dynamiques de la station
          await Provider.of<Velostan>(context, listen: false)
              .fetchVelostanStation(stationData.id!)
              .then((value) async {
            // Puis récupère la variable. Cet étape est séparée de la précédente,
            // pour pouvoir fetcher séparemment au besoin
            await Provider.of<Velostan>(context, listen: false)
                .getStationDynamicData()
                .then((stationDynamicData) {
              _stationDynamicData = stationDynamicData;
            });

            inspect(_stationDynamicData);
          });
          // } //if
        });
      }
    }

    return Column(
      //TODO: Rattrape le fait que la popup s'affiche  en haut de l'écran au lieu de topMarker
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
            // onTap: () => PopupController(
            //     initiallySelectedMarkers:
            //         _veloMarkers),
            onTap: () => inspect(_marker),
            child: FutureBuilder(
              future: _initStationDataPopup(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Main Error: ${snapshot.error}');
                  // If got data
                }
                // In this case, future methode is void, so homeScreen
                // = hasData()
                return StationPopup(
                    stationData: _stationData,
                    stationDynamicData: _stationDynamicData);
              },
            )),
      ],
    );
  }
}

class StationPopup extends StatelessWidget {
  const StationPopup({
    Key? key,
    required VelostanCarto stationData,
    required VelostanSation stationDynamicData,
  })  : _stationData = stationData,
        _stationDynamicData = stationDynamicData,
        super(key: key);

  final VelostanCarto _stationData;
  final VelostanSation _stationDynamicData;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Color.fromARGB(255, 161, 219, 176),
      title: Text(
        "${_stationData.name}",
        textDirection: TextDirection.ltr,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      children: <Widget>[
        SimpleDialogOption(
          child: Text(
            "Velo disponible : ${_stationDynamicData.available}",
            style: TextStyle(color: Colors.black),
          ),
        ),
        SimpleDialogOption(
          child: Text("Emplacements libre : ${_stationDynamicData.free}"),
        )
      ],
    );
  }
}
