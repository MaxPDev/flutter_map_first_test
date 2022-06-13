import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fr_piscadev_osmtest/data/parking_database.dart';
import 'package:http/http.dart';
import 'dart:convert'; // to user jsonDecode
import 'package:fr_piscadev_osmtest/models/parking.dart';
import 'dart:developer';

import 'package:latlong2/latlong.dart';

class GNy extends ChangeNotifier {
// late Parking parking; // static surtout pour fichier data ?
  static List<Parking> _parkingsFromAPI = [];
  static List<Parking> _parkings = [];
  List<Marker> _markers = [];

  GNy() {
    print("gny constructor");
  }

// Récupérer donnée parking depui g-ny, créer list d'objets parkings.
/**
 * Récupérer les données de parkings depuis go.g-ny.org
 */
  Future<void> fetchParkings() async {
    try {
      var uri = Uri.parse('https://go.g-ny.org/stationnement?output=json');
      Response resp = await get(uri);

      Map<String, dynamic> data = jsonDecode(resp.body);
      // List<Parking> parkings = data.map((data) => Parking.fromJson(data)).toList();
      // parkings = Parking.fromJson(jsonDecode(resp.body));
      // print(data);
      await ParkingDatabase.instance.deleteDatabase('parkings.db');
      _parkingsFromAPI.clear();
      _parkings.clear();
      data.forEach((key, value) {
        _parkingsFromAPI.add(Parking.fromAPIJson(data[key]));
      });
      await parkingsToDatabase();
      _parkings = await ParkingDatabase.instance.getAllParking();
      print("fetchParking ${_parkings.length}");
      notifyListeners();
    } catch (e) {
      print('caught error for GNy.fetchParkings() : $e');
    }
  }

  Future parkingsToDatabase() async {
    int counter = 0;
    _parkingsFromAPI.forEach((parking) async {
      var id = await ParkingDatabase.instance.createParking(parking);
      // print('ID du parking ajouté dans la bd :');
      // inspect(id);
      String id_str = id.toString();
      print(id_str);
      // print(p);
    });
  }

  List<Parking> getParkings() {
    // await fetchParkings();
    // notifyListeners();
    print("getParking ${_parkings.length}");
    return _parkings;
  }

  //   // récupère les parkings et le met dans la variable
  // Future<void> getParkings() async {
  //   parkings = await GNy().getParkings();
  //   // inspect(parkings);
  //   await getMarkers();
  //   // inspect(_markers);
  // }

  /**
   * Construit les markers depuis les coordonnées des objets parkings.
   */
  void createMarkers() {
    List<Marker> markers = [];
    for (var parking in _parkings) {
      markers.add(Marker(
          //? attention point ne peux pas LatLng?, alors coordinates en required.
          //! Si coordonnées pas définit, plantage de toute l'appli ?
          point: LatLng(
              parking.geometryCoordinates[1], parking.geometryCoordinates[0]),
          width: 30,
          height: 30,
          builder: (context) => Icon(
                FontAwesomeIcons.squareParking,
                size: 30,
                color: Colors.blueAccent,
              )));
    }
    // inspect(markers);
    _markers.clear();
    _markers = markers;
    // print("CreateMarker Parking ${_markers.length}");
    // notifyListeners();
  }

  List<Marker> getParkingsMarkers() {
    // print("getMarker Parking ${_markers.length}");
    return _markers;
  }

  /**
   * Récupère et rénvoie la propriété available depuis les coordonnées
   */
  //! Contournement
  int? getAvailableFromCoordinates(LatLng point) {
    Parking parkingPopup = _parkings.firstWhere((parking) =>
        parking.geometryCoordinates[1] == point.latitude &&
        parking.geometryCoordinates[0] == point.longitude);
    // notifyListeners();
    return parkingPopup.mgnAvailable;
  }

  /**
   * Récupère et rénvoie la propriété uiColor_en depuis les coordonnées
   */
  //! Contournement
  Color? getColorFromCoordinates(LatLng point) {
    Parking parkingPopup = _parkings.firstWhere((parking) =>
        parking.geometryCoordinates[1] == point.latitude &&
        parking.geometryCoordinates[0] == point.longitude);

    // notifyListeners();

    switch (parkingPopup.uiColorEn) {
      case "blue":
        {
          return Colors.blue;
        }

      case "orange":
        {
          return Colors.orange;
        }

      case "green":
        {
          return Colors.green;
        }

      case "red":
        {
          return Colors.red;
        }

      default:
        {
          return Colors.black;
        }
    }
  }

// Récupérer
}
