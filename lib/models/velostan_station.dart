class VelostanSation {
  // ne pas sotcker en BD

  //? final String? id // le fournir depuis la requête
  final int? available;
  final int? free;
  final int? total;
  final bool? ticket;
  final bool? open;
  // final DateTime? updated;
  final bool? connected;

  const VelostanSation({
    this.available,
    this.free,
    this.total,
    this.ticket,
    this.open,
    // this.updated,
    this.connected,
  });

  VelostanSation copyWith({
    int? available,
    int? free,
    int? total,
    bool? ticket,
    bool? open,
    // DateTime? updated,
    bool? connected,
  }) =>
      VelostanSation(
          available: available ?? this.available,
          free: free ?? this.free,
          total: total ?? this.total,
          ticket: ticket ?? this.ticket,
          open: open ?? this.open,
          // updated: updated ?? this.updated,
          connected: connected ?? this.connected);

  factory VelostanSation.fromAPIJson(Map<String, dynamic> json) {

    return VelostanSation(
        // Exemple de rappel pour gérer le null :
        // id: json["id"] == null ? null : json["id"],

        available: json["available"] == null ? null : json["@number"] as int,
        free: json["free"] == null ? null : json["free"] as int,
        total: json["total"] == null ? null : json["total"] as int,
        ticket: json["ticket"] == null ? null : json["ticket"] == "1",
        open: json["open"] == null ? null : json["open"] == "1",
        connected: json["connected"] == null ? null : json["connected"] == "1");
  }
}
