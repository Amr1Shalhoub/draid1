// ignore_for_file: avoid_print, deprecated_member_use
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/models/add_clinic_model.dart';
import 'package:draid/models/appointments/create_appointment_model.dart';
import 'package:draid/models/appointments/get_appointments_by_date_model.dart';
import 'package:draid/models/appointments/get_appointments_model.dart';
import 'package:draid/models/completed_treatment.dart';
import 'package:draid/models/create_assistant_model.dart';
import 'package:draid/models/create_attachment_model.dart';
import 'package:draid/models/create_attachments_model.dart';
import 'package:draid/models/create_secretary_model.dart';
import 'package:draid/models/finance/add_patient_payment_model.dart';
import 'package:draid/models/finance/add_payment_model.dart';
import 'package:draid/models/finance/clinic_net_profit_model.dart';
import 'package:draid/models/finance/create_bill_model.dart';
import 'package:draid/models/create_complaint_model.dart';
import 'package:draid/models/create_disease_model.dart';
import 'package:draid/models/create_medication_model.dart';
import 'package:draid/models/create_patient.dart';
import 'package:draid/models/finance/expense_model.dart';
import 'package:draid/models/finance/get_account_statement_model.dart';
import 'package:draid/models/finance/get_all_payments_model.dart';
import 'package:draid/models/finance/get_bils_for_clinic.dart';
import 'package:draid/models/finance/get_patient_debts.dart';
import 'package:draid/models/finance/get_patient_payments_model.dart';
import 'package:draid/models/finance/incomplete_bills_model.dart';
import 'package:draid/models/finance/report_provider_model.dart';
import 'package:draid/models/finance/revenu_model.dart';
import 'package:draid/models/finance/search_patient_payment_model.dart';
import 'package:draid/models/finance/search_payment_model.dart';
import 'package:draid/models/get_all_patients_model.dart';
import 'package:draid/models/get_all_treatment_plans_model.dart';
import 'package:draid/models/get_all_treatments_model.dart';
import 'package:draid/models/get_completed_treatments_model.dart';
import 'package:draid/models/get_patient_model.dart';
import 'package:draid/models/get_plan_detail_model.dart';
import 'package:draid/models/plan_detail_model.dart';
import 'package:draid/models/treatment.dart';
import 'package:draid/models/treatment_plan.dart';
import 'package:draid/models/user_model.dart';
import 'package:draid/models/waitinglist/check_available_times_model.dart';
import 'package:draid/models/waitinglist/create_waiting_list_model.dart';
import 'package:draid/models/waitinglist/get_waiting_list_by_model.dart';
import 'package:draid/models/waitinglist/get_waiting_list_model.dart';
import 'package:draid/models/waitinglist/move_to_appointment_model.dart';
import 'package:draid/modules/dashboard/dashboard_screen.dart';
import 'package:draid/modules/finance/account_and_revenues/all_accounts.dart';
import 'package:draid/modules/finance/account_and_revenues/debts_patient.dart';
import 'package:draid/modules/finance/account_and_revenues/revenues.dart';
import 'package:draid/modules/finance/bill_payments.dart';
import 'package:draid/modules/finance/bill_payments/all_payments.dart';
import 'package:draid/modules/finance/bill_payments/expenses.dart';
import 'package:draid/modules/finance/bill_payments/incomplete_bill.dart';
import 'package:draid/modules/finance/bill_payments/provider.dart';
import 'package:draid/modules/finance/patient_account.dart';
import 'package:draid/modules/finance/show_bill_information.dart';
import 'package:draid/modules/patient/attachments/attachments_screen.dart';
import 'package:draid/modules/patient/medicine_and_disease/disease.dart';
import 'package:draid/modules/patient/medicine_and_disease/medicine.dart';
import 'package:draid/modules/patient/medicines_and_diseases.dart';
import 'package:draid/modules/patient/show_basic_information.dart';
import 'package:draid/modules/patient/treatments/complete_treatments.dart';
import 'package:draid/modules/patient/treatments/treatments_information.dart';
import 'package:draid/modules/patient/treatments/treatments_plans.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/network/local/cache_helper.dart';
import 'package:draid/shared/network/local/flutter_secure_storage_helper.dart';
import 'package:draid/shared/network/remote/dio_helper.dart';
import 'package:draid/shared/network/remote/end_points.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jwt_decode/jwt_decode.dart';

class DrAidCubit extends Cubit<DrAidStates> {
  DrAidCubit() : super(DrAidInitialState());

  static DrAidCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  int treatmentindex = 0;
  int medicineindex = 0;
  int financescreenindex = 0;
  int patientAccountIndex = 0;
  int billPaymentsIndex = 0;
  int patientId = 0;

  late List<DatumPatient> allPatients;

  bool checkBoxValue = false;
  bool checkBoxValueCompleted = false;
  String toothOrGum = 'سن';
  String toothOrGumCompleted = 'سن';
  UserModel? userModel;
  AddClinicModel? addClinicModel;
  CreatePatientModel? createPatientModel;
  CreateMedicationModel? createMedicationModel;
  CreateDiseaseModel? createDiseaseModel;
  CreateComplaintModel? createComplaintModel;
  CreateAttachmentModel? createAttachmentModel;
  TreatmentModel? treatmentModel;
  TreatmentPlanModel? treatmentPlanModel;
  PlanDetailModel? planDetailModel;
  GetPlanDetailModel? getPlanDetailModel;
  CompletedTreatmentModel? completedTreatmentModel;
  CreateBillModel? createBillModel;
  GetBillsForClinic? getBillsForClinic;
  AddPaymentModel? addPaymentModel;
  GetAllPaymentsModel? getAllPaymentsModel;
  SearchPaymentModel? searchPaymentModel;
  IncompleteBillsModel? incompleteBillsModel;
  ExpenseModel? expenseModel;
  GetPatientModel? getPatientModel;
  GetAllPatientsModel? getAllPatientsModel;
  GetAllTreatmentPlanModel? getAllTreatmentPlanModel;
  GetAllTreamentsModel? getAllTreamentsModel;
  RevenuModel? revenuModel;
  ClinicNetProfitModel? clinicNetProfitModel;
  GetPatientPaymentsModel? getPatientPaymentsModel;
  SearchPatientPaymentModel? searchPatientPaymentModel;
  GetAccountStatementModel? getAccountStatementModel;
  ReportProviderModel? reportProviderModel;
  CreateAttachmentsModel? createAttachmentsModel;
  AddPatientPaymentModel? addPatientPaymentModel;
  CreateAppointmentModel? createAppointmentModel;
  GetAppointmentsModel? getAppointmentsModel;
  GetAppointmentsByDateModel? getAppointmentsByDateModel;
  CreateWaitingListModel? createWaitingListModel;
  GetWaitingListModel? getWaitingListModel;
  GetWaitingListByDateModel? getWaitingListByDateModel;
  CheckAvailableTimesModel? checkAvailableTimesModel;
  MoveToAppointmentModel? moveToAppointmentModel;
  GetPatientDebtsModel? getPatientDebtsModel;
  CreateAssistantModel? createAssistantModel;
  CreateSecretaryModel? createSecretaryModel;
  List<AllTreamentsData> alltreatments = [];
  String? selectedTreatment;
  String? selectedTreatmentCompleted;
  String? selectedPlace;
  String? selectedPlaceCompleted;
  final String currentDate =
      DateTime.now().toIso8601String().split('T').first;




  void changeDarkOrLightMode(String mode){

    if(mode=='light'||modee=='')
      {
        CacheHelper.saveData(key: 'mode', value: 'light');
        modee=CacheHelper.getData(key: 'mode');
        changeColorsAccordingToMode();
        emit(DrAidChangeDarkOrLightModeState());
      }
   else if(mode=='dark')
    {
      CacheHelper.saveData(key: 'mode', value: 'dark');
      modee=CacheHelper.getData(key: 'mode');
      changeColorsAccordingToMode();
      emit(DrAidChangeDarkOrLightModeState());
    }
   print(modee);
  }
  void changeArabicOrEnglish(String language){

    if(language=='arabic')
    {
      CacheHelper.saveData(key: 'language', value: 'arabic');
      languagee=CacheHelper.getData(key: 'language');
      emit(DrAidChangeLanguageState());
    }
    else if(language=='english')
    {
      CacheHelper.saveData(key: 'language', value: 'english');
      languagee=CacheHelper.getData(key: 'language');
      emit(DrAidChangeLanguageState());
    }
    print(languagee);
  }



  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(DrAidLoadingState());
    EasyLoading.show(status: 'Loading...');

