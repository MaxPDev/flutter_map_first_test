class VelostanCarto {
  
  final String? id; // number
  final String? name;
  final String? address;
  final double lat;
  final double long;
  final bool? open;
  final bool? bonus;

  const VelostanCarto({
    this.id,
    this.name,
    this.address,
    required this.lat,
    required this.long,
    this.open,
    this.bonus,
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

}