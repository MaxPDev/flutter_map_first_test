import 'dart:convert';

final String tableParkings = "parkings";

class ParkingFields {
  static final List<String> values = [
    id,
    osmId,
    name,
    geometryCoordinates,
    capacity,
    uiColorEn
  ];

  static final String id = "_id";
  static final String osmId = "osmId";
  static final String name = "name";
  static final String geometryCoordinates = " geometryCoordinates";
  static final String capacity = "capacity";
  static final String uiColorEn = "uiColorEn";
}

class Parking {
  final String? id;
  final int? osmId;
  final String? name;
  final List<double> geometryCoordinates;
  final dynamic capacity;
  int? mgnAvailable;
  String? uiColorEn;

  //! pas const pour pas être obligé de mettre final aux attribut,
  //! pour pouvoir les changer
  Parking(
      {this.id,
      this.osmId,
      this.name,
      required this.geometryCoordinates,
      this.capacity,
      this.mgnAvailable,
      this.uiColorEn});

  Parking copyWith({
    String? id,
    int? osmId,
    String? name,
    List<double>? geometryCoordinates,
    dynamic? capacity,
    int? mgnAvailable,
    String? uiColorEn,
  }) =>
      Parking(
          id: id ?? this.id,
          osmId: osmId ?? this.osmId,
          name: name ?? this.name,
          geometryCoordinates: geometryCoordinates ?? this.geometryCoordinates,
          capacity: capacity ?? this.capacity,
          mgnAvailable: mgnAvailable ?? this.mgnAvailable,
          uiColorEn: uiColorEn ?? this.uiColorEn);

  // Récupérer depuis API
  factory Parking.fromAPIJson(Map<String, dynamic> json) {
    return Parking(
      id: json["id"] == null ? null : json["id"],
      osmId: json["osm.id"] == null ? null : json["osm.id"],
      name: json["name"] == null ? null : json["name"],
      geometryCoordinates: List<double>.from(
          json["geometry.coordinates"].map((x) => x.toDouble())),
      // geometryCoordinates: List<double>.from(
      //     json["geometry.coordinates"].map((x) => x.toDouble())),
      // geometryCoordinates: json["geometry.coordinates"] == null ? null : List<double>.from(json["geometry.coordinates"].map((x) => x.toDouble())),
      capacity: json["capacity"] == null ? null : json["capacity"],
      mgnAvailable:
          json["mgn:available"] == null ? null : json["mgn:available"],
      uiColorEn: json["ui:color_en"] == null ? null : json["ui:color_en"],
    );
  }

  // static from json to database without available
  factory Parking.fromDBJson(Map<String, dynamic> json) {
    return Parking(
      id: json["_id"] == null ? null : json["_id"],
      osmId: json["osmId"] == null ? null : json["osmId"],
      name: json["name"] == null ? null : json["name"],
      // geometryCoordinates: List<double>.from(
      //     json["geometryCoordinates"].map((x) => x.toDouble())),
      geometryCoordinates: List<double>.from(
          jsonDecode(json["geometryCoordinates"]).map((x) => x.toDouble())),
      // geometryCoordinates: json["geometry.coordinates"] == null ? null : List<double>.from(json["geometry.coordinates"].map((x) => x.toDouble())),
      capacity: json["capacity"] == null ? null : json["capacity"],
      // mgnAvailable:
          // json["mgn:available"] == null ? null : json["mgn:available"],
      uiColorEn: json["uiColorEn"] == null ? null : json["uiColorEn"],
    );
  }

  

  //! jsEncode / jsDecode dans geometryCoordinate pour les list

  // for database. Available not useful
  Map<String, Object?> toJson() => {
        ParkingFields.id: id,
        ParkingFields.osmId: osmId,
        ParkingFields.name: name,
        ParkingFields.geometryCoordinates: jsonEncode(geometryCoordinates),
        // ParkingFields.geometryCoordinates: jsonEncode(geometryCoordinates),
        ParkingFields.capacity: capacity,
        ParkingFields.uiColorEn: uiColorEn
      };
}
