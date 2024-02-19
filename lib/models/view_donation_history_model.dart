// To parse this JSON data, do
//
//     final viewDonationHistoryModel = viewDonationHistoryModelFromJson(jsonString);

import 'dart:convert';

ViewDonationHistoryModel viewDonationHistoryModelFromJson(String str) => ViewDonationHistoryModel.fromJson(json.decode(str));

String viewDonationHistoryModelToJson(ViewDonationHistoryModel data) => json.encode(data.toJson());

class ViewDonationHistoryModel {
    String? status;
    HistoryData? data;

    ViewDonationHistoryModel({
        this.status,
        this.data,
    });

    factory ViewDonationHistoryModel.fromJson(Map<String, dynamic> json) => ViewDonationHistoryModel(
        status: json["status"],
        data: json["data"] == null ? null : HistoryData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class HistoryData {
    List<DonationHistory>? donations;

    HistoryData({
        this.donations,
    });

    factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
        donations: json["donations"] == null ? [] : List<DonationHistory>.from(json["donations"]!.map((x) => DonationHistory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "donations": donations == null ? [] : List<dynamic>.from(donations!.map((x) => x.toJson())),
    };
}

class DonationHistory {
    String? id;
    String? mosqueName;
    String? title;
    int? amount;
    String? description;

    DonationHistory({
        this.id,
        this.mosqueName,
        this.title,
        this.amount,
        this.description,
    });

    factory DonationHistory.fromJson(Map<String, dynamic> json) => DonationHistory(
        id: json["_id"],
        mosqueName: json["mosqueName"],
        title: json["title"],
        amount: json["amount"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "mosqueName": mosqueName,
        "title": title,
        "amount": amount,
        "description": description,
    };
}
