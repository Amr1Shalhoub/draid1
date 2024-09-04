import 'package:draid/models/create_patient.dart';

class AllPatientsModel {
  String status;
  String message;
  List<PatientData> patientDataList;

  AllPatientsModel({
    required this.status,
    required this.message,
    required this.patientDataList,
  });

  factory AllPatientsModel.fromJson(Map<String, dynamic> json) {
    return AllPatientsModel(
      status: json["status"] ?? '',
      message: json["message"] ?? '',
      patientDataList: List<PatientData>.from(
        json["data"]?.map((item) => PatientData.fromJson(item)) ?? [],
      ),
    );
  }
}
