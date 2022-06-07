import 'dart:developer';
import 'package:http/http.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fr_piscadev_osmtest/models/velostan_carto.dart';
import 'package:fr_piscadev_osmtest/models/velostan_station.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Velostan extends ChangeNotifier {
  static final List<VelostanCarto> _stations = [];
  List<Marker> _stationsMarkers = [];
  late VelostanSation _selectedStation;

  // Récupère markers des stations avec nom, adresse, coordonnées...
  static const String _uriCarto = 'http://www.velostanlib.fr/service/carto';

  // Récupère les infor pour une station
  static const String _uriStation =
      'http://www.velostanlib.fr/service/stationdetails/nancy/';

  Velostan() {
    print("velostan constructor");
  }

  /**
   * Récupérer les données depuis velostan
   */
  Future<void> fetchVelostanCarto() async {
    try {
      var uri = Uri.parse(_uriCarto);
      Response resp = await get(uri);

      // Conversion xml en json
      final Xml2Json xml2json = Xml2Json();
      xml2json.parse(resp.body);
      String respJson = xml2json.toBadgerfish();

      // De Json à Map
      Map<String, dynamic> data = jsonDecode(respJson);

      // Nettoyage de _stations, et remplissage de la liste avec les objets
      _stations.clear();
      for (var station in data['carto']['markers']['marker']) {
        _stations.add(VelostanCarto.fromJson(station));
      }

      print(_stations.length);
      notifyListeners();
    } catch (e) {
      print('Caught error for velostan carto fetch : $e');
    }
  }

  List<VelostanCarto> getVelostanSations() {
    print("getVelostanStation");
    return _stations;
  }

  /**
   * Construit les markers depuis les coordonnées des objets parkings.
   */
  void createMarkers() {
    List<Marker> markers = [];
    for (var station in _stations) {
      markers.add(Marker(
          //? attention point ne peux pas LatLng?, alors coordinates en required.
          //! Si coordonnées pas définit, plantage de toute l'appli ?
          point: LatLng(station.lat, station.lng),
          width: 30,
          height: 30,
          builder: (context) => Icon(
                FontAwesomeIcons.bicycle,
                size: 30,
                color: Colors.greenAccent,
              )));
    }
    inspect(markers);
    _stationsMarkers.clear();
    _stationsMarkers = markers;
    print("CreateMarker Stations Velo ${_stationsMarkers.length}");
    // notifyListeners();
  }

  List<Marker> getStationsMarkers() {
    print("getMarker Stations Velo");
    return _stationsMarkers;
  }
}
