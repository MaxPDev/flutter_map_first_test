import 'dart:developer';
import 'package:http/http.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fr_piscadev_osmtest/models/velostan_carto.dart';
import 'package:fr_piscadev_osmtest/models/velostan_station.dart';

class Velostan extends ChangeNotifier {

  static final List<VelostanCarto> _stations = [];
  late VelostanSation _selectedStation; 

  // Récupère markers des stations avec nom, adresse, coordonnées...
  static const String _uriCarto = 'http://www.velostanlib.fr/service/carto';

  // Récupère les infor pour une station
  static const String _uriStation = 'http://www.velostanlib.fr/service/stationdetails/nancy/';

  Velostan() {
    print("velostan constructor");
  }

  /**
   * Récupérer les données depuis velostan
   */
  Future<void> fetchVelostanCarto() async{

    try {
      var uri = Uri.parse(_uriCarto);
      Response resp = await get(uri);

      // Conversion xml en json
      final Xml2Json xml2json = Xml2Json();
      xml2json.parse(resp.body);
      String respJson = xml2json.toBadgerfish();
      Map<String, dynamic> data = jsonDecode(respJson);
      print(data['carto']['markers']['marker']);

    } catch (e) {
      print('Caught error for velostan carto fetch : $e');
    }

  }
  
}