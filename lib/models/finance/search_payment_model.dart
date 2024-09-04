import 'dart:convert';

SearchPaymentModel searchPaymentModelFromJson(String str) => SearchPaymentModel.fromJson(json.decode(str));

String searchPaymentModelToJson(SearchPaymentModel data) => json.encode(data.toJson());

class SearchPaymentModel {
  String status;
  String message;
  Data data;

  SearchPaymentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchPaymentModel.fromJson(Map<String, dynamic> json) => SearchPaymentModel(
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
  int id;
  int amount;
  DateTime createdAt;
  DateTime updatedAt;
  int billId;

  Data({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.billId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    amount: json["amount"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    billId: json["BillId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "BillId": billId,
  };
}
