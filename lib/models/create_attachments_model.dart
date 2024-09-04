import 'dart:convert';

CreateAttachmentsModel createAttachmentsModelFromJson(String str) => CreateAttachmentsModel.fromJson(json.decode(str));

String createAttachmentsModelToJson(CreateAttachmentsModel data) => json.encode(data.toJson());

class CreateAttachmentsModel {
  String status;
  String message;
  List<Datum> data;

  CreateAttachmentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateAttachmentsModel.fromJson(Map<String, dynamic> json) => CreateAttachmentsModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int patientId;
  String title;
  String url;
  DateTime updatedAt;
  DateTime createdAt;

  Datum({
    required this.id,
    required this.patientId,
    required this.title,
    required this.url,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    patientId: json["PatientId"],
    title: json["title"],
    url: json["url"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "PatientId": patientId,
    "title": title,
    "url": url,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}
