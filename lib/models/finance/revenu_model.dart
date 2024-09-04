// import 'dart:convert';
//
// RevenuModel revenuModelFromJson(String str) => RevenuModel.fromJson(json.decode(str));
//
// String revenuModelToJson(RevenuModel data) => json.encode(data.toJson());
//
// class RevenuModel {
//   String status;
//   String message;
//   Data data;
//
//   RevenuModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory RevenuModel.fromJson(Map<String, dynamic> json) => RevenuModel(
//     status: json["status"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   int totalRevenue;
//   int totalPaidAmount;
//   int remainingAmount;
//
//   Data({
//     required this.totalRevenue,
//     required this.totalPaidAmount,
//     required this.remainingAmount,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     totalRevenue: json["totalRevenue"],
//     totalPaidAmount: json["totalPaidAmount"],
//     remainingAmount: json["remainingAmount"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "totalRevenue": totalRevenue,
//     "totalPaidAmount": totalPaidAmount,
//     "remainingAmount": remainingAmount,
//   };
// }


import 'dart:convert';

RevenuModel revenuModelFromJson(String str) => RevenuModel.fromJson(json.decode(str));

String revenuModelToJson(RevenuModel data) => json.encode(data.toJson());

class RevenuModel {
  String status;
  String message;
  Data data;

  RevenuModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RevenuModel.fromJson(Map<String, dynamic> json) => RevenuModel(
    status: json["status"] ?? '',
    message: json["message"] ?? '',
    data: json["data"] != null ? Data.fromJson(json["data"]) : Data(totalRevenue: 0, totalPaidAmount: 0, remainingAmount: 0),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int totalRevenue;
  int totalPaidAmount;
  int remainingAmount;

  Data({
    required this.totalRevenue,
    required this.totalPaidAmount,
    required this.remainingAmount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalRevenue: json["totalRevenue"] ?? 0,
    totalPaidAmount: json["totalPaidAmount"] ?? 0,
    remainingAmount: json["remainingAmount"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "totalRevenue": totalRevenue,
    "totalPaidAmount": totalPaidAmount,
    "remainingAmount": remainingAmount,
  };
}
