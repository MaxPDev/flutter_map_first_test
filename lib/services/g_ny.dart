import 'package:http/http.dart';
import 'dart:convert'; // to user jsonDecode
import 'package:fr_piscadev_osmtest/models/parking.dart';
import 'dart:developer';

class GNy {
// late Parking parking;
  final List<Parking> parkings = [];

  GNy();

// Récupérer donnée parking depui g-ny, créer list d'objets parkings.
  Future<List<Parking>> getParkings() async {
    try {
      var uri = Uri.parse('https://go.g-ny.org/stationnement?output=json');
      Response resp = await get(uri);

      Map<String, dynamic> data = jsonDecode(resp.body);
      // List<Parking> parkings = data.map((data) => Parking.fromJson(data)).toList();
      // parkings = Parking.fromJson(jsonDecode(resp.body));
      // print(data);
      parkings.clear();
      data.forEach((key, value) {
        parkings.add(Parking.fromJson(data[key]));
      });
      // inspect(parkings);
      return parkings;

      // print(parkings);
    } catch (e) {
      print('caught errpr : $e');
      return parkings;
    }
  }

// Récupérer
}
