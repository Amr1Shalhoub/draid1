// // To parse this JSON data, do
// //
// //     final getPatientDebtsModel = getPatientDebtsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetPatientDebtsModel getPatientDebtsModelFromJson(String str) => GetPatientDebtsModel.fromJson(json.decode(str));
//
// String getPatientDebtsModelToJson(GetPatientDebtsModel data) => json.encode(data.toJson());
//
// class GetPatientDebtsModel {
//   String status;
//   String message;
//   List<Datum> data;
//
//   GetPatientDebtsModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory GetPatientDebtsModel.fromJson(Map<String, dynamic> json) => GetPatientDebtsModel(
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
//   String patientName;
//   int treatmentPlanNumber;
//   int totalCost;
//   int amount;
//   int remainingAmount;
//
//   Datum({
//     required this.patientName,
//     required this.treatmentPlanNumber,
//     required this.totalCost,
//     required this.amount,
//     required this.remainingAmount,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     patientName: json["patientName"],
//     treatmentPlanNumber: json["treatmentPlanNumber"],
//     totalCost: json["totalCost"],
//     amount: json["amount"],
//     remainingAmount: json["remainingAmount"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "patientName": patientName,
//     "treatmentPlanNumber": treatmentPlanNumber,
//     "totalCost": totalCost,
//     "amount": amount,
//     "remainingAmount": remainingAmount,
//   };
// }


// import 'dart:convert';
//
// GetPatientDebtsModel getPatientDebtsModelFromJson(String str) => GetPatientDebtsModel.fromJson(json.decode(str));
//
// String getPatientDebtsModelToJson(GetPatientDebtsModel data) => json.encode(data.toJson());
//
// class GetPatientDebtsModel {
//   String status;
//   String message;
//   List<Datum> data;
//
//   GetPatientDebtsModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory GetPatientDebtsModel.fromJson(Map<String, dynamic> json) => GetPatientDebtsModel(
//     status: json["status"] ?? '',
//     message: json["message"] ?? '',
//     data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : [],
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
//   String patientName;
//   int treatmentPlanNumber;
//   int totalCost;
//   int amount;
//   int remainingAmount;
//
//   Datum({
//     required this.patientName,
//     required this.treatmentPlanNumber,
//     required this.totalCost,
//     required this.amount,
//     required this.remainingAmount,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     patientName: json["patientName"] ?? '',
//     treatmentPlanNumber: json["treatmentPlanNumber"] ?? 0,
//     totalCost: json["totalCost"] ?? 0,
//     amount: json["amount"] ?? 0,
//     remainingAmount: json["remainingAmount"] ?? 0,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "patientName": patientName,
//     "treatmentPlanNumber": treatmentPlanNumber,
//     "totalCost": totalCost,
//     "amount": amount,
//     "remainingAmount": remainingAmount,
//   };
// }




import 'dart:convert';

GetPatientDebtsModel getPatientDebtsModelFromJson(String str) => GetPatientDebtsModel.fromJson(json.decode(str));

String getPatientDebtsModelToJson(GetPatientDebtsModel data) => json.encode(data.toJson());

class GetPatientDebtsModel {
  String status;
  String message;
  List<Datum> data;

  GetPatientDebtsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetPatientDebtsModel.fromJson(Map<String, dynamic> json) => GetPatientDebtsModel(
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
  String patientName;
  int id;
  int treatmentPlanNumber;
  int totalCost;
  int amount;
  int remainingAmount;

  Datum({
    required this.patientName,
    required this.id,
    required this.treatmentPlanNumber,
    required this.totalCost,
    required this.amount,
    required this.remainingAmount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    patientName: json["patientName"] ?? '',
    id: json["id"] ?? 0,
    treatmentPlanNumber: json["treatmentPlanNumber"] ?? 0,
    totalCost: json["totalCost"] ?? 0,
    amount: json["amount"] ?? 0,
    remainingAmount: json["remainingAmount"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "patientName": patientName,
    "id": id,
    "treatmentPlanNumber": treatmentPlanNumber,
    "totalCost": totalCost,
    "amount": amount,
    "remainingAmount": remainingAmount,
  };
}
