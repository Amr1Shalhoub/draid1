import 'dart:convert';

CreateComplaintModel createComplaintModelFromJson(String str) => CreateComplaintModel.fromJson(json.decode(str));

String createComplaintModelToJson(CreateComplaintModel data) => json.encode(data.toJson());

class CreateComplaintModel {
  String status;
  String message;
  ComplaintData complaintData;

  CreateComplaintModel({
    required this.status,
    required this.message,
    required this.complaintData,
  });

  factory CreateComplaintModel.fromJson(Map<String, dynamic> json) => CreateComplaintModel(
        status: json["status"],
        message: json["message"],
        complaintData: ComplaintData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": complaintData.toJson(),
      };
}

class ComplaintData {
  int? id;
  int? patientId;
  String? complaintText;
  String? consultation;
  DateTime? updatedAt;
  DateTime? createdAt;

  ComplaintData({
    this.id,
    this.patientId,
    this.complaintText,
    this.consultation,
    this.updatedAt,
    this.createdAt,
  });

  factory ComplaintData.fromJson(Map<String, dynamic> json) => ComplaintData(
        id: json['id'] as int?,
        complaintText: json['complaintText'] as String?,
        consultation: json['consultation'] as String?,
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
        updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        patientId: json['PatientId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "PatientId": patientId,
        "complaintText": complaintText,
        "consultation": consultation,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
