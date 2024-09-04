import 'dart:convert';

GetAllTreamentsModel getAllTreamentsModelFromJson(String str) =>
    GetAllTreamentsModel.fromJson(json.decode(str));

String getAllTreamentsModelToJson(GetAllTreamentsModel data) =>
    json.encode(data.toJson());

class GetAllTreamentsModel {
  String status;
  String message;
  List<AllTreamentsData> data;

  GetAllTreamentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllTreamentsModel.fromJson(Map<String, dynamic> json) =>
      GetAllTreamentsModel(
        status: json["status"],
        message: json["message"],
        data: List<AllTreamentsData>.from(
            json["data"].map((x) => AllTreamentsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AllTreamentsData {
  int id;
  String title;
  String category;
  int defaultCost;
  String? description;
  String? color;
  DateTime createdAt;
  DateTime updatedAt;
  int clinicId;

  AllTreamentsData({
    required this.id,
    required this.title,
    required this.category,
    required this.defaultCost,
    this.description,
    this.color,
    required this.createdAt,
    required this.updatedAt,
    required this.clinicId,
  });

  factory AllTreamentsData.fromJson(Map<String, dynamic> json) =>
      AllTreamentsData(
        id: json["id"],
        title: json["title"],
        category: json["category"],
        defaultCost: json["defaultCost"],
        description: json["description"] ?? "",
        color: json["color"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        clinicId: json["ClinicId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category,
        "defaultCost": defaultCost,
        "description": description,
        "color": color,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "ClinicId": clinicId,
      };
}
