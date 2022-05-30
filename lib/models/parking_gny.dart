// To parse this JSON data, do
//
//     final parkingGny = parkingGnyFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Map<String, ParkingGny> parkingGnyFromMap(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, ParkingGny>(k, ParkingGny.fromMap(v)));

String parkingGnyToMap(Map<String, ParkingGny> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toMap())));

class ParkingGny {
    ParkingGny({
        @required this.addrHousenumber,
        @required this.addrStreet,
        @required this.amenity,
        @required this.bicycleParking,
        @required this.capacity,
        @required this.capacityCharging,
        @required this.capacityDisabled,
        @required this.contactPhone,
        @required this.description,
        @required this.fee,
        @required this.geometryCoordinates,
        @required this.geometryType,
        @required this.id,
        @required this.maxheight,
        @required this.maxstay,
        @required this.metaFileLastUpdate,
        @required this.metaJsonFiltered,
        @required this.metaOsmLastUpdate,
        @required this.metaSigLastUpdate,
        @required this.mgnAddress,
        @required this.mgnAvailable,
        @required this.mgnClosed,
        @required this.mgnFull,
        @required this.mgnSigId,
        @required this.mgnSigObjectid,
        @required this.mgnSource,
        @required this.motorcycleParking,
        @required this.name,
        @required this.openingHours,
        @required this.parkingGnyOperator,
        @required this.osmId,
        @required this.osmType,
        @required this.osmUrl,
        @required this.parkRide,
        @required this.parking,
        @required this.supervised,
        @required this.uiColor,
        @required this.uiColorEn,
        @required this.website,
        @required this.mgnDiscount,
        @required this.mgnPrices,
        @required this.mgnZone,
    });

    String addrHousenumber;
    String addrStreet;
    Amenity amenity;
    String bicycleParking;
    dynamic capacity;
    String capacityCharging;
    String capacityDisabled;
    String contactPhone;
    String description;
    Fee fee;
    List<double> geometryCoordinates;
    GeometryType geometryType;
    String id;
    String maxheight;
    dynamic maxstay;
    DateTime metaFileLastUpdate;
    bool metaJsonFiltered;
    DateTime metaOsmLastUpdate;
    DateTime metaSigLastUpdate;
    String mgnAddress;
    int mgnAvailable;
    bool mgnClosed;
    bool mgnFull;
    int mgnSigId;
    int mgnSigObjectid;
    MgnSource mgnSource;
    dynamic motorcycleParking;
    String name;
    String openingHours;
    String parkingGnyOperator;
    int osmId;
    OsmType osmType;
    String osmUrl;
    Fee parkRide;
    Parking parking;
    Fee supervised;
    UiColor uiColor;
    UiColorEn uiColorEn;
    String website;
    MgnDiscount mgnDiscount;
    Map<String, String> mgnPrices;
    String mgnZone;

    ParkingGny copyWith({
        String addrHousenumber,
        String addrStreet,
        Amenity amenity,
        String bicycleParking,
        dynamic capacity,
        String capacityCharging,
        String capacityDisabled,
        String contactPhone,
        String description,
        Fee fee,
        List<double> geometryCoordinates,
        GeometryType geometryType,
        String id,
        String maxheight,
        dynamic maxstay,
        DateTime metaFileLastUpdate,
        bool metaJsonFiltered,
        DateTime metaOsmLastUpdate,
        DateTime metaSigLastUpdate,
        String mgnAddress,
        int mgnAvailable,
        bool mgnClosed,
        bool mgnFull,
        int mgnSigId,
        int mgnSigObjectid,
        MgnSource mgnSource,
        dynamic motorcycleParking,
        String name,
        String openingHours,
        String parkingGnyOperator,
        int osmId,
        OsmType osmType,
        String osmUrl,
        Fee parkRide,
        Parking parking,
        Fee supervised,
        UiColor uiColor,
        UiColorEn uiColorEn,
        String website,
        MgnDiscount mgnDiscount,
        Map<String, String> mgnPrices,
        String mgnZone,
    }) => 
        ParkingGny(
            addrHousenumber: addrHousenumber ?? this.addrHousenumber,
            addrStreet: addrStreet ?? this.addrStreet,
            amenity: amenity ?? this.amenity,
            bicycleParking: bicycleParking ?? this.bicycleParking,
            capacity: capacity ?? this.capacity,
            capacityCharging: capacityCharging ?? this.capacityCharging,
            capacityDisabled: capacityDisabled ?? this.capacityDisabled,
            contactPhone: contactPhone ?? this.contactPhone,
            description: description ?? this.description,
            fee: fee ?? this.fee,
            geometryCoordinates: geometryCoordinates ?? this.geometryCoordinates,
            geometryType: geometryType ?? this.geometryType,
            id: id ?? this.id,
            maxheight: maxheight ?? this.maxheight,
            maxstay: maxstay ?? this.maxstay,
            metaFileLastUpdate: metaFileLastUpdate ?? this.metaFileLastUpdate,
            metaJsonFiltered: metaJsonFiltered ?? this.metaJsonFiltered,
            metaOsmLastUpdate: metaOsmLastUpdate ?? this.metaOsmLastUpdate,
            metaSigLastUpdate: metaSigLastUpdate ?? this.metaSigLastUpdate,
            mgnAddress: mgnAddress ?? this.mgnAddress,
            mgnAvailable: mgnAvailable ?? this.mgnAvailable,
            mgnClosed: mgnClosed ?? this.mgnClosed,
            mgnFull: mgnFull ?? this.mgnFull,
            mgnSigId: mgnSigId ?? this.mgnSigId,
            mgnSigObjectid: mgnSigObjectid ?? this.mgnSigObjectid,
            mgnSource: mgnSource ?? this.mgnSource,
            motorcycleParking: motorcycleParking ?? this.motorcycleParking,
            name: name ?? this.name,
            openingHours: openingHours ?? this.openingHours,
            parkingGnyOperator: parkingGnyOperator ?? this.parkingGnyOperator,
            osmId: osmId ?? this.osmId,
            osmType: osmType ?? this.osmType,
            osmUrl: osmUrl ?? this.osmUrl,
            parkRide: parkRide ?? this.parkRide,
            parking: parking ?? this.parking,
            supervised: supervised ?? this.supervised,
            uiColor: uiColor ?? this.uiColor,
            uiColorEn: uiColorEn ?? this.uiColorEn,
            website: website ?? this.website,
            mgnDiscount: mgnDiscount ?? this.mgnDiscount,
            mgnPrices: mgnPrices ?? this.mgnPrices,
            mgnZone: mgnZone ?? this.mgnZone,
        );

