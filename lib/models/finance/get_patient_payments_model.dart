// import 'dart:convert';
//
// GetPatientPaymentsModel getPatientPaymentsModelFromJson(String str) => GetPatientPaymentsModel.fromJson(json.decode(str));
//
// String getPatientPaymentsModelToJson(GetPatientPaymentsModel data) => json.encode(data.toJson());
//
// class GetPatientPaymentsModel {
//   String status;
//   String message;
//   List<Datum> data;
//
//   GetPatientPaymentsModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory GetPatientPaymentsModel.fromJson(Map<String, dynamic> json) => GetPatientPaymentsModel(
//     status: json["status"],
//     message: json["message"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   int id;
//   int amount;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int clinicId;
//   int patientId;
//   int treatmentPlanId;
//
//   Datum({
//     required this.id,
//     required this.amount,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.clinicId,
//     required this.patientId,
//     required this.treatmentPlanId,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     amount: json["amount"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     clinicId: json["ClinicId"],
//     patientId: json["PatientId"],
//     treatmentPlanId: json["TreatmentPlanId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "amount": amount,
//     "createdAt": createdAt.toIso8601String(),
//     "updatedAt": updatedAt.toIso8601String(),
//     "ClinicId": clinicId,
//     "PatientId": patientId,
//     "TreatmentPlanId": treatmentPlanId,
//   };
// }



import 'dart:convert';

GetPatientPaymentsModel getPatientPaymentsModelFromJson(String str) => GetPatientPaymentsModel.fromJson(json.decode(str));

String getPatientPaymentsModelToJson(GetPatientPaymentsModel data) => json.encode(data.toJson());

class GetPatientPaymentsModel {
  String status;
  String message;
  List<Datum> data;

  GetPatientPaymentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetPatientPaymentsModel.fromJson(Map<String, dynamic> json) => GetPatientPaymentsModel(
    status: json["status"] ?? '',
    message: json["message"] ?? '',
    data: json["data"] != null
        ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  int clinicId;
  int patientId;
  int treatmentPlanId;

  Datum({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.clinicId,
    required this.patientId,
    required this.treatmentPlanId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? 0,
    amount: json["amount"] ?? 0,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    clinicId: json["ClinicId"] ?? 0,
    patientId: json["PatientId"] ?? 0,
    treatmentPlanId: json["TreatmentPlanId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "ClinicId": clinicId,
    "PatientId": patientId,
    "TreatmentPlanId": treatmentPlanId,
  };
}
