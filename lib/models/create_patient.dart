import 'package:draid/models/create_attachment_model.dart';
import 'package:draid/models/create_complaint_model.dart';
import 'package:draid/models/create_disease_model.dart';

class CreatePatientModel {
  String status;
  String message;
  PatientData patientData;

  CreatePatientModel({
    required this.status,
    required this.message,
    required this.patientData,
  });

  factory CreatePatientModel.fromJson(Map<String, dynamic> json) =>
      CreatePatientModel(
        status: json["status"],
        message: json["message"],
        patientData: PatientData.fromJson(json["data"]),
      );
}

class PatientData {
  int? id;
  String? fullName;
  String? address;
  String? email;
  String? phoneNumber;
  int? age;
  String? gender;
  String? habits;
  DateTime? birthDate;
  List<CreateComplaintModel>? complaints;
  CreateDiseaseModel? diseases;
  List<CreateAttachmentModel>? attachments;
  DateTime? createdAt;
  DateTime? updatedAt;

  PatientData({
    this.id,
    this.fullName,
    this.address,
    this.email,
    this.phoneNumber,
    this.age,
    this.gender,
    this.habits,
    this.birthDate,
    this.complaints,
    this.diseases,
    this.attachments,
    this.createdAt,
    this.updatedAt,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
      id: json['id'] as int?,
      fullName: json['fullName'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      habits: json['habits'] as String?,
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      complaints: json['complaints'] != null
          ? List<CreateComplaintModel>.from(json['complaints']
              .map((item) => CreateComplaintModel.fromJson(item)))
          : null,
      diseases: json['diseases'] != null
          ? CreateDiseaseModel.fromJson(json['diseases'])
          : null,
      attachments: json['attachments'] != null
          ? List<CreateAttachmentModel>.from(json['attachments']
              .map((item) => CreateAttachmentModel.fromJson(item)))
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  String getAddress() {
    return address ?? '';
  }
}