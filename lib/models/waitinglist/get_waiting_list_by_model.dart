import 'dart:convert';

GetWaitingListByDateModel getWaitingListByDateModelFromJson(String str) =>
    GetWaitingListByDateModel.fromJson(json.decode(str));

String getWaitingListByDateModelToJson(GetWaitingListByDateModel data) =>
    json.encode(data.toJson());

class GetWaitingListByDateModel {
  String? status;
  String? message;
  List<GetWaitingListByDateModelDatum>? data;

  GetWaitingListByDateModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetWaitingListByDateModel.fromJson(Map<String, dynamic> json) =>
      GetWaitingListByDateModel(
        status: json["status"] as String?,
        message: json["message"] as String?,
        data: json["data"] != null
            ? List<GetWaitingListByDateModelDatum>.from(json["data"].map((x) => GetWaitingListByDateModelDatum.fromJson(x)))
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

class GetWaitingListByDateModelDatum {
  int? id;
  int? clinicId;
  int? patientId;
  DateTime? date;
  String? patientName;
  String? patientPhone;
  DateTime? createdAt;
  DateTime? updatedAt;
  Patient? patient;

  GetWaitingListByDateModelDatum({
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

  factory GetWaitingListByDateModelDatum.fromJson(Map<String, dynamic> json) => GetWaitingListByDateModelDatum(
        id: json["id"] as int?,
        clinicId: json["ClinicId"] as int?,
        patientId: json["PatientId"] as int?,
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
