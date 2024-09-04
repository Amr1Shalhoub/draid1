import 'dart:convert';

CreateWaitingListModel createWaitingListModelFromJson(String str) =>
    CreateWaitingListModel.fromJson(json.decode(str));

String createWaitingListModelToJson(CreateWaitingListModel data) =>
    json.encode(data.toJson());

class CreateWaitingListModel {
  String? status;
  String? message;
  Data? data;

  CreateWaitingListModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateWaitingListModel.fromJson(Map<String, dynamic> json) =>
      CreateWaitingListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  int? clinicId;
  int? patientId;
  DateTime? date;
  DateTime? updatedAt;
  DateTime? createdAt;

  Data({
    this.id,
    this.clinicId,
    this.patientId,
    this.date,
    this.updatedAt,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        clinicId: json["ClinicId"],
        patientId: json["PatientId"],
        date: json["date"] != null ? DateTime.parse(json["date"]) : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ClinicId": clinicId,
        "PatientId": patientId,
        "date": date != null
            ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
            : null,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
