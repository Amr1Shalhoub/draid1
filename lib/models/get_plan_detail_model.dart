import 'dart:convert';

GetPlanDetailModel? getPlanDetailModelFromJson(String str) {
  final jsonData = json.decode(str);
  return jsonData != null ? GetPlanDetailModel.fromJson(jsonData) : null;
}

String getPlanDetailModelToJson(GetPlanDetailModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class GetPlanDetailModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetPlanDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetPlanDetailModel.fromJson(Map<String, dynamic> json) =>
      GetPlanDetailModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : null,
      };
}

class Datum {
  int? id;
  int? fromTeeth;
  int? toTeeth;
  String? place;
  int? cost;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? treatmentPlanId;
  List<Treatment>? treatments;

  Datum({
    this.id,
    this.fromTeeth,
    this.toTeeth,
    this.place,
    this.cost,
    this.createdAt,
    this.updatedAt,
    this.treatmentPlanId,
    this.treatments,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fromTeeth: json["fromTeeth"],
        toTeeth: json["toTeeth"],
        place: json["place"],
        cost: json["cost"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        treatmentPlanId: json["TreatmentPlanId"],
        treatments: json["treatments"] != null
            ? List<Treatment>.from(
                json["treatments"].map((x) => Treatment.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fromTeeth": fromTeeth,
        "toTeeth": toTeeth,
        "place": place,
        "cost": cost,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "TreatmentPlanId": treatmentPlanId,
        "treatments": treatments != null
            ? List<dynamic>.from(treatments!.map((x) => x.toJson()))
            : null,
      };
}

class Treatment {
  String? title;
  String? category;
  int? defaultCost;
  PlanDetailTreatments? planDetailTreatments;

  Treatment({
    this.title,
    this.category,
    this.defaultCost,
    this.planDetailTreatments,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        title: json["title"],
        category: json["category"],
        defaultCost: json["defaultCost"],
        planDetailTreatments: json["plan_detail_treatments"] != null
            ? PlanDetailTreatments.fromJson(json["plan_detail_treatments"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "defaultCost": defaultCost,
        "plan_detail_treatments": planDetailTreatments?.toJson(),
      };
}

class PlanDetailTreatments {
  DateTime? createdAt;
  DateTime? updatedAt;
  int? planDetailId;
  int? treatmentId;

  PlanDetailTreatments({
    this.createdAt,
    this.updatedAt,
    this.planDetailId,
    this.treatmentId,
  });

  factory PlanDetailTreatments.fromJson(Map<String, dynamic> json) =>
      PlanDetailTreatments(
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        planDetailId: json["PlanDetailId"],
        treatmentId: json["treatmentId"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "PlanDetailId": planDetailId,
        "treatmentId": treatmentId,
      };
}
