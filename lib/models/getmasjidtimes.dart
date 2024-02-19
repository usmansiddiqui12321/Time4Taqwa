// To parse this JSON data, do
//
//     final getmasjidTimeModel = getmasjidTimeModelFromJson(jsonString);

import 'dart:convert';

GetmasjidTimeModel getmasjidTimeModelFromJson(String str) => GetmasjidTimeModel.fromJson(json.decode(str));

String getmasjidTimeModelToJson(GetmasjidTimeModel data) => json.encode(data.toJson());

class GetmasjidTimeModel {
    String? status;
    Data? data;

    GetmasjidTimeModel({
        this.status,
        this.data,
    });

    factory GetmasjidTimeModel.fromJson(Map<String, dynamic> json) => GetmasjidTimeModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    Mosque? mosque;

    Data({
        this.mosque,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        mosque: json["mosque"] == null ? null : Mosque.fromJson(json["mosque"]),
    );

    Map<String, dynamic> toJson() => {
        "mosque": mosque?.toJson(),
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
    int? v;

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
        this.v,
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
        v: json["__v"],
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
        "__v": v,
    };
}
