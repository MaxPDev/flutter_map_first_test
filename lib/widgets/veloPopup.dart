import 'package:flutter/material.dart';
import 'package:fr_piscadev_osmtest/services/velostan.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class veloPopup extends StatelessWidget {
  const veloPopup({
    Key? key,
    required List<Marker> veloMarkers,
  }) : _veloMarkers = veloMarkers, super(key: key);

  final List<Marker> _veloMarkers;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 50,
        width: 70,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 81, 189, 108), shape: BoxShape.rectangle),
        child: GestureDetector(
          onTap: () => PopupController(
              initiallySelectedMarkers:
                  _veloMarkers), //! ou pas
          child: Text(
            // penser à mettre à jour ceci, alors que marker sont fixe (mise à jour plus rarement, et ceux affichés doivent être issues de la BD)
            "widget velo to do",
            style: TextStyle(
                color: Colors.white, fontSize: 10),
          ),
        ));
  }
}


