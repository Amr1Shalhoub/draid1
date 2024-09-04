import 'dart:convert';

CreateAppointmentModel createAppointmentModelFromJson(String str) =>
    CreateAppointmentModel.fromJson(json.decode(str));

String createAppointmentModelToJson(CreateAppointmentModel data) =>
    json.encode(data.toJson());

class CreateAppointmentModel {
  String? status;
  String? message;
  Data? data;

  CreateAppointmentModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateAppointmentModel.fromJson(Map<String, dynamic> json) =>
      CreateAppointmentModel(
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
  DateTime? date;
  String? startTime;
  String? endTime;
  String? complaint;
  int? clinicId;
  int? patientId;
  DateTime? updatedAt;
  DateTime? createdAt;

  Data({
    this.id,
    this.date,
    this.startTime,
    this.endTime,
    this.complaint,
    this.clinicId,
    this.patientId,
    this.updatedAt,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        date: json["date"] != null ? DateTime.parse(json["date"]) : null,
        startTime: json["startTime"],
        endTime: json["endTime"],
        complaint: json["complaint"],
        clinicId: json["ClinicId"],
        patientId: json["PatientId"],
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date != null
            ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
            : null,
        "startTime": startTime,
        "endTime": endTime,
        "complaint": complaint,
        "ClinicId": clinicId,
        "PatientId": patientId,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
