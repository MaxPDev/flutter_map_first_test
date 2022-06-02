import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert'; // to user jsonDecode
import 'package:fr_piscadev_osmtest/models/parking.dart';
import 'dart:developer';

class GNy extends ChangeNotifier {
// late Parking parking; // static surtout pour fichier data ?
  static final List<Parking> _parkings = [];

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
      _parkings.clear();
      data.forEach((key, value) {
        _parkings.add(Parking.fromJson(data[key]));
      });

      notifyListeners();
    } catch (e) {
      print('caught error for GNy.fetchParkings() : $e');
    }
  }

  List<Parking> getParkings() {
    return _parkings;
  }

  //   // récupère les parkings et le met dans la variable
  // Future<void> getParkings() async {
  //   parkings = await GNy().getParkings();
  //   // inspect(parkings);
  //   await getMarkers();
  //   // inspect(_markers);
  // }




// Récupérer
}
