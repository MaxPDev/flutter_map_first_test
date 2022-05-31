class Parking {

  final String? id;
  final int? osmId;
  final String? name;
  final List<double> geometryCoordinates;
  final dynamic capacity;
  final int? mgnAvailable;
  final String? uiColorEn;


  const Parking({
    this.id,
    this.osmId,
    this.name,
    required this.geometryCoordinates,
    this. capacity,
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
  }) => Parking(
    id: id ?? this.id, 
    osmId: osmId ?? this.osmId, 
    name: name ?? this.name, 
    geometryCoordinates: geometryCoordinates ?? this.geometryCoordinates,
    capacity: capacity ?? this.capacity,
    mgnAvailable: mgnAvailable ?? this.mgnAvailable,
    uiColorEn: uiColorEn ?? this.uiColorEn);

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json["id"] == null ? null : json["id"], 
      osmId: json["osm.id"] == null ? null : json["osm.id"], 
      name: json["name"] == null ? null : json["name"],
      geometryCoordinates: List<double>.from(json["geometry.coordinates"].map((x) => x.toDouble())),
      // geometryCoordinates: json["geometry.coordinates"] == null ? null : List<double>.from(json["geometry.coordinates"].map((x) => x.toDouble())),
      capacity: json["capacity"] == null ? null : json["capacity"],
      mgnAvailable: json["mgn:available"] == null ? null : json["mgn:available"],
      uiColorEn: json["ui:color_en"] == null ? null : json ["ui:color_en"],
    );
  }
  
}