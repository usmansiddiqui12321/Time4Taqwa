// To parse this JSON data, do
//
//     final getAllMasjidModel = getAllMasjidModelFromJson(jsonString);

import 'dart:convert';

GetAllMasjidModel getAllMasjidModelFromJson(String str) => GetAllMasjidModel.fromJson(json.decode(str));

String getAllMasjidModelToJson(GetAllMasjidModel data) => json.encode(data.toJson());

class GetAllMasjidModel {
    String? status;
    int? results;
    MasjidData? data;

    GetAllMasjidModel({
        this.status,
        this.results,
        this.data,
    });

    factory GetAllMasjidModel.fromJson(Map<String, dynamic> json) => GetAllMasjidModel(
        status: json["status"],
        results: json["results"],
        data: json["data"] == null ? null : MasjidData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "results": results,
        "data": data?.toJson(),
    };
}

class MasjidData {
    List<Mosque>? mosques;

    MasjidData({
        this.mosques,
    });

    factory MasjidData.fromJson(Map<String, dynamic> json) => MasjidData(
        mosques: json["mosques"] == null ? [] : List<Mosque>.from(json["mosques"]!.map((x) => Mosque.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mosques": mosques == null ? [] : List<dynamic>.from(mosques!.map((x) => x.toJson())),
    };
}

class Mosque {
    String? id;
    String? mosqueName;
    double? latitude;
    double? longitude;
    String? fajar;
    String? zuhr;
    String? asar;
    String? maghrib;
    String? esha;
    String? jummah;

    Mosque({
        this.id,
        this.mosqueName,
        this.latitude,
        this.longitude,
        this.fajar,
        this.zuhr,
        this.asar,
        this.maghrib,
        this.esha,
        this.jummah,
    });

    factory Mosque.fromJson(Map<String, dynamic> json) => Mosque(
        id: json["_id"],
        mosqueName: json["mosqueName"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        fajar: json["Fajar"],
        zuhr: json["Zuhr"],
        asar: json["Asar"],
        maghrib: json["Maghrib"],
        esha: json["Esha"],
        jummah: json["Jummah"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "mosqueName": mosqueName,
        "latitude": latitude,
        "longitude": longitude,
        "Fajar": fajar,
        "Zuhr": zuhr,
        "Asar": asar,
        "Maghrib": maghrib,
        "Esha": esha,
        "Jummah": jummah,
    };
}