    factory ParkingGny.fromMap(Map<String, dynamic> json) => ParkingGny(
        addrHousenumber: json["addr:housenumber"] == null ? null : json["addr:housenumber"],
        addrStreet: json["addr:street"] == null ? null : json["addr:street"],
        amenity: amenityValues.map[json["amenity"]],
        bicycleParking: json["bicycle:parking"] == null ? null : json["bicycle:parking"],
        capacity: json["capacity"],
        capacityCharging: json["capacity:charging"] == null ? null : json["capacity:charging"],
        capacityDisabled: json["capacity:disabled"] == null ? null : json["capacity:disabled"],
        contactPhone: json["contact:phone"] == null ? null : json["contact:phone"],
        description: json["description"] == null ? null : json["description"],
        fee: json["fee"] == null ? null : feeValues.map[json["fee"]],
        geometryCoordinates: List<double>.from(json["geometry.coordinates"].map((x) => x.toDouble())),
        geometryType: geometryTypeValues.map[json["geometry.type"]],
        id: json["id"],
        maxheight: json["maxheight"] == null ? null : json["maxheight"],
        maxstay: json["maxstay"],
        metaFileLastUpdate: DateTime.parse(json["meta:file.last_update"]),
        metaJsonFiltered: json["meta:json.filtered"],
        metaOsmLastUpdate: DateTime.parse(json["meta:osm.last_update"]),
        metaSigLastUpdate: json["meta:sig.last_update"] == null ? null : DateTime.parse(json["meta:sig.last_update"]),
        mgnAddress: json["mgn:address"] == null ? null : json["mgn:address"],
        mgnAvailable: json["mgn:available"] == null ? null : json["mgn:available"],
        mgnClosed: json["mgn:closed"] == null ? null : json["mgn:closed"],
        mgnFull: json["mgn:full"] == null ? null : json["mgn:full"],
        mgnSigId: json["mgn:sig.id"] == null ? null : json["mgn:sig.id"],
        mgnSigObjectid: json["mgn:sig.objectid"] == null ? null : json["mgn:sig.objectid"],
        mgnSource: mgnSourceValues.map[json["mgn:source"]],
        motorcycleParking: json["motorcycle:parking"],
        name: json["name"],
        openingHours: json["opening_hours"] == null ? null : json["opening_hours"],
        parkingGnyOperator: json["operator"] == null ? null : json["operator"],
        osmId: json["osm.id"],
        osmType: osmTypeValues.map[json["osm.type"]],
        osmUrl: json["osm.url"],
        parkRide: json["park_ride"] == null ? null : feeValues.map[json["park_ride"]],
        parking: json["parking"] == null ? null : parkingValues.map[json["parking"]],
        supervised: json["supervised"] == null ? null : feeValues.map[json["supervised"]],
        uiColor: uiColorValues.map[json["ui:color"]],
        uiColorEn: uiColorEnValues.map[json["ui:color_en"]],
        website: json["website"] == null ? null : json["website"],
        mgnDiscount: json["mgn:discount"] == null ? null : MgnDiscount.fromMap(json["mgn:discount"]),
        mgnPrices: json["mgn:prices"] == null ? null : Map.from(json["mgn:prices"]).map((k, v) => MapEntry<String, String>(k, v)),
        mgnZone: json["mgn:zone"] == null ? null : json["mgn:zone"],
    );

