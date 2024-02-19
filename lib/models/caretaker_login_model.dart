
// To parse this JSON data, do
//
//     final careTakerLoginModel = careTakerLoginModelFromJson(jsonString);

import 'dart:convert';

CareTakerLoginModel careTakerLoginModelFromJson(String str) => CareTakerLoginModel.fromJson(json.decode(str));

String careTakerLoginModelToJson(CareTakerLoginModel data) => json.encode(data.toJson());

class CareTakerLoginModel {
    String? status;
    String? token;
    Data? data;

    CareTakerLoginModel({
        this.status,
        this.token,
        this.data,
    });

    factory CareTakerLoginModel.fromJson(Map<String, dynamic> json) => CareTakerLoginModel(
        status: json["status"],
        token: json["token"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "data": data?.toJson(),
    };
}

class Data {
    Caretaker? caretaker;
    SetMosque? mosque;

    Data({
        this.caretaker,
        this.mosque,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        caretaker: json["caretaker"] == null ? null : Caretaker.fromJson(json["caretaker"]),
        mosque: json["mosque"] == null ? null : SetMosque.fromJson(json["mosque"]),
    );

    Map<String, dynamic> toJson() => {
        "caretaker": caretaker?.toJson(),
        "mosque": mosque?.toJson(),
    };
}

class Caretaker {
    String? id;
    String? name;
    String? mosqueName;
    String? email;
    int? v;

    Caretaker({
        this.id,
        this.name,
        this.mosqueName,
        this.email,
        this.v,
    });

    factory Caretaker.fromJson(Map<String, dynamic> json) => Caretaker(
        id: json["_id"],
        name: json["name"],
        mosqueName: json["mosqueName"],
        email: json["email"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mosqueName": mosqueName,
        "email": email,
        "__v": v,
    };
}

class SetMosque {
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

    SetMosque({
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

    factory SetMosque.fromJson(Map<String, dynamic> json) => SetMosque(
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
