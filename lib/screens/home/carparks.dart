// To parse this JSON data, do
//
//     final carparks = carparksFromJson(jsonString);

import 'dart:convert';

Carparks carparksFromJson(String str) => Carparks.fromJson(json.decode(str));

String carparksToJson(Carparks data) => json.encode(data.toJson());

class Carparks {
  Carparks({
    this.odataMetadata,
    this.value,
  });

  String odataMetadata;
  List<Value> value;

  factory Carparks.fromJson(Map<String, dynamic> json) => Carparks(
        odataMetadata: json["odata.metadata"],
        value: List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "odata.metadata": odataMetadata,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

class Value {
  Value({
    this.carParkId,
    this.area,
    this.development,
    this.location,
    this.availableLots,
    this.lotType,
    this.agency,
  });

  String carParkId;
  Area area;
  String development;
  String location;
  int availableLots;
  LotType lotType;
  Agency agency;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        carParkId: json["CarParkID"],
        area: areaValues.map[json["Area"]],
        development: json["Development"],
        location: json["Location"],
        availableLots: json["AvailableLots"],
        lotType: lotTypeValues.map[json["LotType"]],
        agency: agencyValues.map[json["Agency"]],
      );

  Map<String, dynamic> toJson() => {
        "CarParkID": carParkId,
        "Area": areaValues.reverse[area],
        "Development": development,
        "Location": location,
        "AvailableLots": availableLots,
        "LotType": lotTypeValues.reverse[lotType],
        "Agency": agencyValues.reverse[agency],
      };

  static List<Value> filterList(List<Value> vl, String filterString) {
    List<Value> _v = vl
        .where((u) => (u.area
            .toString()
            .split('.')
            .last
            .toLowerCase()
            .contains(filterString.toLowerCase())))
        .toList();
    return _v;
  }
}

enum Agency { LTA, URA, HDB }

final agencyValues =
    EnumValues({"HDB": Agency.HDB, "LTA": Agency.LTA, "URA": Agency.URA});

enum Area { MARINA, HARBFRONT, ORCHARD, JURONG_LAKE_DISTRICT, OTHERS, EMPTY }

final areaValues = EnumValues({
  "": Area.EMPTY,
  "Harbfront": Area.HARBFRONT,
  "JurongLakeDistrict": Area.JURONG_LAKE_DISTRICT,
  "Marina": Area.MARINA,
  "Orchard": Area.ORCHARD,
  "Others": Area.OTHERS
});

enum LotType { C, Y, H }

final lotTypeValues =
    EnumValues({"C": LotType.C, "H": LotType.H, "Y": LotType.Y});

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
