// import 'dart:convert';
//
// ClinicNetProfitModel clinicNetProfitModelFromJson(String str) => ClinicNetProfitModel.fromJson(json.decode(str));
//
// String clinicNetProfitModelToJson(ClinicNetProfitModel data) => json.encode(data.toJson());
//
// class ClinicNetProfitModel {
//   String status;
//   String message;
//   Data data;
//
//   ClinicNetProfitModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory ClinicNetProfitModel.fromJson(Map<String, dynamic> json) => ClinicNetProfitModel(
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
//   int totalPaidAmount;
//   int totalCosts;
//   int netProfit;
//
//   Data({
//     required this.totalPaidAmount,
//     required this.totalCosts,
//     required this.netProfit,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     totalPaidAmount: json["totalPaidAmount"],
//     totalCosts: json["totalCosts"],
//     netProfit: json["netProfit"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "totalPaidAmount": totalPaidAmount,
//     "totalCosts": totalCosts,
//     "netProfit": netProfit,
//   };
// }



import 'dart:convert';

ClinicNetProfitModel clinicNetProfitModelFromJson(String str) => ClinicNetProfitModel.fromJson(json.decode(str));

String clinicNetProfitModelToJson(ClinicNetProfitModel data) => json.encode(data.toJson());

class ClinicNetProfitModel {
  String status;
  String message;
  Data data;

  ClinicNetProfitModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ClinicNetProfitModel.fromJson(Map<String, dynamic> json) => ClinicNetProfitModel(
    status: json["status"] ?? '',
    message: json["message"] ?? '',
    data: json["data"] != null ? Data.fromJson(json["data"]) : Data(totalPaidAmount: 0, totalCosts: 0, netProfit: 0),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int totalPaidAmount;
  int totalCosts;
  int netProfit;

  Data({
    required this.totalPaidAmount,
    required this.totalCosts,
    required this.netProfit,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalPaidAmount: json["totalPaidAmount"] ?? 0,
    totalCosts: json["totalCosts"] ?? 0,
    netProfit: json["netProfit"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "totalPaidAmount": totalPaidAmount,
    "totalCosts": totalCosts,
    "netProfit": netProfit,
  };
}
