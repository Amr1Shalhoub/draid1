import 'dart:convert';

CreateDiseaseModel createDiseaseModelFromJson(String str) => CreateDiseaseModel.fromJson(json.decode(str));

String createDiseaseModelToJson(CreateDiseaseModel data) => json.encode(data.toJson());

class CreateDiseaseModel {
  String status;
  String message;
  DiseaseData diseaseData;

  CreateDiseaseModel({
    required this.status,
    required this.message,
    required this.diseaseData,
  });

  factory CreateDiseaseModel.fromJson(Map<String, dynamic> json) => CreateDiseaseModel(
        status: json["status"],
        message: json["message"],
        diseaseData: DiseaseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": diseaseData.toJson(),
      };
}

class DiseaseData {
  int? id;
  int? patientId;
  String? diseaseList;
  String? notes;
  DateTime? updatedAt;
  DateTime? createdAt;

  DiseaseData({
    this.id,
    this.patientId,
    this.diseaseList,
    this.notes,
    this.updatedAt,
    this.createdAt,
  });

  factory DiseaseData.fromJson(Map<String, dynamic> json) => DiseaseData(
        id: json['id'] as int?,
        diseaseList: json['diseaseList'] as String?,
        notes: json['notes'] as String?,
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
        updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        patientId: json['PatientId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "PatientId": patientId,
        "diseaseList": diseaseList,
        "notes": notes,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
