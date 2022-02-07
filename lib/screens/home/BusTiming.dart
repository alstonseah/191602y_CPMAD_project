// To parse this JSON data, do
//
//     final busTimings = busTimingsFromJson(jsonString);

import 'dart:convert';

BusTimings busTimingsFromJson(String str) =>
    BusTimings.fromJson(json.decode(str));

String busTimingsToJson(BusTimings data) => json.encode(data.toJson());

class BusTimings {
  BusTimings({
    this.odataMetadata,
    this.busStopCode,
    this.services,
  });

  String odataMetadata;
  String busStopCode;
  List<Service> services;

  factory BusTimings.fromJson(Map<String, dynamic> json) => BusTimings(
        odataMetadata: json["odata.metadata"],
        busStopCode: json["BusStopCode"],
        services: List<Service>.from(
            json["Services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "odata.metadata": odataMetadata,
        "BusStopCode": busStopCode,
        "Services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    this.serviceNo,
    this.serviceOperator,
    this.nextBus,
    this.nextBus2,
    this.nextBus3,
  });

  String serviceNo;
  String serviceOperator;
  NextBus nextBus;
  NextBus nextBus2;
  NextBus nextBus3;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceNo: json["ServiceNo"],
        serviceOperator: json["Operator"],
        nextBus: NextBus.fromJson(json["NextBus"]),
        nextBus2: NextBus.fromJson(json["NextBus2"]),
        nextBus3: NextBus.fromJson(json["NextBus3"]),
      );

  Map<String, dynamic> toJson() => {
        "ServiceNo": serviceNo,
        "Operator": serviceOperator,
        "NextBus": nextBus.toJson(),
        "NextBus2": nextBus2.toJson(),
        "NextBus3": nextBus3.toJson(),
      };
}

class NextBus {
  NextBus({
    this.originCode,
    this.destinationCode,
    this.estimatedArrival,
    this.latitude,
    this.longitude,
    this.visitNumber,
    this.load,
    this.feature,
    this.type,
  });

  String originCode;
  String destinationCode;
  String estimatedArrival;
  String latitude;
  String longitude;
  String visitNumber;
  Load load;
  Feature feature;
  Type type;

  factory NextBus.fromJson(Map<String, dynamic> json) => NextBus(
        originCode: json["OriginCode"],
        destinationCode: json["DestinationCode"],
        estimatedArrival: json["EstimatedArrival"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        visitNumber: json["VisitNumber"],
        load: loadValues.map[json["Load"]],
        feature: featureValues.map[json["Feature"]],
        type: typeValues.map[json["Type"]],
      );

  Map<String, dynamic> toJson() => {
        "OriginCode": originCode,
        "DestinationCode": destinationCode,
        "EstimatedArrival": estimatedArrival,
        "Latitude": latitude,
        "Longitude": longitude,
        "VisitNumber": visitNumber,
        "Load": loadValues.reverse[load],
        "Feature": featureValues.reverse[feature],
        "Type": typeValues.reverse[type],
      };
}

enum Feature { WAB, EMPTY }

final featureValues = EnumValues({"": Feature.EMPTY, "WAB": Feature.WAB});

enum Load { SEA, EMPTY }

final loadValues = EnumValues({"": Load.EMPTY, "SEA": Load.SEA});

enum Type { SD, DD, EMPTY }

final typeValues = EnumValues({"DD": Type.DD, "": Type.EMPTY, "SD": Type.SD});

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
