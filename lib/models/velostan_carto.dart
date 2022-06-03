class VelostanCarto {
  
  // essaie de tout en required. 
  //? Que se passe-t-il si le fetch récupère un attribut à null ?
  //todo tester la situation d'un attribut reçu à null

  final String id; // number
  final String name;
  final String address;
  final double lat;
  final double long;
  final bool open;
  final bool bonus;

  const VelostanCarto({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.open,
    required this.bonus,
  });

  VelostanCarto copyWith({
    String? id, // number
    String? name,
    String? address,
    double? lat,
    double? long,
    bool? open,
    bool? bonus,
  }) => VelostanCarto(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    lat: lat ?? this.lat, 
    long: long ?? this.long,
    open: open ?? this.open,
    bonus: bonus ?? this.bonus
    );

    factory VelostanCarto.fromJson(Map<String, dynamic> json) {
      return VelostanCarto(
        // Exemple de rappel pour gérer le null :
        // id: json["id"] == null ? null : json["id"], 

        id: json["@number"],
        name: json["@name"],
        address: json["@address"],
        lat: json["@lat"], 
        long: json["@long"],
        open: json["@open"],
        bonus: json["@bonus"]
        );
    }

}