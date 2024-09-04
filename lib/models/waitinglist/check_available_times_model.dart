import 'dart:convert';

CheckAvailableTimesModel checkAvailableTimesModelFromJson(String str) =>
    CheckAvailableTimesModel.fromJson(json.decode(str));

String checkAvailableTimesModelToJson(CheckAvailableTimesModel data) =>
    json.encode(data.toJson());

class CheckAvailableTimesModel {
  String status;
  String message;
  Data? data;

  CheckAvailableTimesModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory CheckAvailableTimesModel.fromJson(Map<String, dynamic> json) =>
      CheckAvailableTimesModel(
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
  DateTime? date;
  String? patientName;
  String? patientPhone;
  int? patientId;
  String? startTime;
  String? endTime;
  String? complaint;

  Data({
    this.date,
    this.patientName,
    this.patientPhone,
    this.patientId,
    this.startTime,
    this.endTime,
    this.complaint,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        patientName: json["patientName"],
        patientPhone: json["patientPhone"],
        patientId: json["PatientId"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        complaint: json["complaint"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "patientName": patientName,
        "patientPhone": patientPhone,
        "PatientId": patientId,
        "startTime": startTime,
        "endTime": endTime,
        "complaint": complaint,
      };
}
