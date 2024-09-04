import 'dart:convert';

TreatmentPlanModel treatmentPlanModelFromJson(String str) =>
    TreatmentPlanModel.fromJson(json.decode(str));

String treatmentPlanModelToJson(TreatmentPlanModel data) =>
    json.encode(data.toJson());

class TreatmentPlanModel {
  String status;
  String message;
  TreatmentPlanData treatmentPlanData;

  TreatmentPlanModel({
    required this.status,
    required this.message,
    required this.treatmentPlanData,
  });

  factory TreatmentPlanModel.fromJson(Map<String, dynamic> json) =>
      TreatmentPlanModel(
        status: json["status"],
        message: json["message"],
        treatmentPlanData: TreatmentPlanData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": treatmentPlanData.toJson(),
      };
}

class TreatmentPlanData {
  bool isCompleted;
  int id;
  int patientId;
  int sessionNumber;
  dynamic totalCost;
  DateTime updatedAt;
  DateTime createdAt;

  TreatmentPlanData({
    required this.isCompleted,
    required this.id,
    required this.patientId,
    required this.sessionNumber,
    required this.totalCost,
    required this.updatedAt,
    required this.createdAt,
  });

  factory TreatmentPlanData.fromJson(Map<String, dynamic> json) =>
      TreatmentPlanData(
        isCompleted: json["isCompleted"],
        id: json["id"],
        patientId: json["PatientId"],
        sessionNumber: json["sessionNumber"],
        totalCost: json["totalCost"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isCompleted": isCompleted,
        "id": id,
        "PatientId": patientId,
        "sessionNumber": sessionNumber,
        "totalCost": totalCost,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
