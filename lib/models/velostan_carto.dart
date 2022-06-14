final String tableVelostan = "velostan";

class VelostanFields {
  static final List<String> values = [
    id,
    name,
    address,
    lat,
    lng,
    open,
    bonus,
  ];

  static final String id = "_id";
  static final String name = "name";
  static final String address = "address";
  static final String lat = "lat";
  static final String lng = "lng";
  static final String open = "open";
  static final String bonus = "bonus";
  
}


class VelostanCarto {
  
  // essaie de tout en required. 
  //? Que se passe-t-il si le fetch récupère un attribut à null ?
  //todo tester la situation d'un attribut reçu à null

  final String? id; // number
  final String? name;
  final String? address;
  final double lat;
  final double lng;
  final bool? open;
  final bool? bonus;

  const VelostanCarto({
   this.id,
   this.name,
   this.address,
   required this.lat,
   required this.lng,
   this.open,
   this.bonus,
  });

  VelostanCarto copyWith({
    String? id, // number
    String? name,
    String? address,
    double? lat,
    double? lng,
    bool? open,
    bool? bonus,
  }) => VelostanCarto(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    lat: lat ?? this.lat, 
    lng: lng ?? this.lng,
    open: open ?? this.open,
    bonus: bonus ?? this.bonus
    );

    factory VelostanCarto.fromAPIJson(Map<String, dynamic> json) {
      // return VelostanCarto(
      //   // Exemple de rappel pour gérer le null :
      //   // id: json["id"] == null ? null : json["id"], 

      //   id: json["@number"] as String,
      //   name: json["@name"] as String,
      //   address: json["@address"] as String,
      //   // lat: json["@lat"].toDouble(), 
      //   // lng: json["@lng"].toDouble(),
      //   lat: double.parse(json["@lat"]),
      //   lng: double.parse(json["@lng"]),
      //   open: json["@open"] == 1,
      //   bonus: json["@bonus"] == 1
      //   );

        // Version nullable. Peut être plus safe car non bloquant pour l'appli.
      return VelostanCarto(
        // Exemple de rappel pour gérer le null :
        // id: json["id"] == null ? null : json["id"], 
        
        id: json["@number"] == null ? null : json["@number"]  as String,
        name: json["@name"] == null ? null : json["@name"] as String,
        address: json["@address"] == null ? null : json["@address"] as String,
        lat: double.parse(json["@lat"].toString()), 
        lng: double.parse(json["@lng"].toString()),
        // lat: json["@lat"] == null ? null : double.parse(json["@lat"]),
        // lng: json["@lng"] == null ? null : double.parse(json["@lng"]),
        open: json["@open"] == null ? null : json["@open"] == "1",
        bonus: json["@bonus"] == null ? null : json["@bonus"] == "1"
        );
    }

        factory VelostanCarto.fromDBJson(Map<String, dynamic> json) {
      return VelostanCarto(
        // Exemple de rappel pour gérer le null :
        // id: json["id"] == null ? null : json["id"], 

        id: json["_id"] == null ? null : json["_id"]  as String,
        name: json["name"] == null ? null : json["name"] as String,
        address: json["address"]== null ? null : json["address"] as String,
        lat: double.parse(json["lat"].toString()), 
        lng: double.parse(json["lng"].toString()),
        // lat: json["lat"] == null ? null : double.parse(json["lat"]),
        // lng: json["lng"] == null ? null : double.parse(json["lng"]),
        open: json["open"] == null ? null : json["open"] == 1,
        bonus: json["bonus"] == null ? null : json["bonus"] == 1
        );
    }


    // for database
    Map<String, Object?> toJson() => {
      VelostanFields.id: id,
      VelostanFields.name: name,
      VelostanFields.address: address,
      VelostanFields.lat: lat,
      VelostanFields.lng: lng,
      VelostanFields.open: open! ? 1 : 0,
      VelostanFields.bonus: bonus! ? 1 : 0
    };

}