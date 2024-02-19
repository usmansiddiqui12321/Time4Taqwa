// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) => UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
    String? status;
    String? token;
    Data? data;

    UserLoginModel({
        this.status,
        this.token,
        this.data,
    });

    factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
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
    User? user;

    Data({
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
    };
}

class User {
    String? id;
    String? role;
    String? username;
    String? email;
    int? v;

    User({
        this.id,
        this.role,
        this.username,
        this.email,
        this.v,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        role: json["role"],
        username: json["username"],
        email: json["email"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "role": role,
        "username": username,
        "email": email,
        "__v": v,
    };
}
