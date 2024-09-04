import 'dart:convert';

GetAppointmentsModel getAppointmentsModelFromJson(String str) =>
    GetAppointmentsModel.fromJson(json.decode(str));

String getAppointmentsModelToJson(GetAppointmentsModel data) =>
    json.encode(data.toJson());

class GetAppointmentsModel {
  String status;
  String message;
  List<Datum> data;

  GetAppointmentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAppointmentsModel.fromJson(Map<String, dynamic> json) =>
      GetAppointmentsModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  DateTime date;
  String startTime;
  String endTime;
  String complaint;
  String patientName;
  String patientPhone;
  DateTime createdAt;
  DateTime updatedAt;
  int clinicId;
  int? patientId;
  Patient? patient;

  Datum({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.complaint,
    required this.patientName,
    required this.patientPhone,
    required this.createdAt,
    required this.updatedAt,
    required this.clinicId,
    required this.patientId,
    required this.patient,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        complaint: json["complaint"],
        patientName: json["patientName"],
        patientPhone: json["patientPhone"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        clinicId: json["ClinicId"],
        patientId: json["PatientId"],
        patient:
            json["Patient"] == null ? null : Patient.fromJson(json["Patient"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "complaint": complaint,
        "patientName": patientName,
        "patientPhone": patientPhone,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "ClinicId": clinicId,
        "PatientId": patientId,
        "Patient": patient?.toJson(),
      };
}

class Patient {
  String fullName;
  String phoneNumber;

  Patient({
    required this.fullName,
    required this.phoneNumber,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
      };
}
