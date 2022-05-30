class Parking {

  final String? id;
  final int? osmId;
  final String? name;
  final List<double>? geometryCoordinates;
  final dynamic capacity;
  final int? mgnAvailable;
  final String? uiColor;


  const Parking({
    this.id,
    this.osmId,
    this.name,
    this.geometryCoordinates,
    this. capacity,
    this.mgnAvailable,
    this.uiColor});

  Parking copyWith({
    String? id,
    int? osmId,
    String? name,
    List<double>? geometryCoordinates,
    dynamic? capacity,
    int? mgnAvailable,
    String? uiColor,
  }) => Parking(
    id: id ?? this.id, 
    osmId: osmId ?? this.osmId, 
    name: name ?? this.name, 
    geometryCoordinates: geometryCoordinates ?? this.geometryCoordinates,
    capacity: capacity ?? this.capacity,
    mgnAvailable: mgnAvailable ?? this.mgnAvailable,
    uiColor: uiColor ?? this.uiColor);

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json["id"] == null ? null : json["id"], 
      osmId: json["osm.id"] == null ? null : json["osm.id"], 
      name: json["name"] == null ? null : json["name"],
      geometryCoordinates: json["geometry.coordinates"] == null ? null : List<double>.from(json["geometry.coordinates"].map((x) => x.toDouble())),
      capacity: json["capacity"] == null ? null : json["capacity"],
      mgnAvailable: json["mgn:available"] == null ? null : json["mgn:available"],
      uiColor: json["ui:Color"] == null ? null : json ["ui:color"],
    );
  }
  
}