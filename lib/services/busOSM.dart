import 'dart:developer';
import 'package:http/http.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fr_piscadev_osmtest/models/overpass_query.dart';
import 'package:fr_piscadev_osmtest/services/overpassAPI.dart';

class BusOSM extends ChangeNotifier {

  // static List<Bus> _busFromAPI = [];
  // static List<Bus> _bus = [];
  List<Marker> _busMarkers = [];

  static const _uriBusOsm = '';

  //todo sera une variable globales
  static final String bbox = "48.522,5.813,48.859,6.569";

  OverpassQuery _overpassQuery = 
    OverpassQuery(output: "json", 
                 timeout: "25",
                 bbox: bbox);

  BusOSM() {
    print("BusOSM Constructor");
  }

  Future<void> fetchBusOSM() async {
    try {
      String requestBody = _overpassQuery.buildBodyRequestNodeOut("public_transport", "stop_position");
      String response = await OverpassAPI.fetch(requestBody);
      print(response);
      
    } catch (e) {
      print('Caught error for busOSM carto fetch : $e');
    }
  }








}