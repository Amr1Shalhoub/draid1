import 'dart:convert';

GetAllTreatmentPlanModel getAllTreatmentPlanModelFromJson(String str) =>
    GetAllTreatmentPlanModel.fromJson(json.decode(str));

String getAllTreatmentPlanModelToJson(GetAllTreatmentPlanModel data) =>
    json.encode(data.toJson());

class GetAllTreatmentPlanModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetAllTreatmentPlanModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllTreatmentPlanModel.fromJson(Map<String, dynamic> json) =>
      GetAllTreatmentPlanModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  double? discount;
  int? sessionNumber;
  int? totalCost;
  bool? isCompleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? patientId;

  Datum({
    this.id,
    this.discount,
    this.sessionNumber,
    this.totalCost,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
    this.patientId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        discount: json["discount"]?.toDouble(),
        sessionNumber: json["sessionNumber"],
        totalCost: json["totalCost"],
        isCompleted: json["isCompleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        patientId: json["PatientId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discount": discount,
        "sessionNumber": sessionNumber,
        "totalCost": totalCost,
        "isCompleted": isCompleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "PatientId": patientId,
      };
}
