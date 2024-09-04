import 'dart:convert';

AddPatientPaymentModel addPatientPaymentModelFromJson(String str) => AddPatientPaymentModel.fromJson(json.decode(str));

String addPatientPaymentModelToJson(AddPatientPaymentModel data) => json.encode(data.toJson());

class AddPatientPaymentModel {
  String status;
  String message;
  Data data;

  AddPatientPaymentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddPatientPaymentModel.fromJson(Map<String, dynamic> json) => AddPatientPaymentModel(
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
  DateTime createdAt;
  int id;
  int patientId;
  int clinicId;
  int treatmentPlanId;
  int amount;
  DateTime updatedAt;

  Data({
    required this.createdAt,
    required this.id,
    required this.patientId,
    required this.clinicId,
    required this.treatmentPlanId,
    required this.amount,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createdAt: DateTime.parse(json["createdAt"]),
    id: json["id"],
    patientId: json["PatientId"],
    clinicId: json["ClinicId"],
    treatmentPlanId: json["TreatmentPlanId"],
    amount: json["amount"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "id": id,
    "PatientId": patientId,
    "ClinicId": clinicId,
    "TreatmentPlanId": treatmentPlanId,
    "amount": amount,
    "updatedAt": updatedAt.toIso8601String(),
  };
}
