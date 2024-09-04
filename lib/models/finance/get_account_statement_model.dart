
import 'dart:convert';

GetAccountStatementModel getAccountStatementModelFromJson(String str) => GetAccountStatementModel.fromJson(json.decode(str));

String getAccountStatementModelToJson(GetAccountStatementModel data) => json.encode(data.toJson());

class GetAccountStatementModel {
  String status;
  String message;
  Data data;

  GetAccountStatementModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAccountStatementModel.fromJson(Map<String, dynamic> json) => GetAccountStatementModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int totalCost;
  double discount;
  int discountedAmount;
  int paidAmount;
  int remainingAmount;

  Data({
    required this.totalCost,
    required this.discount,
    required this.discountedAmount,
    required this.paidAmount,
    required this.remainingAmount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalCost: json["totalCost"],
    discount: json["discount"],
    discountedAmount: json["discountedAmount"],
    paidAmount: json["paidAmount"],
    remainingAmount: json["remainingAmount"],
  );

  Map<String, dynamic> toJson() => {
    "totalCost": totalCost,
    "discount": discount,
    "discountedAmount": discountedAmount,
    "paidAmount": paidAmount,
    "remainingAmount": remainingAmount,
  };
}