    Map<String, dynamic> toMap() => {
        "addr:housenumber": addrHousenumber == null ? null : addrHousenumber,
        "addr:street": addrStreet == null ? null : addrStreet,
        "amenity": amenityValues.reverse[amenity],
        "bicycle:parking": bicycleParking == null ? null : bicycleParking,
        "capacity": capacity,
        "capacity:charging": capacityCharging == null ? null : capacityCharging,
        "capacity:disabled": capacityDisabled == null ? null : capacityDisabled,
        "contact:phone": contactPhone == null ? null : contactPhone,
        "description": description == null ? null : description,
        "fee": fee == null ? null : feeValues.reverse[fee],
        "geometry.coordinates": List<dynamic>.from(geometryCoordinates.map((x) => x)),
        "geometry.type": geometryTypeValues.reverse[geometryType],
        "id": id,
        "maxheight": maxheight == null ? null : maxheight,
        "maxstay": maxstay,
        "meta:file.last_update": metaFileLastUpdate.toIso8601String(),
        "meta:json.filtered": metaJsonFiltered,
        "meta:osm.last_update": metaOsmLastUpdate.toIso8601String(),
        "meta:sig.last_update": metaSigLastUpdate == null ? null : metaSigLastUpdate.toIso8601String(),
        "mgn:address": mgnAddress == null ? null : mgnAddress,
        "mgn:available": mgnAvailable == null ? null : mgnAvailable,
        "mgn:closed": mgnClosed == null ? null : mgnClosed,
        "mgn:full": mgnFull == null ? null : mgnFull,
        "mgn:sig.id": mgnSigId == null ? null : mgnSigId,
        "mgn:sig.objectid": mgnSigObjectid == null ? null : mgnSigObjectid,
        "mgn:source": mgnSourceValues.reverse[mgnSource],
        "motorcycle:parking": motorcycleParking,
        "name": name,
        "opening_hours": openingHours == null ? null : openingHours,
        "operator": parkingGnyOperator == null ? null : parkingGnyOperator,
        "osm.id": osmId,
        "osm.type": osmTypeValues.reverse[osmType],
        "osm.url": osmUrl,
        "park_ride": parkRide == null ? null : feeValues.reverse[parkRide],
        "parking": parking == null ? null : parkingValues.reverse[parking],
        "supervised": supervised == null ? null : feeValues.reverse[supervised],
        "ui:color": uiColorValues.reverse[uiColor],
        "ui:color_en": uiColorEnValues.reverse[uiColorEn],
        "website": website == null ? null : website,
        "mgn:discount": mgnDiscount == null ? null : mgnDiscount.toMap(),
        "mgn:prices": mgnPrices == null ? null : Map.from(mgnPrices).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "mgn:zone": mgnZone == null ? null : mgnZone,
    };
}

enum Amenity { PARKING, PARKING_ENTRANCE }

final amenityValues = EnumValues({
    "parking": Amenity.PARKING,
    "parking_entrance": Amenity.PARKING_ENTRANCE
});

enum Fee { YES, NO }

final feeValues = EnumValues({
    "no": Fee.NO,
    "yes": Fee.YES
});

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({
    "Point": GeometryType.POINT
});

class MgnDiscount {
    MgnDiscount({
        @required this.dimanche,
        @required this.soir,
    });

    dynamic dimanche;
    dynamic soir;

    MgnDiscount copyWith({
        dynamic dimanche,
        dynamic soir,
    }) => 
        MgnDiscount(
            dimanche: dimanche ?? this.dimanche,
            soir: soir ?? this.soir,
        );

    factory MgnDiscount.fromMap(Map<String, dynamic> json) => MgnDiscount(
        dimanche: json["dimanche"],
        soir: json["soir"],
    );

    Map<String, dynamic> toMap() => {
        "dimanche": dimanche,
        "soir": soir,
    };
}

enum DimancheEnum { FREE }

final dimancheEnumValues = EnumValues({
    "free": DimancheEnum.FREE
});

enum MgnSource { METROPOLE_DU_GRAND_NANCY_OPEN_STREET_MAP }

final mgnSourceValues = EnumValues({
    "Metropole du Grand Nancy, OpenStreetMap": MgnSource.METROPOLE_DU_GRAND_NANCY_OPEN_STREET_MAP
});

enum OsmType { WAY, NODE, RELATION }

final osmTypeValues = EnumValues({
    "node": OsmType.NODE,
    "relation": OsmType.RELATION,
    "way": OsmType.WAY
});

enum Parking { MULTI_STOREY, SURFACE, UNDERGROUND }

final parkingValues = EnumValues({
    "multi-storey": Parking.MULTI_STOREY,
    "surface": Parking.SURFACE,
    "underground": Parking.UNDERGROUND
});

enum UiColor { THE_2662_FF, E41818, THE_6_CC108, FF7_E00 }

final uiColorValues = EnumValues({
    "#E41818": UiColor.E41818,
    "#FF7E00": UiColor.FF7_E00,
    "#2662FF": UiColor.THE_2662_FF,
    "#6cc108": UiColor.THE_6_CC108
});

enum UiColorEn { BLUE, RED, GREEN, ORANGE }

final uiColorEnValues = EnumValues({
    "blue": UiColorEn.BLUE,
    "green": UiColorEn.GREEN,
    "orange": UiColorEn.ORANGE,
    "red": UiColorEn.RED
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
