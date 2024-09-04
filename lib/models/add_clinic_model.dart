// import 'dart:convert';
//
// AddClinicModel addClinicModelFromJson(String str) => AddClinicModel.fromJson(json.decode(str));
//
// String addClinicModelToJson(AddClinicModel data) => json.encode(data.toJson());
//
// class AddClinicModel {
//     String status;
//     String message;
//     ClinicData clinicData;
//
//     AddClinicModel({
//         required this.status,
//         required this.message,
//         required this.clinicData,
//     });
//
//     factory AddClinicModel.fromJson(Map<String, dynamic> json) => AddClinicModel(
//         status: json["status"],
//         message: json["message"],
//         clinicData: ClinicData.fromJson(json["data"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": clinicData.toJson(),
//     };
// }
//
// class ClinicData {
//     int id;
//     String name;
//     String address;
//     String telePhoneNumber;
//     String phoneNumber;
//     String whatsappNumber;
//     String ownerName;
//     String ownerAddress;
//     String ownerPhone;
//     int userId;
//     DateTime updatedAt;
//     DateTime createdAt;
//
//     ClinicData({
//         required this.id,
//         required this.name,
//         required this.address,
//         required this.telePhoneNumber,
//         required this.phoneNumber,
//         required this.whatsappNumber,
//         required this.ownerName,
//         required this.ownerAddress,
//         required this.ownerPhone,
//         required this.userId,
//         required this.updatedAt,
//         required this.createdAt,
//     });
//
//     factory ClinicData.fromJson(Map<String, dynamic> json) => ClinicData(
//         id: json["id"],
//         name: json["name"],
//         address: json["address"],
//         telePhoneNumber: json["telePhoneNumber"],
//         phoneNumber: json["phoneNumber"],
//         whatsappNumber: json["whatsappNumber"],
//         ownerName: json["ownerName"],
//         ownerAddress: json["ownerAddress"],
//         ownerPhone: json["ownerPhone"],
//         userId: json["userId"],
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         createdAt: DateTime.parse(json["createdAt"]),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "address": address,
//         "telePhoneNumber": telePhoneNumber,
//         "phoneNumber": phoneNumber,
//         "whatsappNumber": whatsappNumber,
//         "ownerName": ownerName,
//         "ownerAddress": ownerAddress,
//         "ownerPhone": ownerPhone,
//         "userId": userId,
//         "updatedAt": updatedAt.toIso8601String(),
//         "createdAt": createdAt.toIso8601String(),
//     };
// }


import 'dart:convert';

AddClinicModel? addClinicModelFromJson(String str) => AddClinicModel.fromJson(json.decode(str));

String addClinicModelToJson(AddClinicModel? data) => json.encode(data?.toJson());

class AddClinicModel {
    String? status;
    String? message;
    Data? data;

    AddClinicModel({
        this.status,
        this.message,
        this.data,
    });

    factory AddClinicModel.fromJson(Map<String, dynamic> json) => AddClinicModel(
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
    String? workingStartTime;
    String? workingEndTime;
    int? id;
    String? name;
    String? address;
    String? telePhoneNumber;
    String? phoneNumber;
    String? whatsappNumber;
    String? ownerName;
    String? ownerAddress;
    String? ownerPhone;
    String? ownerEmail;
    DateTime? updatedAt;
    DateTime? createdAt;

    Data({
        this.workingStartTime,
        this.workingEndTime,
        this.id,
        this.name,
        this.address,
        this.telePhoneNumber,
        this.phoneNumber,
        this.whatsappNumber,
        this.ownerName,
        this.ownerAddress,
        this.ownerPhone,
        this.ownerEmail,
        this.updatedAt,
        this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        workingStartTime: json["workingStartTime"],
        workingEndTime: json["workingEndTime"],
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
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "workingStartTime": workingStartTime,
        "workingEndTime": workingEndTime,
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
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
    };
}
