import 'dart:convert';

CreateAttachmentModel createAttachmentModelFromJson(String str) => CreateAttachmentModel.fromJson(json.decode(str));

String createAttachmentModelToJson(CreateAttachmentModel data) => json.encode(data.toJson());

class CreateAttachmentModel {
  String status;
  String message;
  List<AttachmentData> attachmentData;

  CreateAttachmentModel({
    required this.status,
    required this.message,
    required this.attachmentData,
  });

  factory CreateAttachmentModel.fromJson(Map<String, dynamic> json) => CreateAttachmentModel(
        status: json["status"],
        message: json["message"],
        attachmentData: List<AttachmentData>.from(json["data"].map((x) => AttachmentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(attachmentData.map((x) => x.toJson())),
      };
}

class AttachmentData {
  int? id;
  int? patientId;
  String? title;
  String? url;
  DateTime? updatedAt;
  DateTime? createdAt;

  AttachmentData({
    this.id,
    this.patientId,
    this.title,
    this.url,
    this.updatedAt,
    this.createdAt,
  });

  factory AttachmentData.fromJson(Map<String, dynamic> json) => AttachmentData(
        id: json['id'] as int?,
        title: json['title'] as String?,
        url: json['url'] as String?,
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
        updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        patientId: json['PatientId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "PatientId": patientId,
        "title": title,
        "url": url,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
