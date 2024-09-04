//
// import 'dart:convert';
//
// GetAllPaymentsModel getAllPaymentsModelFromJson(String str) => GetAllPaymentsModel.fromJson(json.decode(str));
//
// String getAllPaymentsModelToJson(GetAllPaymentsModel data) => json.encode(data.toJson());
//
// class GetAllPaymentsModel {
//   String status;
//   String message;
//   List<Datum> data;
//
//   GetAllPaymentsModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory GetAllPaymentsModel.fromJson(Map<String, dynamic> json) => GetAllPaymentsModel(
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
//   int amount;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int billId;
//
//   Datum({
//     required this.id,
//     required this.amount,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.billId,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     amount: json["amount"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     billId: json["BillId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "amount": amount,
//     "createdAt": createdAt.toIso8601String(),
//     "updatedAt": updatedAt.toIso8601String(),
//     "BillId": billId,
//   };
// }


import 'dart:convert';

GetAllPaymentsModel getAllPaymentsModelFromJson(String str) => GetAllPaymentsModel.fromJson(json.decode(str));

String getAllPaymentsModelToJson(GetAllPaymentsModel data) => json.encode(data.toJson());

class GetAllPaymentsModel {
  String status;
  String message;
  List<Datum> data;

  GetAllPaymentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllPaymentsModel.fromJson(Map<String, dynamic> json) => GetAllPaymentsModel(
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
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  int billId;

  Datum({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.billId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? 0,
    amount: json["amount"] ?? 0,
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(),
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : DateTime.now(),
    billId: json["BillId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "BillId": billId,
  };
}
