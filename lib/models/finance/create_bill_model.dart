import 'dart:convert';

CreateBillModel createBillFromJson(String str) => CreateBillModel.fromJson(json.decode(str));

String createBillToJson(CreateBillModel data) => json.encode(data.toJson());

class CreateBillModel {
  String status;
  String message;
  Data data;

  CreateBillModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateBillModel.fromJson(Map<String, dynamic> json) => CreateBillModel(
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
  String type;
  int total;
  String content;
  String provider;
  int clinicId;
  DateTime updatedAt;

  Data({
    required this.createdAt,
    required this.id,
    required this.type,
    required this.total,
    required this.content,
    required this.provider,
    required this.clinicId,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createdAt: DateTime.parse(json["createdAt"]),
    id: json["id"],
    type: json["type"],
    total: json["total"],
    content: json["content"],
    provider: json["provider"],
    clinicId: json["ClinicId"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "id": id,
    "type": type,
    "total": total,
    "content": content,
    "provider": provider,
    "ClinicId": clinicId,
    "updatedAt": updatedAt.toIso8601String(),
  };
}
