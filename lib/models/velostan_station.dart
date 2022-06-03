class VelostanSation {

  // ne pas sotcker en BD

  //? final String? id // le fournir depuis la requête
  final int available;
  final int free;
  final int total;
  final bool ticket;
  final bool open;
  final DateTime updated;
  final bool connected;

  const VelostanSation({
    required this.available,
    required this.free,
    required this.total,
    required this.ticket,
    required this.open,
    required this.updated,
    required this.connected,
  });

  VelostanSation copyWith({
    int? available,
    int? free,
    int? total,
    bool? ticket,
    bool? open,
    DateTime? updated,
    bool? connected,
  }) => VelostanSation(
    available: available ?? this.available, 
    free: free ?? this.free, 
    total: total ?? this.total, 
    ticket: ticket ?? this.ticket, 
    open: open ?? this.open, 
    updated: updated ?? this.updated, 
    connected: connected ?? this.connected);

}