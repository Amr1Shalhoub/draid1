
// To parse this JSON data, do
//
//     final getWaitingListModel = getWaitingListModelFromJson(jsonString);
import 'dart:convert';

GetWaitingListModel getWaitingListModelFromJson(String str) =>
    GetWaitingListModel.fromJson(json.decode(str));

String getWaitingListModelToJson(GetWaitingListModel data) =>
    json.encode(data.toJson());

class GetWaitingListModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetWaitingListModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetWaitingListModel.fromJson(Map<String, dynamic> json) =>
      GetWaitingListModel(
        status: json["status"] as String?,
        message: json["message"] as String?,
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : null,
      };
}

class Datum {
  int? id;
  int? clinicId;
  dynamic patientId;
  DateTime? date;
  String? patientName;
  String? patientPhone;
  DateTime? createdAt;
  DateTime? updatedAt;
  Patient? patient;

  Datum({
    this.id,
    this.clinicId,
    this.patientId,
    this.date,
    this.patientName,
    this.patientPhone,
    this.createdAt,
    this.updatedAt,
    this.patient,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] as int?,
        clinicId: json["ClinicId"] as int?,
        patientId: json["PatientId"],
        date: json["date"] != null ? DateTime.parse(json["date"]) : null,
        patientName: json["patientName"] as String?,
        patientPhone: json["patientPhone"] as String?,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        patient:
            json["Patient"] != null ? Patient.fromJson(json["Patient"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ClinicId": clinicId,
        "PatientId": patientId,
        "date": date != null
            ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
            : null,
        "patientName": patientName,
        "patientPhone": patientPhone,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Patient": patient?.toJson(),
      };
}

class Patient {
  String? fullName;
  String? phoneNumber;

  Patient({
    this.fullName,
    this.phoneNumber,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        fullName: json["fullName"] as String?,
        phoneNumber: json["phoneNumber"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
      };
}
