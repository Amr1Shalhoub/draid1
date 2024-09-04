import 'dart:convert';

CompletedTreatmentModel completedTreatmentModelFromJson(String str) =>
    CompletedTreatmentModel.fromJson(json.decode(str));

String completedTreatmentModelToJson(CompletedTreatmentModel data) =>
    json.encode(data.toJson());

class CompletedTreatmentModel {
  String status;
  String message;
  CompletedTreatmentData? completedTreatmentData; // Nullable

  CompletedTreatmentModel({
    required this.status,
    required this.message,
    this.completedTreatmentData, // Nullable
  });

  factory CompletedTreatmentModel.fromJson(Map<String, dynamic> json) =>
      CompletedTreatmentModel(
        status: json["status"],
        message: json["message"],
        completedTreatmentData: json["data"] != null
            ? CompletedTreatmentData.fromJson(json["data"])
            : null, // Handle null
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": completedTreatmentData?.toJson(), // Handle null
      };
}

class CompletedTreatmentData {
  int id;
  int? patientId; // Nullable
  int? treatmentId; // Nullable
  String? place; // Nullable
  int? fromTeeth; // Nullable
  int? toTeeth; // Nullable
  String? notes; // Nullable
  DateTime? updatedAt; // Nullable
  DateTime? createdAt; // Nullable

  CompletedTreatmentData({
    required this.id,
    this.patientId,
    this.treatmentId,
    this.place,
    this.fromTeeth,
    this.toTeeth,
    this.notes,
    this.updatedAt,
    this.createdAt,
  });

  factory CompletedTreatmentData.fromJson(Map<String, dynamic> json) =>
      CompletedTreatmentData(
        id: json["id"],
        patientId: json["PatientId"],
        treatmentId: json["treatmentId"],
        place: json["place"],
        fromTeeth: json["fromTeeth"],
        toTeeth: json["toTeeth"],
        notes: json["notes"],
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null, // Handle null
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null, // Handle null
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "PatientId": patientId,
        "treatmentId": treatmentId,
        "place": place,
        "fromTeeth": fromTeeth,
        "toTeeth": toTeeth,
        "notes": notes,
        "updatedAt": updatedAt?.toIso8601String(), // Handle null
        "createdAt": createdAt?.toIso8601String(), // Handle null
      };
}
