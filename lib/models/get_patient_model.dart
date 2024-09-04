import 'dart:convert';

GetPatientModel getPatientModelFromJson(String str) =>
    GetPatientModel.fromJson(json.decode(str));

String getPatientModelToJson(GetPatientModel data) =>
    json.encode(data.toJson());

class GetPatientModel {
  String status;
  String message;
  Data data;

  GetPatientModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetPatientModel.fromJson(Map<String, dynamic> json) =>
      GetPatientModel(
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
  String fullName;
  String address;
  String email;
  String phoneNumber;
  int age;
  String gender;
  String habits;
  DateTime birthDate;
  DateTime createdAt;
  DateTime updatedAt;
  Medications? medications;
  List<Complaint> complaints;
  Diseases? diseases;
  List<Attachment> attachments;

  Data({
    required this.id,
    required this.fullName,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.gender,
    required this.habits,
    required this.birthDate,
    required this.createdAt,
    required this.updatedAt,
    this.medications,
    required this.complaints,
    this.diseases,
    required this.attachments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fullName: json["fullName"],
        address: json["address"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        age: json["age"],
        gender: json["gender"],
        habits: json["habits"],
        birthDate: DateTime.parse(json["birthDate"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        medications: json["medications"] != null
            ? Medications.fromJson(json["medications"])
            : null,
        complaints: List<Complaint>.from(
            json["complaints"].map((x) => Complaint.fromJson(x))),
        diseases: json["diseases"] != null
            ? Diseases.fromJson(json["diseases"])
            : null,
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "address": address,
        "email": email,
        "phoneNumber": phoneNumber,
        "age": age,
        "gender": gender,
        "habits": habits,
        "birthDate": birthDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "medications": medications?.toJson(),
        "complaints": List<dynamic>.from(complaints.map((x) => x.toJson())),
        "diseases": diseases?.toJson(),
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
      };
}

class Attachment {
  int id;
  String title;
  String url;
  DateTime createdAt;
  DateTime updatedAt;
  int patientId;

  Attachment({
    required this.id,
    required this.title,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.patientId,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        patientId: json["PatientId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "PatientId": patientId,
      };
}

class Complaint {
  int id;
  String complaintText;
  String consultation;
  DateTime createdAt;
  DateTime updatedAt;
  int patientId;

  Complaint({
    required this.id,
    required this.complaintText,
    required this.consultation,
    required this.createdAt,
    required this.updatedAt,
    required this.patientId,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        id: json["id"],
        complaintText: json["complaintText"],
        consultation: json["consultation"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        patientId: json["PatientId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "complaintText": complaintText,
        "consultation": consultation,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "PatientId": patientId,
      };
}

class Diseases {
  int id;
  String diseaseList;
  String notes;
  DateTime createdAt;
  DateTime updatedAt;
  int patientId;

  Diseases({
    required this.id,
    required this.diseaseList,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.patientId,
  });

  factory Diseases.fromJson(Map<String, dynamic> json) => Diseases(
        id: json["id"],
        diseaseList: json["diseaseList"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        patientId: json["PatientId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "diseaseList": diseaseList,
        "notes": notes,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "PatientId": patientId,
      };
}

class Medications {
  int id;
  String medicationList;
  String allergyList;
  DateTime createdAt;
  DateTime updatedAt;
  int patientId;

  Medications({
    required this.id,
    required this.medicationList,
    required this.allergyList,
    required this.createdAt,
    required this.updatedAt,
    required this.patientId,
  });

  factory Medications.fromJson(Map<String, dynamic> json) => Medications(
        id: json["id"],
        medicationList: json["medicationList"],
        allergyList: json["allergyList"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        patientId: json["PatientId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "medicationList": medicationList,
        "allergyList": allergyList,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "PatientId": patientId,
      };
}
