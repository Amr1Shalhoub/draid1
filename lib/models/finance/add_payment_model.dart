import 'dart:convert';

AddPaymentModel addPaymentFromJson(String str) => AddPaymentModel.fromJson(json.decode(str));

String addPaymentToJson(AddPaymentModel data) => json.encode(data.toJson());

class AddPaymentModel {
  String status;
  String message;
  Data data;

  AddPaymentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddPaymentModel.fromJson(Map<String, dynamic> json) => AddPaymentModel(
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
  DateTime createdAt;
  int id;
  int billId;
  int amount;
  DateTime updatedAt;

  Data({
    required this.createdAt,
    required this.id,
    required this.billId,
    required this.amount,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createdAt: DateTime.parse(json["createdAt"]),
    id: json["id"],
    billId: json["BillId"],
    amount: json["amount"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "id": id,
    "BillId": billId,
    "amount": amount,
    "updatedAt": updatedAt.toIso8601String(),
  };
}
