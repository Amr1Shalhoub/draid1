// import 'dart:convert';
//
// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
//
// String userModelToJson(UserModel data) => json.encode(data.toJson());
//
// class UserModel {
//   String status;
//   String msg;
//   UserData userData;
//   String token;
//
//   UserModel({
//     required this.status,
//     required this.msg,
//     required this.userData,
//     required this.token,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         status: json["status"],
//         msg: json["msg"],
//         userData: UserData.fromJson(json["data"]),
//         token: json["token"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "msg": msg,
//         "data": userData.toJson(),
//         "token": token,
//       };
// }
//
// class UserData {
//   int id;
//   String name;
//   String address;
//   String telePhoneNumber;
//   String phoneNumber;
//   String whatsappNumber;
//   String ownerName;
//   String ownerAddress;
//   String ownerPhone;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int userId;
//
//   UserData({
//     required this.id,
//     required this.name,
//     required this.address,
//     required this.telePhoneNumber,
//     required this.phoneNumber,
//     required this.whatsappNumber,
//     required this.ownerName,
//     required this.ownerAddress,
//     required this.ownerPhone,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.userId,
//   });
//
//   factory UserData.fromJson(Map<String, dynamic> json) => UserData(
//         id: json["id"],
//         name: json["name"],
//         address: json["address"],
//         telePhoneNumber: json["telePhoneNumber"],
//         phoneNumber: json["phoneNumber"],
//         whatsappNumber: json["whatsappNumber"],
//         ownerName: json["ownerName"],
//         ownerAddress: json["ownerAddress"],
//         ownerPhone: json["ownerPhone"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         userId: json["userId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "address": address,
//         "telePhoneNumber": telePhoneNumber,
//         "phoneNumber": phoneNumber,
//         "whatsappNumber": whatsappNumber,
//         "ownerName": ownerName,
//         "ownerAddress": ownerAddress,
//         "ownerPhone": ownerPhone,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "userId": userId,
//       };
// }




// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String status;
  String msg;
  Data data;
  String token;

  UserModel({
    required this.status,
    required this.msg,
    required this.data,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
    "token": token,
  };
}

class Data {
  int id;
  String name;
  String address;
  String telePhoneNumber;
  String phoneNumber;
  String whatsappNumber;
  String ownerName;
  String ownerAddress;
  String ownerPhone;
  String ownerEmail;
  String workingStartTime;
  String workingEndTime;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.name,
    required this.address,
    required this.telePhoneNumber,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.ownerName,
    required this.ownerAddress,
    required this.ownerPhone,
    required this.ownerEmail,
    required this.workingStartTime,
    required this.workingEndTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    telePhoneNumber: json["telePhoneNumber"],
    phoneNumber: json["phoneNumber"],
    whatsappNumber: json["whatsappNumber"],
    ownerName: json["ownerName"],
    ownerAddress: json["ownerAddress"],
    ownerPhone: json["ownerPhone"],
    ownerEmail: json["ownerEmail"],
    workingStartTime: json["workingStartTime"],
    workingEndTime: json["workingEndTime"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "telePhoneNumber": telePhoneNumber,
    "phoneNumber": phoneNumber,
    "whatsappNumber": whatsappNumber,
    "ownerName": ownerName,
    "ownerAddress": ownerAddress,
    "ownerPhone": ownerPhone,
    "ownerEmail": ownerEmail,
    "workingStartTime": workingStartTime,
    "workingEndTime": workingEndTime,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

