// To parse this JSON data, do
//
//     final createDonationModel = createDonationModelFromJson(jsonString);

import 'dart:convert';

CreatePostModel createDonationModelFromJson(String str) => CreatePostModel.fromJson(json.decode(str));

String createDonationModelToJson(CreatePostModel data) => json.encode(data.toJson());

class CreatePostModel {
    String? status;
    Data? data;

    CreatePostModel({
        this.status,
        this.data,
    });

    factory CreatePostModel.fromJson(Map<String, dynamic> json) => CreatePostModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    Donation? donation;

    Data({
        this.donation,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        donation: json["donation"] == null ? null : Donation.fromJson(json["donation"]),
    );

    Map<String, dynamic> toJson() => {
        "donation": donation?.toJson(),
    };
}

class Donation {
    List<String>? images;
    String? id;
    String? title;
    int? amount;
    String? mosqueName;
    String? description;
    int? v;

    Donation({
        this.images,
        this.id,
        this.title,
        this.amount,
        this.mosqueName,
        this.description,
        this.v,
    });

    factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        id: json["_id"],
        title: json["title"],
        amount: json["amount"],
        mosqueName: json["mosqueName"],
        description: json["description"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "_id": id,
        "title": title,
        "amount": amount,
        "mosqueName": mosqueName,
        "description": description,
        "__v": v,
    };
}
