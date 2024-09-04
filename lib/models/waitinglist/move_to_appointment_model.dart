// To parse this JSON data, do
//
//     final moveToAppointmentModel = moveToAppointmentModelFromJson(jsonString);

import 'dart:convert';

MoveToAppointmentModel moveToAppointmentModelFromJson(String str) => MoveToAppointmentModel.fromJson(json.decode(str));

String moveToAppointmentModelToJson(MoveToAppointmentModel data) => json.encode(data.toJson());

class MoveToAppointmentModel {
    String status;
    String message;
    Data data;

    MoveToAppointmentModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory MoveToAppointmentModel.fromJson(Map<String, dynamic> json) => MoveToAppointmentModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    DateTime date;
    String startTime;
    String endTime;
    String complaint;
    int clinicId;
    dynamic patientId;
    String patientName;
    String patientPhone;
    DateTime updatedAt;
    DateTime createdAt;

    Data({
        required this.id,
        required this.date,
        required this.startTime,
        required this.endTime,
        required this.complaint,
        required this.clinicId,
        required this.patientId,
        required this.patientName,
        required this.patientPhone,
        required this.updatedAt,
        required this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        complaint: json["complaint"],
        clinicId: json["ClinicId"],
        patientId: json["PatientId"],
        patientName: json["patientName"],
        patientPhone: json["patientPhone"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "complaint": complaint,
        "ClinicId": clinicId,
        "PatientId": patientId,
        "patientName": patientName,
        "patientPhone": patientPhone,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}
