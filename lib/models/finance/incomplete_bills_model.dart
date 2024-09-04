// import 'dart:convert';
//
// IncompleteBillsModel incompleteBillsModelFromJson(String str) => IncompleteBillsModel.fromJson(json.decode(str));
//
// String incompleteBillsModelToJson(IncompleteBillsModel data) => json.encode(data.toJson());
//
// class IncompleteBillsModel {
//   String status;
//   String message;
//   List<Datum> data;
//
//   IncompleteBillsModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory IncompleteBillsModel.fromJson(Map<String, dynamic> json) => IncompleteBillsModel(
//     status: json["status"],
//     message: json["message"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   int id;
//   String type;
//   int total;
//   String content;
//   String provider;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int clinicId;
//
//   Datum({
//     required this.id,
//     required this.type,
//     required this.total,
//     required this.content,
//     required this.provider,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.clinicId,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     type: json["type"],
//     total: json["total"],
//     content: json["content"],
//     provider: json["provider"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     clinicId: json["ClinicId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "type": type,
//     "total": total,
//     "content": content,
//     "provider": provider,
//     "createdAt": createdAt.toIso8601String(),
//     "updatedAt": updatedAt.toIso8601String(),
//     "ClinicId": clinicId,
//   };
// }





import 'dart:convert';

IncompleteBillsModel incompleteBillsModelFromJson(String str) => IncompleteBillsModel.fromJson(json.decode(str));

String incompleteBillsModelToJson(IncompleteBillsModel data) => json.encode(data.toJson());

class IncompleteBillsModel {
  String status;
  String message;
  List<Datum> data;

  IncompleteBillsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory IncompleteBillsModel.fromJson(Map<String, dynamic> json) => IncompleteBillsModel(
    status: json["status"] ?? '',
    message: json["message"] ?? '',
    data: json["data"] != null
        ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String type;
  int total;
  String content;
  String provider;
  DateTime createdAt;
  DateTime updatedAt;
  int clinicId;

  Datum({
    required this.id,
    required this.type,
    required this.total,
    required this.content,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
    required this.clinicId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? 0,
    type: json["type"] ?? '',
    total: json["total"] ?? 0,
    content: json["content"] ?? '',
    provider: json["provider"] ?? '',
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(),
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : DateTime.now(),
    clinicId: json["ClinicId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "total": total,
    "content": content,
    "provider": provider,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "ClinicId": clinicId,
  };
}
