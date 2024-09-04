import 'dart:convert';

TreatmentModel treatmentModelFromJson(String str) =>
    TreatmentModel.fromJson(json.decode(str));

String treatmentModelToJson(TreatmentModel data) => json.encode(data.toJson());

class TreatmentModel {
  String status;
  String message;
  TreatmentData treatmentData;

  TreatmentModel({
    required this.status,
    required this.message,
    required this.treatmentData,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) => TreatmentModel(
        status: json["status"],
        message: json["message"],
        treatmentData: TreatmentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": treatmentData.toJson(),
      };
}

class TreatmentData {
  int id;
  int clinicId;
  String title;
  String category;
  int defaultCost;
  String description;
  dynamic color;
  DateTime updatedAt;
  DateTime createdAt;

  TreatmentData({
    required this.id,
    required this.clinicId,
    required this.title,
    required this.category,
    required this.defaultCost,
    required this.description,
    required this.color,
    required this.updatedAt,
    required this.createdAt,
  });

  factory TreatmentData.fromJson(Map<String, dynamic> json) => TreatmentData(
        id: json["id"],
        clinicId: json["ClinicId"],
        title: json["title"],
        category: json["category"],
        defaultCost: json["defaultCost"],
        description: json["description"],
        color: json["color"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ClinicId": clinicId,
        "title": title,
        "category": category,
        "defaultCost": defaultCost,
        "description": description,
        "color": color,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