    DioHelper.signUpandLoginPostData(
      url: loginUrl,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      if (value.data != null) {
        userModel = UserModel.fromJson(value.data);
        // print("status: ${userModel?.status}");
        // print("msg: ${userModel?.msg}");
        // print("data: ${userModel?.userData}");
        // print("token: ${userModel?.token}");
        emit(DrAidLoginSuccessState(userModel!));

        // Save token and user ID to shared preferences
       //

        CacheHelper.saveData(key: 'token', value: userModel!.token)
            .then((tokenSaved) {
          if (tokenSaved) {
            CacheHelper.saveData(key: 'id', value: userModel!.data.id)
                .then((idSaved) {
              if (idSaved) {
                print("Token and ID saved successfully");
                int? clinicId = CacheHelper.getData(key: 'id');

                print(clinicId);
                EasyLoading.showSuccess('Login Successful');
                String token=CacheHelper.getData(key: 'token');
                tokennn=token;
              //  FlutterSecure.saveData(key: 'jwt_token', value: userModel!.token);
                Map<String, dynamic> payload = Jwt.parseJwt(token);
                List<dynamic> roles = payload['roles'];
                for (var role in roles)
                  {
                    print(role.toString());
                    CacheHelper.saveData(key: 'role', value: role.toString());


                  }
                roleFromBackend=CacheHelper.getData(key: 'role');
                print(roleFromBackend);

               if(roleFromBackend=='assistant')
                 {
                   getAllTreatments();
                   getAppointments();
                   getWaitingList();
                   getAppointmentsByDate(date: currentDate);
                   getWaitingListByDate(date: currentDate);
                   getAllPatientsData();
                 }
               else if(roleFromBackend=='secretary')
                 {
                   getAllPayments();
                   getBillsForAClinic();
                   getPatientPayments();
                   getAppointments();
                   getWaitingList();
                   getAppointmentsByDate(date: currentDate);
                   getWaitingListByDate(date: currentDate);
                   getAllPatientsData();
                   getPatientDebts();
                 }
               else{
                 getAllTreatments();
                 getAllPayments();
                 getBillsForAClinic();
                 getPatientPayments();
                 getAppointments();
                 getWaitingList();
                 getAppointmentsByDate(date: currentDate);
                 getWaitingListByDate(date: currentDate);
                 getAllPatientsData();
                 getPatientDebts();
               }


                navigateTo(
                  context,
                  const Directionality(
                      textDirection: TextDirection.rtl,
                      child: DashboardScreen()),
                );
                print("navigate");
              } else {
                print("Failed to save ID");
                EasyLoading.showError('Failed to save ID');
                emit(DrAidLoginErrorState("Failed to save ID"));
              }
            });
          } else {
            print("Failed to save token");
            EasyLoading.showError('Failed to save token');
            emit(DrAidLoginErrorState("Failed to save token"));
          }
        });
      } else {
        print("Response data is null");
        EasyLoading.showError('Response data is null');
        emit(DrAidLoginErrorState("Response data is null"));
      }
    }).catchError((error) {
      print('Login Error: $error');
      EasyLoading.showError('Login Error: email or password is incorect');
      emit(DrAidLoginErrorState(error.toString()));
    });
  }
  // void _printToken() async {
  // //  String? token = await FlutterSecure.getData(key: 'jwt_token');
  //   print('Token: $tokennn');
  // }

  void printValue(int index)
  {

  }


  // void createClinic({
  //   required String name,
  //   required String address,
  //   required String telePhoneNumber,
  //   required String phoneNumber,
  //   required String whatsappNumber,
  //   required String ownerName,
  //   required String userEmail,
  //   required String ownerAddress,
  //   required String ownerPhone,
  // }) {
  //   emit(DrAidLoadingState());
  //   EasyLoading.show(status: 'Loading...');
  //
  //   DioHelper.postData(
  //           url: clinic,
  //           data: {
  //             'name': name,
  //             'address': address,
  //             'telePhoneNumber': telePhoneNumber,
  //             'phoneNumber': phoneNumber,
  //             'whatsappNumber': whatsappNumber,
  //             'ownerName': ownerName,
  //             'ownerEmail': userEmail,
  //             'ownerAddress': ownerAddress,
  //             'ownerPhone': ownerPhone,
  //           },
  //           token: CacheHelper.getData(key: 'token'))
  //       .then((value) {
  //     if (value.data != null) {
  //       addClinicModel = AddClinicModel.fromJson(value.data);
  //       print(addClinicModel?.status);
  //       print(addClinicModel?.data);
  //       print(addClinicModel?.message);
  //       print("ownerAddress: ${addClinicModel?.data?.ownerAddress}");
  //       print("ownerPhone: ${addClinicModel?.data?.ownerPhone}");
  //       emit(DrAidClinicSuccessState(addClinicModel!));
  //     } else {
  //       print("Response data is null");
  //       emit(DrAidClinicErrorState("Response data is null"));
  //     }
  //   }).catchError((error) {
  //     print('Create Clinic Error: $error');
  //     emit(DrAidClinicErrorState(error.toString()));
  //   });
  // }

  void createClinic({
    required String name,
    required String address,
    required String telePhoneNumber,
    required String phoneNumber,
    required String whatsappNumber,
    required String ownerName,
    required String ownerEmail, // Use the correct parameter name
    required String ownerAddress,
    required String ownerPhone,
  }) {
    emit(DrAidLoadingState());
   // EasyLoading.show(status: 'Loading...');

    DioHelper.postData(
      url: clinic,
      data: {
        'name': name,
        'address': address,
        'telePhoneNumber': telePhoneNumber,
        'phoneNumber': phoneNumber,
        'whatsappNumber': whatsappNumber,
        'ownerName': ownerName,
        'ownerEmail': ownerEmail, // Consistent naming
        'ownerAddress': ownerAddress,
        'ownerPhone': ownerPhone,
      },

      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      if (value.data != null) {
        addClinicModel = AddClinicModel.fromJson(value.data);
        print(addClinicModel?.status);
        print(addClinicModel?.data);
        print(addClinicModel?.message);
        print("ownerAddress: ${addClinicModel?.data?.ownerAddress}");
        print("ownerPhone: ${addClinicModel?.data?.ownerPhone}");
        emit(DrAidClinicSuccessState(addClinicModel!));
      } else {
        print("Response data is null");
        emit(DrAidClinicErrorState("Response data is null"));
      }
    }).catchError((error) {
      print('Create Clinic Error: $error');
      emit(DrAidClinicErrorState(error.toString()));
    });
  }

  void createAssistant({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String address,
    required String password
  }) {

    print("Sending request to create assistant with data:");
    print({
      "clinicId": CacheHelper.getData(key: 'id'),
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
      "address": address,
      "token":tokennn,
      "password":password,
      //CacheHelper.getData(key: 'token'),
    });

    EasyLoading.show(status: 'Creating assistant...');

    DioHelper.postData(
      url: createAssistantEndPoint,
      data: {
        "ClinicId": CacheHelper.getData(key: 'id'),
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "password":password
      },
      token:tokennn,
      //CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
       // createPatientModel = CreatePatientModel.fromJson(value.data);
        createAssistantModel=CreateAssistantModel.fromJson(value.data);
        print("status: ${createAssistantModel?.status}");
        print(createAssistantModel?.data);
        print(createAssistantModel?.message);
        print("Assistant Address: ${createAssistantModel?.data?.address}");
        print("Assistant Phone: ${createAssistantModel?.data?.phoneNumber}");
        emit(DrAidCreateAssistantSuccessState(createAssistantModel!));
        EasyLoading.showSuccess('Assistant created successfully!');
      } else {
        print("status: ${createAssistantModel?.status}");
        print("Response data is null");
        EasyLoading.showError(
            'Failed to create assistant: Response data is null');
        emit(DrAidPatientErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      EasyLoading.showError('Failed to create patient: $error');
      emit(DrAidPatientErrorState(error.toString()));
    });
  }

  void createSecretary({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String address,
    required String password
  }) {

    print("Sending request to create assistant with data:");
    print({
      "clinicId": CacheHelper.getData(key: 'id'),
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
      "address": address,
      "token":tokennn,
      "password":password,
      //CacheHelper.getData(key: 'token'),
    });

    EasyLoading.show(status: 'Creating assistant...');

    DioHelper.postData(
      url: createAssistantEndPoint,
      data: {
        "ClinicId": CacheHelper.getData(key: 'id'),
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "password":password
      },
      token:tokennn,
      //CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        // createPatientModel = CreatePatientModel.fromJson(value.data);
       // createAssistantModel=CreateAssistantModel.fromJson(value.data);
        createSecretaryModel=CreateSecretaryModel.fromJson(value.data);
        print("status: ${createSecretaryModel?.status}");
        print(createSecretaryModel?.data);
        print(createSecretaryModel?.message);
        print("Assistant Address: ${createSecretaryModel?.data?.address}");
        print("Assistant Phone: ${createSecretaryModel?.data?.phoneNumber}");
        emit(DrAidCreateSecretarySuccessState(createSecretaryModel!));
        EasyLoading.showSuccess('Assistant created successfully!');
      } else {
        print("status: ${createSecretaryModel?.status}");
        print("Response data is null");
        EasyLoading.showError(
            'Failed to create assistant: Response data is null');
        emit(DrAidPatientErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      EasyLoading.showError('Failed to create patient: $error');
      emit(DrAidPatientErrorState(error.toString()));
    });
  }

  void createPatient({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String address,
    required int age,
    required String habits,
    required String gender,
    required DateTime birthDate,
  }) {
    String formattedBirthDate = birthDate.toIso8601String();

    print("Sending request to create patient with data:");
    print({
      "clinicId": CacheHelper.getData(key: 'id'),
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
      "address": address,
      "age": age,
      "habits": habits,
      "gender": gender,
      "birthDate": formattedBirthDate,
      "token": CacheHelper.getData(key: 'token'),
    });

    EasyLoading.show(status: 'Creating patient...');

    DioHelper.postData(
      url: patient,
      data: {
        "clinicId": CacheHelper.getData(key: 'id'),
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "age": age,
        "habits": habits,
        "gender": gender,
        "birthDate": formattedBirthDate,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        createPatientModel = CreatePatientModel.fromJson(value.data);
        print("status: ${createPatientModel?.status}");
        print(createPatientModel?.patientData);
        print(createPatientModel?.message);
        print("ownerAddress: ${createPatientModel?.patientData.address}");
        print("ownerPhone: ${createPatientModel?.patientData.phoneNumber}");
        emit(DrAidPatientSuccessState(createPatientModel!));
        EasyLoading.showSuccess('Patient created successfully!');
        getAllPatientsData();
      } else {
        print("status: ${createPatientModel?.status}");
        print("Response data is null");
        EasyLoading.showError(
            'Failed to create patient: Response data is null');
        emit(DrAidPatientErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      EasyLoading.showError('Failed to create patient: $error');
      emit(DrAidPatientErrorState(error.toString()));
    });
  }

  void createMedicine({
    required int patientId,
    required String medicationList,
    required String allergyList,
  }) {
    print("Sending request to create medicine with data:");
    print({
      'PatientId': patientId,
      'medicationList': medicationList,
      'allergyList': allergyList,
      "token": CacheHelper.getData(key: 'token'),
    });
    EasyLoading.show(status: 'Loading...');

    DioHelper.postData(
            url: '$patient/$patientId/$medication',
            data: {
              'medicationList': medicationList,
              'allergyList': allergyList,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        createMedicationModel = CreateMedicationModel.fromJson(value.data);
        print("status: ${createMedicationModel?.status}");
        print(createMedicationModel?.medicationData);
        print(createMedicationModel?.message);
        print(
            "allergyList: ${createMedicationModel?.medicationData.allergyList}");
        print(
            "medicationList: ${createMedicationModel?.medicationData.medicationList}");
        emit(DrAidMedicationSuccessState(createMedicationModel!));
        getPatientData(patientId: patientId.toString());
        EasyLoading.showSuccess('Medicine created successfully');
      } else {
        print("status: ${createMedicationModel?.status}");
        print("Response data is null");
        emit(DrAidMedicationErrorState("Response data is null"));
        EasyLoading.showError(
            'Failed to create medicine: Response data is null');
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidMedicationErrorState(error.toString()));
      EasyLoading.showError('Failed to create medicine: $error');
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void createDisease({
    required int patientId,
    required String diseaseList,
    required String notes,
  }) {
    print("Sending request to create disease with data:");
    print({
      'PatientId': patientId,
      'diseaseList': diseaseList,
      'notes': notes,
      "token": CacheHelper.getData(key: 'token'),
    });

    EasyLoading.show(status: 'Loading...');

    DioHelper.postData(
      url: '$patient/$patientId/$disease',
      data: {
        'diseaseList': diseaseList,
        'notes': notes,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        createDiseaseModel = CreateDiseaseModel.fromJson(value.data);

        print("status: ${createDiseaseModel?.status}");
        print(createDiseaseModel?.diseaseData);
        print(createDiseaseModel?.message);
        print("diseaseList: ${createDiseaseModel?.diseaseData.diseaseList}");
        print("notes: ${createDiseaseModel?.diseaseData.notes}");
        emit(DrAidDiseaseSuccessState(createDiseaseModel!));
        getPatientData(patientId: patientId.toString());
        EasyLoading.showSuccess('Disease created successfully');
      } else {
        print("status: ${createDiseaseModel?.status}");
        print("Response data is null");
        emit(DrAidDiseaseErrorState("Response data is null"));
        EasyLoading.showError(
            'Failed to create disease: Response data is null');
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidDiseaseErrorState(error.toString()));

      EasyLoading.showError('Failed to create disease: $error');
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void createComplaint({
    required int patientId,
    required String complaintText,
    required String consultation,
  }) {
    print("Sending request to create complaint with data:");
    print({
      'PatientId': patientId,
      'complaintText': complaintText,
      'consultation': consultation,
      "token": CacheHelper.getData(key: 'token'),
    });
    DioHelper.postData(
            url: '$patient/$patientId/$complaint',
            data: {
              'complaintText': complaintText,
              'consultation': consultation,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        createComplaintModel = CreateComplaintModel.fromJson(value.data);

        print("status: ${createComplaintModel?.status}");
        print(createComplaintModel?.complaintData);
        print(createComplaintModel?.message);
        print(
            "complaintText: ${createComplaintModel?.complaintData.complaintText}");
        print(
            "consultation: ${createComplaintModel?.complaintData.consultation}");
        emit(DrAidComplaintSuccessState(createComplaintModel!));
      } else {
        print("status: ${createComplaintModel?.status}");
        print("Response data is null");
        emit(DrAidComplaintErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidComplaintErrorState(error.toString()));
    });
  }

  void createAttachment({
    required int patientId,
    required String title,
    required html.File file,
  }) async {
    // Log the request data
    print("Sending request to create attachments with data:");
    print({
      'PatientId': patientId,
      'title': title,
      'attachments': file.name,
      "token": CacheHelper.getData(key: 'token'),
    });

    // Read the file as bytes
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    final bytes = reader.result as Uint8List;

    // Prepare form data
    FormData formData = FormData.fromMap({
      'title': title,
      'attachments': MultipartFile.fromBytes(bytes, filename: file.name),
    });

    DioHelper.postFormData(
      url: '$patient/$patientId/$attachments',
      formData: formData,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        createAttachmentModel = CreateAttachmentModel.fromJson(value.data);

        print("status: ${createAttachmentModel?.status}");
        print(createAttachmentModel?.attachmentData);
        print(createAttachmentModel?.message);
        print("title: ${createAttachmentModel?.attachmentData[0].title}");
        print("url: ${createAttachmentModel?.attachmentData[0].url}");
        emit(DrAidAttachmentSuccessState(createAttachmentModel!));
      } else {
        print("status: ${createAttachmentModel?.status}");
        print("Response data is null");
        emit(DrAidAttachmentErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidAttachmentErrorState(error.toString()));
    });
  }

  Future<void> createTreatment({
    required String title,
    required String category,
    required int defaultCost,
    required String description,
    required String color,
  }) async {
    // Log the request data
    print("Sending request to create treatment with data:");
    print({
      'clinicId': CacheHelper.getData(key: 'token'),
      'title': title,
      'category': category,
      "defaultCost": defaultCost,
      "description": description,
      "color": color
    });
    int? clinicId = CacheHelper.getData(key: 'id');
    await DioHelper.postData(
            url: '$clinic/$clinicId/$treatment',
            data: {
              'title': title,
              'category': category,
              "defaultCost": defaultCost,
              "description": description,
              "color": color
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        treatmentModel = TreatmentModel.fromJson(value.data);

        print("status: ${treatmentModel?.status}");
        print(treatmentModel?.treatmentData);
        print(treatmentModel?.message);
        print("title: ${treatmentModel?.treatmentData.title}");
        print("category: ${treatmentModel?.treatmentData.category}");

        emit(DrAidTreatmentSuccessState(treatmentModel!));
      } else {
        print("status: ${treatmentModel?.status}");
        print("Response data is null");
        emit(DrAidTreatmentErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidTreatmentErrorState(error.toString()));
    });
  }

  void createTreatmentPlan({
    required int patientId,
    required int sessionNumber,
    required double discount,
    required double totalCost,
  }) {
    // Log the request data
    print("Sending request to create treatment plan with data:");
    print({
      'patientId': patientId,
      'sessionNumber': sessionNumber,
      'discount': discount,
      "totalCost": totalCost,
    });
    DioHelper.postData(
            url: '$patient/$patientId/$treatmentPlan',
            data: {
              'sessionNumber': sessionNumber,
              'discount': discount,
              "totalCost": totalCost,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        treatmentPlanModel = TreatmentPlanModel.fromJson(value.data);

        print("status: ${treatmentPlanModel?.status}");
        print(treatmentPlanModel?.treatmentPlanData);
        print(treatmentPlanModel?.message);
        print(
            "isCompleted: ${treatmentPlanModel?.treatmentPlanData.isCompleted}");
        print(
            "sessionNumber: ${treatmentPlanModel?.treatmentPlanData.sessionNumber}");
        print("totalCost: ${treatmentPlanModel?.treatmentPlanData.totalCost}");

        emit(DrAidTreatmentPlanSuccessState(treatmentPlanModel!));
        getAllTreatmentPlans(patientId: patientId.toString());
      } else {
        print("status: ${treatmentPlanModel?.status}");
        print("Response data is null");
        emit(DrAidTreatmentPlanErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidTreatmentPlanErrorState(error.toString()));
    });
  }

  void createDetail({
    required int treatmentPlanId,
    required int treatmentId,
    int? fromTeeth,
    int? toTeeth,
    required String place,
    required double cost,
  }) {
    const placeMapping = {
      'سن': 'tooth',
      'لثة': 'gums',
      'فم': 'mouth',
    };

    if (!placeMapping.containsKey(place)) {
      throw ArgumentError(
          "Invalid place value: $place. Must be one of ['سن', 'لثة', 'فم'].");
    }

    final serverPlaceValue = placeMapping[place];

    print("Sending request to create detail with data:");
    final requestData = {
      'treatmentId': treatmentId,
      'fromTeeth': fromTeeth,
      'toTeeth': toTeeth,
      'place': serverPlaceValue,
      'cost': cost,
    };

    print(requestData);

    DioHelper.postData(
      url: '$treatmentPlan/$treatmentPlanId/$detail',
      data: requestData,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        PlanDetailModel planDetailModel = PlanDetailModel.fromJson(value.data);

        print("status: ${planDetailModel.status}");
        print(planDetailModel.data);
        print(planDetailModel.message);
        print("fromTeeth: ${planDetailModel.data?.fromTeeth}");
        print("toTeeth: ${planDetailModel.data?.toTeeth}");
        print("place: ${planDetailModel.data?.place}");

        emit(DrAidPlanDetailSuccessState(planDetailModel));
        getAllTreatmentPlans(patientId: patientId.toString());
      } else {
        print("status: ${planDetailModel!.status}");
        print("Response data is null");
        emit(DrAidPlanDetailErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidPlanDetailErrorState(error.toString()));
    });
  }

  void getDetail({
    required String treatmentPlanId,
  }) {
    print("Sending request to get data for a treatment plan detail: ");

    DioHelper.getData(
      url: '$treatmentPlan/$treatmentPlanId/$details',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null && value.data["data"] != null) {
        getPlanDetailModel = GetPlanDetailModel.fromJson(value.data);

        if (getPlanDetailModel != null) {
          print(getPlanDetailModel?.status);
          print(getPlanDetailModel?.data?.first.place ?? 'No place data');
          emit(DrAidGetPlanDetailSuccessState(getPlanDetailModel!));
          getAllTreatmentPlans(patientId: patientId.toString());
        } else {
          print("Deserialization resulted in null");
          emit(
              DrAidGetPlanDetailErrorState("Deserialization resulted in null"));
          getAllTreatmentPlans(patientId: patientId.toString());
        }
      } else {
        print("Response data is null or empty");
        emit(DrAidGetPlanDetailErrorState("Response data is null or empty"));
        getAllTreatmentPlans(patientId: patientId.toString());
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetPlanDetailErrorState(error.toString()));
      getAllTreatmentPlans(patientId: patientId.toString());
    });
  }

  void createCompletedTreatment({
    required int patientId,
    required int treatmentId,
    int? fromTeeth,
    int? toTeeth,
    required String place,
    required String notes,
  }) {
    const placeMapping = {
      'سن': 'tooth',
      'لثة': 'gums',
      'فم': 'mouth',
    };

    if (!placeMapping.containsKey(place)) {
      throw ArgumentError(
          "Invalid place value: $place. Must be one of ['سن', 'لثة', 'فم'].");
    }

    final serverPlaceValue = placeMapping[place];

    print("Sending request to create completed treatment with data:");
    final requestData = {
      'treatmentId': treatmentId,
      'fromTeeth': fromTeeth,
      "toTeeth": toTeeth,
      "place": serverPlaceValue,
      "notes": notes,
    };

    print(requestData);

    DioHelper.postData(
            url: '$patient/$patientId/$completedTreatments',
            data: requestData,
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        completedTreatmentModel = CompletedTreatmentModel.fromJson(value.data);

        print("status: ${completedTreatmentModel?.status}");
        print(completedTreatmentModel?.completedTreatmentData);
        print(completedTreatmentModel?.message);
        print(
            "patientId: ${completedTreatmentModel?.completedTreatmentData!.patientId}");
        print(
            "treatmentId: ${completedTreatmentModel?.completedTreatmentData!.treatmentId}");
        print(
            "notes: ${completedTreatmentModel?.completedTreatmentData!.notes}");
        print(
            "fromTeeth: ${completedTreatmentModel?.completedTreatmentData!.fromTeeth}");
        print(
            "toTeeth: ${completedTreatmentModel?.completedTreatmentData!.toTeeth}");

        emit(DrAidCompletedTreatmentSuccessState(completedTreatmentModel!));
        getAllCompletedTreatments(patientId: patientId.toString());
      } else {
        print("status: ${completedTreatmentModel?.status}");
        print("Response data is null");
        emit(DrAidCompletedTreatmentErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidCompletedTreatmentErrorState(error.toString()));
    });
  }

  void createBill({
    required String type,
    required int total,
    required String content,
    required String provider,
  }) {
    int? clinicId = CacheHelper.getData(key: 'id');
    print("Sending request to create medicine with data:");
    print({
      'clinicId': clinicId,
      'type': type,
      'total': total,
      'content': content,
      'provider': provider,
      "token": CacheHelper.getData(key: 'token'),
    });
    DioHelper.postData(
            url: bill,
            data: {
              'clinicId': clinicId,
              'type': type,
              'total': total,
              'content': content,
              'provider': provider,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        createBillModel = CreateBillModel.fromJson(value.data);
        print("status: ${createBillModel?.status}");
        emit(DrAidCreateBillSuccessState(createBillModel!));
        getBillsForAClinic();
      } else {
        print("status: ${createDiseaseModel?.status}");
        print("Response data is null");
        emit(DrAidCreateBillErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidCreateBillErrorState(error.toString()));
    });
  }

  void getBillsForAClinic() {
    int? clinicId = CacheHelper.getData(key: 'id');

    print("Sending request to get bills for clinic ID: $clinicId");

    DioHelper.getData(
      url: '$clinic/$clinicId/$bills',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        getBillsForClinic = GetBillsForClinic.fromJson(value.data);

        print(getBillsForClinic?.status);
        print(getBillsForClinic?.data[0].content);
        emit(DrAidGetBillForClinicSuccessState(getBillsForClinic!));
      } else {
        print("Response data is null");
        //emit(DrAidPatientErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidPatientErrorState(error.toString()));
    });
  }

  void addPayment({
    required int billId,
    required int amount,
  }) {
    print("Sending request to add payment:");
    print({
      'billId': billId,
      'amount': amount,
      "token": CacheHelper.getData(key: 'token'),
    });
    DioHelper.postData(
            url: payment,
            data: {
              'billId': billId,
              'amount': amount,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        addPaymentModel = AddPaymentModel.fromJson(value.data);
        print("status: ${addPaymentModel?.status}");
        emit(DrAidAddPaymentSuccessState(addPaymentModel!));
        getAllPayments();
      } else {
        print("status: ${addPaymentModel?.status}");
        print("Response data is null");
        emit(DrAidAddPaymentErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidAddPaymentErrorState(error.toString()));
    });
  }

  void getAllPayments() {
    print("Sending request to get all payments : ");

    DioHelper.getData(
      url: payments,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        getAllPaymentsModel = GetAllPaymentsModel.fromJson(value.data);

        print(getAllPaymentsModel?.status);
        //  print(getAllPaymentsModel?.data[2].amount);
        emit(DrAidGetAllPaymentsSuccessState(getAllPaymentsModel!));
      } else {
        print("Response data is null");
        // emit(DrAidGetAllPaymentsErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetAllPaymentsErrorState(error.toString()));
    });
  }

  void searchPaymentFunction({
    required String paymentId,
  }) {
    print("Sending request to get all payments : ");

    DioHelper.getData(
      url: '$searchPayment/$paymentId',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        searchPaymentModel = SearchPaymentModel.fromJson(value.data);

        print(searchPaymentModel?.status);
        print(searchPaymentModel?.data.amount);
        emit(DrAidSearchPaymentSuccessState(searchPaymentModel!));
      } else {
        print("Response data is null");
        emit(DrAidSearchPaymentErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidSearchPaymentErrorState(error.toString()));
    });
  }

  void inCompleteBills({
    required String startDate,
    required String endDate,
  }) {
    int? clinicId = CacheHelper.getData(key: 'id');
    print("Sending request to add payment:");
    print({
      'clinicId': clinicId,
      'startDate': startDate,
      'endDate': endDate,
    });
    DioHelper.postData(
            url: getIncompleteBills,
            data: {
              'clinicId': clinicId,
              'startDate': startDate,
              'endDate': endDate,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        incompleteBillsModel = IncompleteBillsModel.fromJson(value.data);
      //  print("status: ${incompleteBillsModel?.status}");
        // print(incompleteBillsModel?.data[1].content);

        emit(DrAidIncompleteBillsSuccessState(incompleteBillsModel!));
      } else {
        print("status: ${incompleteBillsModel?.status}");
        print("Response data is null");
        emit(DrAidIncompleteBillsErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidIncompleteBillsErrorState(error.toString()));
    });
  }

  void expenseFunction({
    required String startDate,
    required String endDate,
  }) {
    int? clinicId = CacheHelper.getData(key: 'id');

    print("Sending request to add payment:");
    print({
      'clinicId': clinicId,
      'startDate': startDate,
      'endDate': endDate,
    });
    DioHelper.postData(
            url: getexpense,
            data: {
              'clinicId': clinicId,
              'startDate': startDate,
              'endDate': endDate,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        expenseModel = ExpenseModel.fromJson(value.data);
        print("status: ${expenseModel?.status}");
        print(expenseModel?.data.totalPaidAmount);
        emit(DrAidExpenseSuccessState(expenseModel!));
      } else {
        print("status: ${incompleteBillsModel?.status}");
        print("Response data is null");
        // emit(DrAidExpenseErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidExpenseErrorState(error.toString()));
    });
  }

  void getPatientData({
    required String patientId,
  }) {
    print("Sending request to get data for a patient: ");

    DioHelper.getData(
      url: '$patient/$patientId',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        getPatientModel = GetPatientModel.fromJson(value.data);

       // print(getPatientModel?.status);
      //  print(getPatientModel?.data.attachments[0].title);
        emit(DrAidGetPatientSuccessState(getPatientModel!));
      } else {
        print("Response data is null");
        emit(DrAidGetPatientErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetPatientErrorState(error.toString()));
    });
  }

  void getAllPatientsData() {
    print("Sending request to get all payments : ");
    int? clinicId = CacheHelper.getData(key: 'id');
    DioHelper.getData(
      url: '$clinic/$clinicId/$patients',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        getAllPatientsModel = GetAllPatientsModel.fromJson(value.data);

        // print(getAllPatientsModel?.status);
        // print(getAllPatientsModel?.data[0].patientClinic.patientId);
        // print(getAllPatientsModel?.data[0].fullName);
        emit(DrAidGetAllPatientsSuccessState(getAllPatientsModel!));
        if (getAllPatientsModel != null) {
          allPatients = getAllPatientsModel!.data;
        }
      } else {
        print("Response data is null");
        emit(DrAidGetAllPatientsErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetAllPatientsErrorState(error.toString()));
    });
  }

  void revenuFunction({
    required int clinicId,
    required String startDate,
    required String endDate,
    required String token,
  }) {
    print("Sending request to add payment:");
    print({
      'clinicId': clinicId,
      'startDate': startDate,
      'endDate': endDate,
    });
    DioHelper.postData(
            url: getrevenu,
            data: {
              'clinicId': clinicId,
              'startDate': startDate,
              'endDate': endDate,
            },
            token: token)
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        revenuModel = RevenuModel.fromJson(value.data);
        emit(DrAidRevenuLoadingState(revenuModel!));
        print("status: ${revenuModel?.status}");
        print(revenuModel?.data.totalPaidAmount);
        print(revenuModel?.data.totalRevenue);
        emit(DrAidRevenuSuccessState(revenuModel!));
      } else {
        print("status: ${incompleteBillsModel?.status}");
        print("Response data is null");
        // emit(DrAidRevenuErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidRevenuErrorState(error.toString()));
    });
  }

  void getPatientPayments() {
    print("Sending request to get all payments : ");
    int? clinicId = CacheHelper.getData(key: 'id');

    DioHelper.getData(
      url: '$patientpayments/$clinicId',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        getPatientPaymentsModel = GetPatientPaymentsModel.fromJson(value.data);
        print(getPatientPaymentsModel?.status);
        // print(getPatientPaymentsModel?.data[0].amount);
        // print(getPatientPaymentsModel?.data[1].amount);
        // print(getPatientPaymentsModel?.data[2].amount);
        emit(DrAidGetPatientPaymentsSuccessState(getPatientPaymentsModel!));
      } else {
        print("Response data is null");
        // emit(DrAidGetPatientPaymentsErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetPatientPaymentsErrorState(error.toString()));
    });
  }

  void reportProviderFunction({
    required String provider,
    required String startDate,
    required String endDate,
  }) {
    int? clinicId = CacheHelper.getData(key: 'id');
    print("Sending request to add payment:");
    print({
      'clinicId': clinicId,
      'startDate': startDate,
      'endDate': endDate,
    });
    DioHelper.postData(
            url: reportprovider,
            data: {
              'clinicId': clinicId,
              'provider': provider,
              'startDate': startDate,
              'endDate': endDate,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        reportProviderModel = ReportProviderModel.fromJson(value.data);
        emit(DrAidReportProviderLoadingState(reportProviderModel!));

        print("status: ${reportProviderModel?.status}");
        // print(reportProviderModel?.data[0].remainingAmount);
        // print(reportProviderModel?.data[2].remainingAmount);
        // print(clinicNetProfitModel?.data.netProfit);
        // print(reportProviderModel!.data.length);
        emit(DrAidReportProviderSuccessState(reportProviderModel!));
        print(reportProviderModel!.data.length);
      } else {
        print("status: ${incompleteBillsModel?.status}");
        print("Response data is null");
        // emit(DrAidReportProviderErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidReportProviderErrorState(error.toString()));
    });
  }

  void clinicNetProfitFunction({
    required String startDate,
    required String endDate,
  }) {
    int? clinicId = CacheHelper.getData(key: 'id');
    print("Sending request to add payment:");
    print({
      'clinicId': clinicId,
      'startDate': startDate,
      'endDate': endDate,
    });
    DioHelper.postData(
            url: clinicNetProfit,
            data: {
              'clinicId': clinicId,
              'startDate': startDate,
              'endDate': endDate,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        clinicNetProfitModel = ClinicNetProfitModel.fromJson(value.data);
        print("status: ${clinicNetProfitModel?.status}");
        print(clinicNetProfitModel?.data.totalPaidAmount);
        print(clinicNetProfitModel?.data.netProfit);
        emit(DrAidClinicNetProfitSuccessState(clinicNetProfitModel!));
      } else {
        print("status: ${incompleteBillsModel?.status}");
        print("Response data is null");
        //  emit(DrAidClinicNetProfitErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidClinicNetProfitErrorState(error.toString()));
    });
  }

  void getAccountStatement({
    required String id,
    required String id2,
  }) {
    print("Sending request to search a payment : ");

    DioHelper.getData(
      url: '$accountStatement/$id/$id2',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        getAccountStatementModel =
            GetAccountStatementModel.fromJson(value.data);
        print(getAccountStatementModel?.status);
        print(getAccountStatementModel?.data.totalCost);
        print(getAccountStatementModel?.data.paidAmount);
        emit(DrAidGetAccountStatementSuccessState(getAccountStatementModel!));
      } else {
        print("Response data is null");
        emit(DrAidGetAccountStatementErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetAccountStatementErrorState(error.toString()));
    });
  }

  void addPatientPayment({
    required int patientId,
    required int treatmentPlanId,
    required int amount,
  }) {
    int? clinicId = CacheHelper.getData(key: 'id');

    print("Sending request to add payment:");
    print({
      'clinicId': clinicId,
      'patientId': patientId,
      'treatmentPlanId': treatmentPlanId,
      'amount': amount,
    });
    DioHelper.postData(
            url: patientpayment,
            data: {
              'clinicId': clinicId,
              'patientId': patientId,
              'treatmentPlanId': treatmentPlanId,
              'amount': amount,
            },
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        addPatientPaymentModel = AddPatientPaymentModel.fromJson(value.data);

        print("status: ${addPatientPaymentModel?.status}");
        print(addPatientPaymentModel?.data.amount);
        print(addPatientPaymentModel?.data.patientId);
        emit(DrAidAddPatientPaymentSuccessState(addPatientPaymentModel!));
        getPatientPayments();
        getPatientDebts();
        // getAccountStatement(id: patientId.toString(), id2: treatmentPlanId.toString());
      } else {
        print("status: ${incompleteBillsModel?.status}");
        print("Response data is null");
        // emit(DrAidAddPatientPaymentErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidAddPatientPaymentErrorState(error.toString()));
    });
  }

  void getAllTreatmentPlans({
    required String patientId,
  }) {
    print("patientId: $patientId");
    print("Sending request to get all treatment plans : ");

    DioHelper.getData(
      url: '$patient/$patientId/$treatmentPlans',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");
      if (value.data != null) {
        GetAllTreatmentPlanModel getAllTreatmentPlanModel =
            GetAllTreatmentPlanModel.fromJson(value.data);

        print(getAllTreatmentPlanModel.status);
        print(getAllTreatmentPlanModel.data![0].id);
        print("discount: ${getAllTreatmentPlanModel.data![0].discount}");
        print(
            "sessionNumber : ${getAllTreatmentPlanModel.data![0].sessionNumber}");
        print("totalcost: ${getAllTreatmentPlanModel.data![0].totalCost}");
        emit(DrAidGetAllTreatmentPlansSuccessState(getAllTreatmentPlanModel));
      } else {
        print("Response data is null");
        emit(DrAidGetAllTreatmentPlansErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetAllTreatmentPlansErrorState(error.toString()));
    });
  }

  void getAllCompletedTreatments({
    required String patientId,
  }) {
    print("Sending request to get all completed treatment plans : ");

    DioHelper.getData(
      url: '$patient/$patientId/$completedTreatments',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");
      if (value.data != null) {
        GetCompletedTreatmentsModel getCompletedTreatmentsModel =
            GetCompletedTreatmentsModel.fromJson(value.data);

        print(getCompletedTreatmentsModel.status);
        print(getCompletedTreatmentsModel.data![0].id);
        print(
            "treatment title: ${getCompletedTreatmentsModel.data![0].treatment!.title}");
        print(
            "sessionNumber : ${getCompletedTreatmentsModel.data![0].fromTeeth}");
        print(
            "sessionNumber : ${getCompletedTreatmentsModel.data![0].toTeeth}");
        print("notes: ${getCompletedTreatmentsModel.data![0].notes}");

        emit(DrAidAllCompletedTreatmentsSuccessState(
            getCompletedTreatmentsModel));
      } else {
        print("Response data is null");
        emit(DrAidAllCompletedTreatmentsErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidAllCompletedTreatmentsErrorState(error.toString()));
    });
  }

  Future<void> getAllTreatments() async {
    emit(DrAidLoadingState());
    int? clinicId = CacheHelper.getData(key: 'id');

    await DioHelper.getData(
      url: '$clinic/$clinicId/$treatments',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        getAllTreamentsModel = GetAllTreamentsModel.fromJson(value.data);
        alltreatments = getAllTreamentsModel!.data;

        // print(getAllTreamentsModel!.status);
        // print(getAllTreamentsModel!.data[0].id);
        // print(getAllTreamentsModel!.data[0].title);
        emit(DrAidGetAllTreatmentsSuccessState(getAllTreamentsModel!));
      } else {
        print("Response data is null");
        emit(DrAidGetAllTreatmentsErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetAllTreatmentsErrorState(error.toString()));
    });
  }

  // Utility function to determine content type based on file extension
  String _getContentTypeForFilePath(String filePath) {
    String extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpeg':
      case 'jpg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'tiff':
        return 'image/tiff';
      case 'pdf':
        return 'application/pdf';
      default:
        return '';
    }
  }

  // Utility function for web to determine content type based on file bytes
  String _getContentTypeForFileBytes(Uint8List fileBytes) {
    // Example logic, adjust as per your requirement
    // You may need to use different libraries or methods to determine content type from bytes
    if (fileBytes.lengthInBytes >= 2) {
      if (fileBytes[0] == 0xFF && fileBytes[1] == 0xD8) {
        return 'image/jpeg';
      } else if (fileBytes[0] == 0x89 && fileBytes[1] == 0x50) {
        return 'image/png';
      } else if (fileBytes[0] == 0x49 && fileBytes[1] == 0x49) {
        return 'image/tiff';
      } else if (fileBytes[0] == 0x25 && fileBytes[1] == 0x50) {
        return 'application/pdf';
      }
    }
    return '';
  }

  Future<void> createAttachments({
    required int patientId,
    required String title,
    File? file,
    Uint8List? fileBytes, // For web
    required String token,
  }) async {
    try {
      MultipartFile multipartFile;

      if (kIsWeb && fileBytes != null) {
        // For web: Determine content type based on file bytes
        String contentType = _getContentTypeForFileBytes(fileBytes);
        if (contentType.isNotEmpty) {
          multipartFile = MultipartFile.fromBytes(
            fileBytes,
            filename: title, // Set a filename for the web
            contentType: MediaType.parse(contentType),
          );
        } else {
          throw Exception("Unsupported file type");
        }
      } else if (file != null) {
        // For other platforms: Determine content type based on file extension
        String contentType = _getContentTypeForFilePath(file.path);
        if (contentType.isNotEmpty) {
          multipartFile = await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
            contentType: MediaType.parse(contentType),
          );
        } else {
          throw Exception("Unsupported file type");
        }
      } else {
        throw Exception("No file provided");
      }

      FormData formData = FormData.fromMap({
        'patientId': patientId,
        'title': title,
        'attachments': multipartFile,
      });

      var response = await DioHelper.postData(
        url: '$patient/$patientId/$attachments',
        data: formData,
        token: token,
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.data != null) {
        createAttachmentsModel = CreateAttachmentsModel.fromJson(response.data);

        // Handle success response
        createAttachmentsModel = CreateAttachmentsModel.fromJson(response.data);
        emit(DrAidCreateAttachmentsLoadingState(createAttachmentsModel!));

        print(createAttachmentsModel!.status);
        print(createAttachmentsModel!.data[0].url);
        emit(DrAidCreateAttachmentsSuccessState(createAttachmentsModel!));
        getPatientData(patientId: patientId.toString());
      } else {
        // Handle null response
        print("Response data is null");
        // emit(DrAidCreateAttachmentsErrorState("Response data is null"));
      }
    } catch (error) {
      // Handle errors
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidCreateAttachmentsErrorState(error.toString()));
    }
  }

  // Appointments

  Future<void> createAppointment({
    required String patientName,
    required String patientPhone,
    required String date,
    required String startTime,
    required String endTime,
    required String complaint,
  }) async {
    int? clinicId = CacheHelper.getData(key: 'id');

    print("Sending request to create an appointment with data:");
    print({
      "clinicId": clinicId,
      "patientName": patientName,
      "patientPhone": patientPhone,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
      "complaint": complaint,
      "token": CacheHelper.getData(key: 'token'),
    });

    await DioHelper.postData(
      url: '$appointment/$clinic/$clinicId',
      data: {
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "complaint": complaint,
        "patientName": patientName,
        "patientPhone": patientPhone,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        createAppointmentModel = CreateAppointmentModel.fromJson(value.data);

        print("status: ${createAppointmentModel?.status}");

        emit(DrAidCreateAppointmentSuccessState(createAppointmentModel!));
        getAppointmentsByDate(date: date);
      } else {
        print("Response data is null");
        emit(DrAidCreateAppointmentErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidCreateAppointmentErrorState(error.toString()));
    });
  }

  void getAppointments() {
    int? clinicId = CacheHelper.getData(key: 'id');
    print("Sending request to get appointments for a clinic: ");

    DioHelper.getData(
      url: '$appointment/$clinic/$clinicId',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("get Appointments: ");
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        getAppointmentsModel = GetAppointmentsModel.fromJson(value.data);

        print(getAppointmentsModel?.status);

        emit(DrAidGetAppointmentsSuccessState(getAppointmentsModel!));
      } else {
        print("Response data is null");
        emit(DrAidGetAppointmentsErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetAppointmentsErrorState(error.toString()));
    });
  }

  void getAppointmentsByDate({
    required String date,
  }) {
    int? clinicId = CacheHelper.getData(key: 'id');
    print("Sending request to get appointments for a clinic: ");

    DioHelper.getData(
      url: '$appointment/$clinic/$clinicId/$date',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");
      print("date: $date");

      if (value.data != null) {
        getAppointmentsByDateModel =
            GetAppointmentsByDateModel.fromJson(value.data);

        print(getAppointmentsByDateModel?.status);

        emit(DrAidGetAppointmentsByDateSuccessState(
            getAppointmentsByDateModel!));
      } else {
        print("Response data is null");
        emit(DrAidGetAppointmentsByDateErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetAppointmentsByDateErrorState(error.toString()));
    });
  }

  void deleteAppointment({
    required int appointmentId,
  }) {
    print("Sending request to delete appointment: $appointmentId");

    DioHelper.deleteData(
      url: '$appointment/$appointmentId',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.statusCode == 200) {
        print("Appointment deleted successfully");

        getAppointmentsByDate(
            date: DateTime.now().toIso8601String().split('T').first);
        EasyLoading.showSuccess("Appointment deleted successfully");
        emit(DeleteAppointmentSuccessState());
      } else {
        print("Failed to delete appointment");
        EasyLoading.showError("Failed to delete appointment");
        emit(DeleteAppointmentErrorState('Failed to delete appointment'));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DeleteAppointmentErrorState(error.toString()));
    });
  }

  Future<void> createWaitingList({
    required String patientName,
    required String patientPhone,
    required String date,
  }) async {
    int? clinicId = CacheHelper.getData(key: 'id');

    print("Sending request to create a waiting list entry with data:");
    print({
      "clinicId": clinicId,
      "patientName": patientName,
      "patientPhone": patientPhone,
      "date": date,
      "token": CacheHelper.getData(key: 'token'),
    });

    await DioHelper.postData(
      url: '$waitingList/$clinic/$clinicId',
      data: {
        "patientName": patientName,
        "patientPhone": patientPhone,
        "date": date,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        createWaitingListModel = CreateWaitingListModel.fromJson(value.data);

        print("status: ${createWaitingListModel?.status}");

        emit(DrAidCreateWaitingListSuccessState(createWaitingListModel!));
        getWaitingListByDate(date: date);
      } else {
        print("Response data is null");
        emit(DrAidCreateWaitingListErrorState("Response data is null"));
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 500) {
          EasyLoading.showError(
              "Patient is already in the waiting list for this clinic on the same date");
        } else {
          EasyLoading.showError("Request failed with error: ${error.message}");
          print("Error type: ${error.type}");
          print("Error response: ${error.response}");
          print("Error message: ${error.message}");
          print("Error request options: ${error.requestOptions}");
          if (error.response != null) {
            print("Error response data: ${error.response?.data}");
          }
        }
        emit(DrAidCreateWaitingListErrorState(error.toString()));
      } else {
        print("Unexpected error: $error");
        EasyLoading.showError("An unexpected error occurred");
        emit(DrAidCreateWaitingListErrorState(error.toString()));
      }
    });
  }

  void getWaitingList() {
    int? clinicId = CacheHelper.getData(key: 'id');
    print("Sending request to get appointments for a clinic: ");

    DioHelper.getData(
      url: '$waitingList/$clinic/$clinicId',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        getWaitingListModel = GetWaitingListModel.fromJson(value.data);

        print(getWaitingListModel?.status);

        emit(DrAidGetWaitingListSuccessState(getWaitingListModel!));
      } else {
        print("Response data is null");
        emit(DrAidGetWaitingListErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetWaitingListErrorState(error.toString()));
    });
  }

  void getWaitingListByDate({
    required String date,
  }) {
    int? clinicId = CacheHelper.getData(key: 'id');
    print("Sending request to get waiting List for a clinic: ");

    DioHelper.getData(
      url: '$waitingList/$clinic/$clinicId/$date',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        getWaitingListByDateModel =
            GetWaitingListByDateModel.fromJson(value.data);

        print(getWaitingListByDateModel?.status);

        emit(DrAidGetWaitingListByDateSuccessState(getWaitingListByDateModel!));
      } else {
        print("Response data is null");
        emit(DrAidGetWaitingListByDateErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }
      emit(DrAidGetWaitingListByDateErrorState(error.toString()));
    });
  }

  // void checkAvailableTimes({required int waitingListId, required int index}) {
  //   print("Sending request to check available times for clinic: ");
  //   DioHelper.getData(
  //     url: '$waitingList/$check/$waitingListId',
  //     token: CacheHelper.getData(key: 'token'),
  //   ).then((value) {
  //     print("Response status: ${value.statusCode}");
  //     print("Response data: ${value.data}");

  //     if (value.data != null) {
  //       final checkAvailableTimesModel =
  //           CheckAvailableTimesModel.fromJson(value.data);

  //       print(checkAvailableTimesModel.status);

  //       emit(DrAidCheckAvailableTimesSuccessState(
  //           checkAvailableTimesModel, index));

  //     } else {
  //       print("Response data is null");
  //       emit(DrAidCheckAvailableTimesErrorState("Response data is null"));
  //     }
  //   }).catchError((error) {
  //     print("Request failed with error: $error");
  //     if (error is DioError) {
  //       print("Error type: ${error.type}");
  //       print("Error response: ${error.response}");
  //       print("Error message: ${error.message}");
  //       print("Error request options: ${error.requestOptions}");
  //       if (error.response != null) {
  //         print("Error response data: ${error.response?.data}");
  //       }
  //     }
  //     emit(DrAidCheckAvailableTimesErrorState(error.toString()));
  //   });
  //   print("state: $state");
  // }
  void checkAvailableTimes({required int waitingListId, required int index}) {
    print("Sending request to check available times for clinic: ");

    // Show the loading indicator
    EasyLoading.show(status: 'Checking available times...');

    DioHelper.getData(
      url: '$waitingList/$check/$waitingListId',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");

      if (value.data != null) {
        final checkAvailableTimesModel =
            CheckAvailableTimesModel.fromJson(value.data);

        print(checkAvailableTimesModel.status);

        // Hide the loading indicator
        EasyLoading.dismiss();

        emit(DrAidCheckAvailableTimesSuccessState(
            checkAvailableTimesModel, index));
      } else {
        print("Response data is null");

        // Hide the loading indicator and show error message
        EasyLoading.dismiss();
        EasyLoading.showError('Failed to check available times');

        emit(DrAidCheckAvailableTimesErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
        }
      }

      // Hide the loading indicator and show error message
      EasyLoading.dismiss();
      EasyLoading.showError('Error: ${error.toString()}');

      emit(DrAidCheckAvailableTimesErrorState(error.toString()));
    });

    print("state: $state");
  }

  Future<void> moveToAppointment({
    required int appointmentId,
    required String date,
    required String patientName,
    required String patientPhone,
    int? patientId,
    required String startTime,
    required String endTime,
    required String complaint,
  }) async {
    int? clinicId = CacheHelper.getData(key: 'id');
    String token = CacheHelper.getData(key: 'token') ?? '';

    print("Sending request to move to appointment with data:");
    print({
      "clinicId": clinicId,
      "date": date,
      "patientName": patientName,
      "patientPhone": patientPhone,
      "patientId": patientId,
      "startTime": startTime,
      "endTime": endTime,
      "complaint": complaint,
      "token": token,
    });

    try {
      final response = await DioHelper.postData(
        url: '$waitingList/$add/$appointmentId',
        data: {
          "date": date,
          "patientName": patientName,
          "patientPhone": patientPhone,
          "PatientId": patientId,
          "startTime": startTime,
          "endTime": endTime,
          "complaint": complaint,
        },
        token: token,
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.data != null) {
        final moveToAppointmentModel =
            MoveToAppointmentModel.fromJson(response.data);

        print("Appointment added with ID: ${moveToAppointmentModel.data.id}");
        getWaitingListByDate(
            date: DateTime.now().toIso8601String().split('T').first);
        EasyLoading.showSuccess('The appointment has been successfully set.');
        emit(DrAidMoveToAppointmentSuccessState(moveToAppointmentModel));
      } else {
        print("Response data is null");
        emit(DrAidMoveToAppointmentErrorState("Response data is null"));
      }
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 500) {
          EasyLoading.showError(
              "Failed to move to appointment. Internal server error.");
        } else {
          EasyLoading.showError("Request failed with error: ${error.message}");
          print("Error type: ${error.type}");
          print("Error response: ${error.response}");
          print("Error message: ${error.message}");
          print("Error request options: ${error.requestOptions}");
          if (error.response != null) {
            print("Error response data: ${error.response?.data}");
          }
        }
        emit(DrAidMoveToAppointmentErrorState(error.toString()));
      } else {
        print("Unexpected error: $error");
        EasyLoading.showError("An unexpected error occurred");
        emit(DrAidMoveToAppointmentErrorState(error.toString()));
      }
    }
  }

  // PatientDebts

  //Future<void>
 void getPatientDebts(
      // required String clinicId,
      )  {
    print("Sending request to get Patient Debts : ");
    int? clinicId = CacheHelper.getData(key: 'id');
    print(clinicId);

     DioHelper.getData(
      url: '$patientDebts/$clinicId',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print("Response status: ${value.statusCode}");
      print("Response data: ${value.data}");
      //if(${value.me})


      if (value.data != null) {
        getPatientDebtsModel = GetPatientDebtsModel.fromJson(value.data);

        emit(DrAidGetPatientDebtsSuccessState(getPatientDebtsModel!));
       // print(getPatientDebtsModel?.status);
        // print(getPatientDebtsModel?.data[0].patientName);
        // print(getPatientDebtsModel?.data[0].patientName);
        // print(getPatientDebtsModel?.data[0].patientName);
      } else {
        print("Response data is null");
        //emit(DrAidGetPatientDebtsErrorState("Response data is null"));
      }
    }).catchError((error) {
      print("Request failed with error: $error");
      if (error is DioError) {
        print("Error type: ${error.type}");
        print("Error response: ${error.response}");
        print("Error message: ${error.message}");
        print("Error request options: ${error.requestOptions}");
        if (error.response != null) {
          print("Error response data: ${error.response?.data}");
          // if(error.message=="Unknown column 'treatmentplan.totalCost' in 'having clause'")
          //   emit(DrAidGetPatientDebtsSuccessState(getPatientDebtsModel!));
        }
      }
      emit(DrAidGetPatientDebtsErrorState(error.toString()));
    });
  }

