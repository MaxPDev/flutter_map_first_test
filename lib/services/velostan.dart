import 'dart:developer';
import 'package:fr_piscadev_osmtest/data/velostan_database.dart';
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
  // Contrairement à Parking, peut-être qu'une seule variable est suffisante
  // Je laisse deux au cas (switch avec JC Decaux)
  static List<VelostanCarto> _stationsFromAPI = [];
  static List<VelostanCarto> _stations = [];
  List<Marker> _stationsMarkers = [];
  late VelostanSation _stationDynamicData;
  // String stationIdFromPopupSelected = ""; // se souvenir de la popup active pour faire condition et éviter multiples requêtes. Contournement.

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
      // toBadgerFish() permet de récupérer facilement les attribut (voir doc de xml2json)
      String respJson = xml2json.toBadgerfish();

      // De Json à Map
      Map<String, dynamic> data = jsonDecode(respJson);

      await VelostanDatabase.instance.deleteDatabase('velostan.db');
      // Nettoyage de _stations, et remplissage de la liste avec les objets
      _stations.clear();
      _stationsFromAPI.clear();
      for (var station in data['carto']['markers']['marker']) {
        _stationsFromAPI.add(VelostanCarto.fromAPIJson(station));
        // print(data['carto']['markers']['marker']);
      }
      await velostanCartoToDatabase();
      _stations = await VelostanDatabase.instance.getAllVelostanCarto();
      // print("fetchVelostanCarto + intro DB : ${_stations.length}");
      notifyListeners();
    } catch (e) {
      print('Caught error for velostan carto fetch : $e');
    }
  }

  Future<void> fetchVelostanStation(String stationID) async {
    try {
      var uri = Uri.parse('$_uriStation' + '$stationID');
      Response resp = await get(uri);

      // Conversion xml en json
      final Xml2Json xml2json = Xml2Json();
      xml2json.parse(resp.body);
      // toParker() permet de récupérer facilement les valeurs (voir doc de xml2json)
      String respJson = xml2json.toParker();

      // De Json à Map
      Map<String, dynamic> data = jsonDecode(respJson);
      _stationDynamicData = VelostanSation.fromAPIJson(data['station']);

      // print(data['station']);
      // inspect(_stationDynamicData);
      
    } catch (e) {
      print('Caught error for velostan station fetch : $e');
    }
  }

  Future velostanCartoToDatabase() async {
    _stationsFromAPI.forEach((VelostanCarto) async {
      // createVelostanCarto : void ? ou test ?
      var id =
          await VelostanDatabase.instance.createVelostanCarto(VelostanCarto);
      // print(id.toStringKC());
    });
  }

  List<VelostanCarto> getVelostanSations() {
    // print("getVelostanStation");
    return _stations;
  }

  Future<VelostanSation> getStationDynamicData() async { 
    return _stationDynamicData;
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
                color: Color.fromARGB(255, 14, 179, 99),
              )));
    }
    // inspect(markers);
    _stationsMarkers.clear();
    _stationsMarkers = markers;
    // print("CreateMarker Stations Velo ${_stationsMarkers.length}");
    // notifyListeners();
  }

  Future<VelostanCarto> getVelostationFromCoordinates(LatLng point) async {
    VelostanCarto stationPopup = _stations.firstWhere((station) =>
        station.lat == point.latitude &&
        station.lng == point.longitude);
    // inspect(stationPopup);
    // fetchVelostanStation('${stationPopup.id}');
    // notifyListeners();
    return stationPopup;
  }

  List<Marker> getStationsMarkers() {
    // print("getMarker Stations Velo");
    return _stationsMarkers;
  }
}
