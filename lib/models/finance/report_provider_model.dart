// import 'dart:convert';
//
// ReportProviderModel reportProviderModelFromJson(String str) => ReportProviderModel.fromJson(json.decode(str));
//
// String reportProviderModelToJson(ReportProviderModel data) => json.encode(data.toJson());
//
// class ReportProviderModel {
//   String status;
//   String message;
//   List<Datum> data;
//
//   ReportProviderModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory ReportProviderModel.fromJson(Map<String, dynamic> json) => ReportProviderModel(
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
//   int billId;
//   int totalOwed;
//   int totalPaid;
//   int remainingAmount;
//
//   Datum({
//     required this.billId,
//     required this.totalOwed,
//     required this.totalPaid,
//     required this.remainingAmount,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     billId: json["billId"],
//     totalOwed: json["totalOwed"],
//     totalPaid: json["totalPaid"],
//     remainingAmount: json["remainingAmount"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "billId": billId,
//     "totalOwed": totalOwed,
//     "totalPaid": totalPaid,
//     "remainingAmount": remainingAmount,
//   };
// }


import 'dart:convert';

ReportProviderModel reportProviderModelFromJson(String str) => ReportProviderModel.fromJson(json.decode(str));

String reportProviderModelToJson(ReportProviderModel data) => json.encode(data.toJson());

class ReportProviderModel {
  String status;
  String message;
  List<Datum> data;

  ReportProviderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReportProviderModel.fromJson(Map<String, dynamic> json) => ReportProviderModel(
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
  int billId;
  int totalOwed;
  int totalPaid;
  int remainingAmount;

  Datum({
    required this.billId,
    required this.totalOwed,
    required this.totalPaid,
    required this.remainingAmount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    billId: json["billId"] ?? 0,
    totalOwed: json["totalOwed"] ?? 0,
    totalPaid: json["totalPaid"] ?? 0,
    remainingAmount: json["remainingAmount"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "billId": billId,
    "totalOwed": totalOwed,
    "totalPaid": totalPaid,
    "remainingAmount": remainingAmount,
  };
}