// Screens
  void changeMedicineIndex(int medicine) {
    medicineindex = medicine;
    emit(ChangeMedicine());
  }

  void changePatineAccountIndex(int index) {
    patientAccountIndex = index;
    emit(ChangePatientAccountScreenState());
  }

  void changeCurrentIndex(int index) {
    currentindex = index;
    emit(ChangeBottomScreenState());
  }

  void changeFinanceIndex(int index) {
    financescreenindex = index;
    emit(ChangeFinanceScreenState());
  }

  void printCurrentIndex() {}

  List<Widget> bottomPatientscreens = [
    const ShowBasicInformation(),
    MedicinesAndDiseases(),
    TreatmentsInformation(),
    const AttachmentsScreen(),
  ];
  List<Widget> medicineanddiseasescreen = [
    const MedicineScreen(),
    const DiseaseScreen(),
  ];

  List<Widget> bottomFinancescreens = [
    ShowBillInformation(),
    const PatientAccount(), // --> accountAndRevenues
    const BillPayments(), // --> paymentsAndBillAndExpensesAndProvider
  ];

  List<Widget> accountAndRevenues = [
    AllAccounts(),
    const Revenues(),
    DebtsPatient(),
  ];

  List<Widget> paymentsAndBillAndExpensesAndProvider = const [
    AllPayments(),
    IncompleteBill(),
    Expenses(),
    Provider(),
  ];

  // New 1

  void changeTreatmentIndex(int treatmentIndex) {
    treatmentindex = treatmentIndex;
    emit(ChangeTreatmentState());
  }

  void changeCheckBox() {
    checkBoxValue = !checkBoxValue;
    emit(ChangeCheckBoxState());
  }

  void changeCheckBoxCompleted() {
    checkBoxValueCompleted = !checkBoxValueCompleted;
    emit(ChangeCheckBoxCompletedState());
  }

  void changeToothOrGum(String toothorgum) {
    selectedPlace = toothorgum;
    emit(ChangeToothOrGumState());
  }

  void changeToothOrGumCompleted(String toothOrGumCompleted) {
    selectedPlaceCompleted = toothOrGumCompleted;
    emit(ChangeToothOrGumCompletedState());
  }

  void changeSelectedTreatment(String newValue) {
    selectedTreatment = newValue;
    emit(DrAidSelectedTreatmentChangedState());
  }

  void changeSelectedTreatmentCompleted(String newValue) {
    selectedTreatmentCompleted = newValue;
    emit(DrAidSelectedTreatmentChangedCompletedState());
  }

  void changeBillPaymentIndex(int index) {
    billPaymentsIndex = index;
    emit(DrAidChangeBillPaymentIndexState());
  }

  List<Widget> treatmentsScreens = [
    const TreatmentsPlansScreen(),
    const CompleteTreatmentsScreen(),
  ];
}
