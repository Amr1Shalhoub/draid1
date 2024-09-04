import 'dart:convert';

GetAllPatientsModel getAllPatientsModelFromJson(String str) => GetAllPatientsModel.fromJson(json.decode(str));

String getAllPatientsModelToJson(GetAllPatientsModel data) => json.encode(data.toJson());

class GetAllPatientsModel {
  String status;
  String message;
  List<DatumPatient> data;

  GetAllPatientsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllPatientsModel.fromJson(Map<String, dynamic> json) => GetAllPatientsModel(
    status: json["status"],
    message: json["message"],
    data: List<DatumPatient>.from(json["data"].map((x) => DatumPatient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumPatient {
  String fullName;
  int age;
  String gender;
  String address;
  PatientClinic patientClinic;

  DatumPatient({
    required this.fullName,
    required this.age,
    required this.gender,
    required this.address,
    required this.patientClinic,
  });

  factory DatumPatient.fromJson(Map<String, dynamic> json) => DatumPatient(
    fullName: json["fullName"],
    age: json["age"],
    gender: json["gender"],
    address: json["address"],
    patientClinic: PatientClinic.fromJson(json["patient_clinic"]),
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "age": age,
    "gender": gender,
    "address": address,
    "patient_clinic": patientClinic.toJson(),
  };
}

class PatientClinic {
  DateTime createdAt;
  DateTime updatedAt;
  int patientId;
  int clinicId;

  PatientClinic({
    required this.createdAt,
    required this.updatedAt,
    required this.patientId,
    required this.clinicId,
  });

  factory PatientClinic.fromJson(Map<String, dynamic> json) => PatientClinic(
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    patientId: json["PatientId"],
    clinicId: json["ClinicId"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "PatientId": patientId,
    "ClinicId": clinicId,
  };
}
