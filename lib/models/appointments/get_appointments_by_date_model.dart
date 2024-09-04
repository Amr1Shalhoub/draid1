import 'dart:convert';

GetAppointmentsByDateModel getAppointmentsByDateModelFromJson(String str) =>
    GetAppointmentsByDateModel.fromJson(json.decode(str));

String getAppointmentsByDateModelToJson(GetAppointmentsByDateModel data) =>
    json.encode(data.toJson());

class GetAppointmentsByDateModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetAppointmentsByDateModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetAppointmentsByDateModel.fromJson(Map<String, dynamic> json) =>
      GetAppointmentsByDateModel(
        status: json["status"] as String?,
        message: json["message"] as String?,
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  DateTime? date;
  String? startTime;
  String? endTime;
  String? complaint;
  String? patientName;
  String? patientPhone;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? clinicId;
  int? patientId;
  Patient? patient;
  Datum({
    this.id,
    this.date,
    this.startTime,
    this.endTime,
    this.complaint,
    this.patientName,
    this.patientPhone,
    this.createdAt,
    this.updatedAt,
    this.clinicId,
    this.patientId,
    this.patient,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] as int?,
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["startTime"] as String?,
        endTime: json["endTime"] as String?,
        complaint: json["complaint"] as String?,
        patientName: json["patientName"] as String?,
        patientPhone: json["patientPhone"] as String?,
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        clinicId: json["ClinicId"] as int?,
        patientId: json["PatientId"] as int?,
        patient:
            json["Patient"] == null ? null : Patient.fromJson(json["Patient"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "complaint": complaint,
        "patientName": patientName,
        "patientPhone": patientPhone,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "ClinicId": clinicId,
        "PatientId": patientId,
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
