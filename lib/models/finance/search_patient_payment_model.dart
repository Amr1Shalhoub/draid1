
import 'dart:convert';

SearchPatientPaymentModel searchPatientPaymentModelFromJson(String str) => SearchPatientPaymentModel.fromJson(json.decode(str));

String searchPatientPaymentModelToJson(SearchPatientPaymentModel data) => json.encode(data.toJson());

class SearchPatientPaymentModel {
  String status;
  String message;
  Data data;

  SearchPatientPaymentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchPatientPaymentModel.fromJson(Map<String, dynamic> json) => SearchPatientPaymentModel(
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
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  int clinicId;
  int patientId;
  int treatmentPlanId;

  Data({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.clinicId,
    required this.patientId,
    required this.treatmentPlanId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    amount: json["amount"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    clinicId: json["ClinicId"],
    patientId: json["PatientId"],
    treatmentPlanId: json["TreatmentPlanId"],
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
