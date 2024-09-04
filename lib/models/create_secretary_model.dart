// To parse this JSON data, do
//
//     final createSecretaryModel = createSecretaryModelFromJson(jsonString);

import 'dart:convert';

CreateSecretaryModel createSecretaryModelFromJson(String str) => CreateSecretaryModel.fromJson(json.decode(str));

String createSecretaryModelToJson(CreateSecretaryModel data) => json.encode(data.toJson());

class CreateSecretaryModel {
  String? status;
  String? message;
  Data? data;

  CreateSecretaryModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateSecretaryModel.fromJson(Map<String, dynamic> json) => CreateSecretaryModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? fullName;
  String? email;
  String? password;
  String? address;
  int? clinicId;
  String? phoneNumber;
  String? role;
  DateTime? updatedAt;
  DateTime? createdAt;

  Data({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.address,
    this.clinicId,
    this.phoneNumber,
    this.role,
    this.updatedAt,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    password: json["password"],
    address: json["address"],
    clinicId: json["ClinicId"],
    phoneNumber: json["phoneNumber"],
    role: json["role"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "password": password,
    "address": address,
    "ClinicId": clinicId,
    "phoneNumber": phoneNumber,
    "role": role,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}