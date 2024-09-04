import 'dart:convert';

GetCompletedTreatmentsModel getCompletedTreatmentsModelFromJson(String str) =>
    GetCompletedTreatmentsModel.fromJson(json.decode(str));

String getCompletedTreatmentsModelToJson(GetCompletedTreatmentsModel data) =>
    json.encode(data.toJson());

class GetCompletedTreatmentsModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetCompletedTreatmentsModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetCompletedTreatmentsModel.fromJson(Map<String, dynamic> json) =>
      GetCompletedTreatmentsModel(
        status: json["status"] as String?,
        message: json["message"] as String?,
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
  String? notes;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? treatmentId;
  int? patientId;
  Treatment? treatment;

  Datum({
    this.id,
    this.fromTeeth,
    this.toTeeth,
    this.place,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.treatmentId,
    this.patientId,
    this.treatment,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] as int?,
        fromTeeth: json["fromTeeth"] != null ? json["fromTeeth"] as int? : null,
        toTeeth: json["toTeeth"] != null ? json["toTeeth"] as int? : null,
        place: json["place"] as String?,
        notes: json["notes"] as String?,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        treatmentId: json["treatmentId"] as int?,
        patientId: json["PatientId"] as int?,
        treatment: json["treatment"] != null
            ? Treatment.fromJson(json["treatment"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fromTeeth": fromTeeth,
        "toTeeth": toTeeth,
        "place": place,
        "notes": notes,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "treatmentId": treatmentId,
        "PatientId": patientId,
        "treatment": treatment?.toJson(),
      };
}

class Treatment {
  String? title;
  String? category;
  String? color;

  Treatment({
    this.title,
    this.category,
    this.color,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        title: json["title"] as String?,
        category: json["category"] as String?,
        color: json["color"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "color": color,
      };
}
