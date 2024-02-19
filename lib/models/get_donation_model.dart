// To parse this JSON data, do
//
//     final getDonationModel = getDonationModelFromJson(jsonString);

import 'dart:convert';

GetDonationModel getDonationModelFromJson(String str) =>
    GetDonationModel.fromJson(json.decode(str));

String getDonationModelToJson(GetDonationModel data) =>
    json.encode(data.toJson());

class GetDonationModel {
  String? status;
  int? results;
  DonationData? data;
  GetDonationModel({
    this.status,
    this.results,
    this.data,
  });

  factory GetDonationModel.fromJson(Map<String, dynamic> json) =>
      GetDonationModel(
        status: json["status"],
        results: json["results"],
        data: json["data"] == null ? null : DonationData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "results": results,
        "data": data?.toJson(),
      };
}

class DonationData {
  List<Donationdetails>? donations;

  DonationData({
    this.donations,
  });

  factory DonationData.fromJson(Map<String, dynamic> json) => DonationData(
        donations: json["donations"] == null
            ? []
            : List<Donationdetails>.from(
                json["donations"]!.map((x) => Donationdetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "donations": donations == null
            ? []
            : List<dynamic>.from(donations!.map((x) => x.toJson())),
      };
}

class Donationdetails {
  List<String>? images;
  String? id;
  String? email;
  String? title;
  int? amount;
  String? mosqueName;
  String? description;

  Donationdetails({
    this.images,
    this.id,
    this.email,
    this.title,
    this.amount,
    this.mosqueName,
    this.description,
  });

  factory Donationdetails.fromJson(Map<String, dynamic> json) => Donationdetails(
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        id: json["_id"],
        email: json["email"],
        title: json["title"],
        amount: json["amount"],
        mosqueName: json["mosqueName"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "_id": id,
        "email": email,
        "title": title,
        "amount": amount,
        "mosqueName": mosqueName,
        "description": description,
      };
}
