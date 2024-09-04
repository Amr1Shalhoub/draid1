import 'dart:convert';

PlanDetailModel planDetailModelFromJson(String str) =>
    PlanDetailModel.fromJson(json.decode(str));

String planDetailModelToJson(PlanDetailModel data) =>
    json.encode(data.toJson());

class PlanDetailModel {
  String? status;
  String? message;
  Data? data;

  PlanDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory PlanDetailModel.fromJson(Map<String, dynamic> json) =>
      PlanDetailModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int id;
  int treatmentPlanId;
  int? fromTeeth;
  int? toTeeth;
  String? place;
  int? cost;
  DateTime? updatedAt;
  DateTime? createdAt;

  Data({
    required this.id,
    required this.treatmentPlanId,
    this.fromTeeth,
    this.toTeeth,
    this.place,
    this.cost,
    this.updatedAt,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        treatmentPlanId: json["TreatmentPlanId"],
        fromTeeth: json["fromTeeth"],
        toTeeth: json["toTeeth"],
        place: json["place"],
        cost: json["cost"],
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "TreatmentPlanId": treatmentPlanId,
        "fromTeeth": fromTeeth,
        "toTeeth": toTeeth,
        "place": place,
        "cost": cost,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
