// To parse this JSON data, do
//
//     final erp = erpFromJson(jsonString);

import 'dart:convert';

Erp erpFromJson(String str) => Erp.fromJson(json.decode(str));

String erpToJson(Erp data) => json.encode(data.toJson());

class Erp {
  Erp({
    this.odataMetadata,
    this.value,
  });

  String odataMetadata;
  List<Value> value;

  factory Erp.fromJson(Map<String, dynamic> json) => Erp(
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
    this.vehicleType,
    this.dayType,
    this.startTime,
    this.endTime,
    this.zoneId,
    this.chargeAmount,
    this.effectiveDate,
  });

  VehicleType vehicleType;
  DayType dayType;
  String startTime;
  String endTime;
  ZoneId zoneId;
  double chargeAmount;
  DateTime effectiveDate;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        vehicleType: vehicleTypeValues.map[json["VehicleType"]],
        dayType: dayTypeValues.map[json["DayType"]],
        startTime: json["StartTime"],
        endTime: json["EndTime"],
        zoneId: zoneIdValues.map[json["ZoneID"]],
        chargeAmount: json["ChargeAmount"].toDouble(),
        effectiveDate: DateTime.parse(json["EffectiveDate"]),
      );

  Map<String, dynamic> toJson() => {
        "VehicleType": vehicleTypeValues.reverse[vehicleType],
        "DayType": dayTypeValues.reverse[dayType],
        "StartTime": startTime,
        "EndTime": endTime,
        "ZoneID": zoneIdValues.reverse[zoneId],
        "ChargeAmount": chargeAmount,
        "EffectiveDate":
            "${effectiveDate.year.toString().padLeft(4, '0')}-${effectiveDate.month.toString().padLeft(2, '0')}-${effectiveDate.day.toString().padLeft(2, '0')}",
      };

  static List<Value> filterList(List<Value> vl, String filterString) {
    List<Value> _v = vl
        .where((u) => (u.zoneId
            .toString()
            .split('.')
            .last
            .toLowerCase()
            .contains(filterString.toLowerCase())))
        .toList();
    return _v;
  }
}

enum DayType { WEEKDAYS, SATURDAY }

final dayTypeValues =
    EnumValues({"Saturday": DayType.SATURDAY, "Weekdays": DayType.WEEKDAYS});

enum VehicleType {
  PASSENGER_CARS_LIGHT_GOODS_VEHICLES_TAXIS,
  LIGHT_GOODS_VEHICLES,
  TAXIS,
  MOTORCYCLES,
  HEAVY_GOODS_VEHICLES_SMALL_BUSES,
  VERY_HEAVY_GOODS_VEHICLES_BIG_BUSES
}

final vehicleTypeValues = EnumValues({
  "Heavy Goods Vehicles/Small Buses":
      VehicleType.HEAVY_GOODS_VEHICLES_SMALL_BUSES,
  "Light Goods Vehicles": VehicleType.LIGHT_GOODS_VEHICLES,
  "Motorcycles": VehicleType.MOTORCYCLES,
  "Passenger Cars/Light Goods Vehicles/Taxis":
      VehicleType.PASSENGER_CARS_LIGHT_GOODS_VEHICLES_TAXIS,
  "Taxis": VehicleType.TAXIS,
  "Very Heavy Goods Vehicles/Big Buses":
      VehicleType.VERY_HEAVY_GOODS_VEHICLES_BIG_BUSES
});

enum ZoneId { AY1, AYC, AYT, BKE, BKZ, BMC, CBD }

final zoneIdValues = EnumValues({
  "AY1": ZoneId.AY1,
  "AYC": ZoneId.AYC,
  "AYT": ZoneId.AYT,
  "BKE": ZoneId.BKE,
  "BKZ": ZoneId.BKZ,
  "BMC": ZoneId.BMC,
  "CBD": ZoneId.CBD
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
