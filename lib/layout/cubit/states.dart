import 'package:draid/models/add_clinic_model.dart';
import 'package:draid/models/all_patients.dart';
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

abstract class DrAidStates {}

class DrAidAllPatientSuccessState extends DrAidStates {
  final AllPatientsModel allPatientsModel;

  DrAidAllPatientSuccessState(this.allPatientsModel);
}

class DrAidErrorState extends DrAidStates {
  final String message;

  DrAidErrorState(this.message);
}

class DrAidInitialState extends DrAidStates {}

class ChangeBottomScreenState extends DrAidStates {}

class ChangeFinanceScreenState extends DrAidStates {}

class ChangePatientAccountScreenState extends DrAidStates {}

class ChangeMedicine extends DrAidStates {}

class ChangeTreatmentState extends DrAidStates {}

class ChangeCheckBoxState extends DrAidStates {}

class ChangeCheckBoxCompletedState extends DrAidStates {}

class ChangeToothOrGumState extends DrAidStates {}

class ChangeToothOrGumCompletedState extends DrAidStates {}

class DrAidSelectedTreatmentChangedState extends DrAidStates {}

class DrAidSelectedTreatmentChangedCompletedState extends DrAidStates {}

class DrAidLoadingState extends DrAidStates {}

class DrAidLoginSuccessState extends DrAidStates {
  final UserModel userModel;

  DrAidLoginSuccessState(this.userModel);
}

class DrAidLoginErrorState extends DrAidStates {
  final String error;

  DrAidLoginErrorState(this.error);
}

class DrAidClinicSuccessState extends DrAidStates {
  final AddClinicModel addClinicModel;

  DrAidClinicSuccessState(this.addClinicModel);
}

class DrAidClinicErrorState extends DrAidStates {
  final String errorMsg;

  DrAidClinicErrorState(this.errorMsg);
}

class DrAidPatientSuccessState extends DrAidStates {
  final CreatePatientModel createPatientModel;

  DrAidPatientSuccessState(this.createPatientModel);
}

class DrAidPatientErrorState extends DrAidStates {
  final String errorMsg;
  DrAidPatientErrorState(this.errorMsg);
}

class DrAidAllPatientErrorState extends DrAidStates {
  final String errorMsg;
  DrAidAllPatientErrorState(this.errorMsg);
}

class DrAidMedicationSuccessState extends DrAidStates {
  final CreateMedicationModel createMedicationModel;

  DrAidMedicationSuccessState(this.createMedicationModel);
}

class DrAidMedicationErrorState extends DrAidStates {
  final String errorMsg;

  DrAidMedicationErrorState(this.errorMsg);
}

class DrAidDiseaseSuccessState extends DrAidStates {
  final CreateDiseaseModel createDiseaseModel;

  DrAidDiseaseSuccessState(this.createDiseaseModel);
}

class DrAidDiseaseErrorState extends DrAidStates {
  final String errorMsg;

  DrAidDiseaseErrorState(this.errorMsg);
}

class DrAidComplaintSuccessState extends DrAidStates {
  final CreateComplaintModel createComplaintModel;

  DrAidComplaintSuccessState(this.createComplaintModel);
}

class DrAidComplaintErrorState extends DrAidStates {
  final String errorMsg;

  DrAidComplaintErrorState(this.errorMsg);
}

class DrAidAttachmentSuccessState extends DrAidStates {
  final CreateAttachmentModel createAttachmentModel;

  DrAidAttachmentSuccessState(this.createAttachmentModel);
}

class DrAidAttachmentErrorState extends DrAidStates {
  final String errorMsg;

  DrAidAttachmentErrorState(this.errorMsg);
}

class DrAidTreatmentSuccessState extends DrAidStates {
  final TreatmentModel treatmentModel;

  DrAidTreatmentSuccessState(this.treatmentModel);
}

class DrAidTreatmentErrorState extends DrAidStates {
  final String errorMsg;

  DrAidTreatmentErrorState(this.errorMsg);
}

class DrAidTreatmentPlanSuccessState extends DrAidStates {
  final TreatmentPlanModel treatmentPlanModel;

  DrAidTreatmentPlanSuccessState(this.treatmentPlanModel);
}

class DrAidTreatmentPlanErrorState extends DrAidStates {
  final String errorMsg;

  DrAidTreatmentPlanErrorState(this.errorMsg);
}

class DrAidCompletedTreatmentSuccessState extends DrAidStates {
  final CompletedTreatmentModel completedTreatmentModel;

  DrAidCompletedTreatmentSuccessState(this.completedTreatmentModel);
}

class DrAidCompletedTreatmentErrorState extends DrAidStates {
  final String errorMsg;

  DrAidCompletedTreatmentErrorState(this.errorMsg);
}

class DrAidCreateBillSuccessState extends DrAidStates {
  final CreateBillModel createBillModel;

  DrAidCreateBillSuccessState(this.createBillModel);
}

class DrAidCreateBillLoadingState extends DrAidStates {
  final CreateBillModel createBillModel;

  DrAidCreateBillLoadingState(this.createBillModel);
}

class DrAidCreateBillErrorState extends DrAidStates {
  final String errorMsg;

  DrAidCreateBillErrorState(this.errorMsg);
}

class DrAidGetBillForClinicSuccessState extends DrAidStates {
  final GetBillsForClinic getBillsForClinic;

  DrAidGetBillForClinicSuccessState(this.getBillsForClinic);
}

class DrAidGetBillForClinicLoadingState extends DrAidStates {
  final GetBillsForClinic getBillsForClinic;

  DrAidGetBillForClinicLoadingState(this.getBillsForClinic);
}

class DrAidGetBillForClinicErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetBillForClinicErrorState(this.errorMsg);
}

class DrAidAddPaymentSuccessState extends DrAidStates {
  final AddPaymentModel createBillModel;

  DrAidAddPaymentSuccessState(this.createBillModel);
}

class DrAidAddPaymentLoadingState extends DrAidStates {
  final AddPaymentModel createBillModel;

  DrAidAddPaymentLoadingState(this.createBillModel);
}

class DrAidAddPaymentErrorState extends DrAidStates {
  final String errorMsg;

  DrAidAddPaymentErrorState(this.errorMsg);
}

class DrAidGetAllPaymentsSuccessState extends DrAidStates {
  final GetAllPaymentsModel getAllPaymentsModel;

  DrAidGetAllPaymentsSuccessState(this.getAllPaymentsModel);
}

class DrAidGetAllPaymentsLoadingState extends DrAidStates {
  final GetAllPaymentsModel getAllPaymentsModel;

  DrAidGetAllPaymentsLoadingState(this.getAllPaymentsModel);
}

class DrAidGetAllPaymentsErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetAllPaymentsErrorState(this.errorMsg);
}

class DrAidSearchPaymentSuccessState extends DrAidStates {
  final SearchPaymentModel searchPaymentModel;

  DrAidSearchPaymentSuccessState(this.searchPaymentModel);
}

class DrAidSearchPaymentLoadingState extends DrAidStates {
  final SearchPaymentModel searchPaymentModel;

  DrAidSearchPaymentLoadingState(this.searchPaymentModel);
}

class DrAidSearchPaymentErrorState extends DrAidStates {
  final String errorMsg;

  DrAidSearchPaymentErrorState(this.errorMsg);
}

class DrAidIncompleteBillsSuccessState extends DrAidStates {
  final IncompleteBillsModel incompleteBillsModel;

  DrAidIncompleteBillsSuccessState(this.incompleteBillsModel);
}

class DrAidIncompleteBillsLoadingState extends DrAidStates {
  final IncompleteBillsModel incompleteBillsModel;

  DrAidIncompleteBillsLoadingState(this.incompleteBillsModel);
}

class DrAidIncompleteBillsErrorState extends DrAidStates {
  final String errorMsg;

  DrAidIncompleteBillsErrorState(this.errorMsg);
}

class DrAidExpenseSuccessState extends DrAidStates {
  final ExpenseModel expenseModel;

  DrAidExpenseSuccessState(this.expenseModel);
}

class DrAidExpenseLoadingState extends DrAidStates {
  final ExpenseModel expenseModel;

  DrAidExpenseLoadingState(this.expenseModel);
}

class DrAidExpenseErrorState extends DrAidStates {
  final String errorMsg;

  DrAidExpenseErrorState(this.errorMsg);
}

class DrAidGetPatientSuccessState extends DrAidStates {
  final GetPatientModel getPatientModel;

  DrAidGetPatientSuccessState(this.getPatientModel);
}

class DrAidGetPatientLoadingState extends DrAidStates {
  final GetPatientModel getPatientModel;

  DrAidGetPatientLoadingState(this.getPatientModel);
}

class DrAidGetPatientErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetPatientErrorState(this.errorMsg);
}

class DrAidGetAllPatientsSuccessState extends DrAidStates {
  final GetAllPatientsModel getAllPatientsModel;

  DrAidGetAllPatientsSuccessState(this.getAllPatientsModel);
}

class DrAidGetAllPatientsLoadingState extends DrAidStates {
  final GetAllPatientsModel getAllPatientsModel;

  DrAidGetAllPatientsLoadingState(this.getAllPatientsModel);
}

class DrAidGetAllPatientsErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetAllPatientsErrorState(this.errorMsg);
}

class DrAidGetAllTreatmentPlansSuccessState extends DrAidStates {
  final GetAllTreatmentPlanModel getAllTreatmentPlanModel;

  DrAidGetAllTreatmentPlansSuccessState(this.getAllTreatmentPlanModel);
}

class DrAidGetAllTreatmentPlansErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetAllTreatmentPlansErrorState(this.errorMsg);
}

class DrAidAllCompletedTreatmentsSuccessState extends DrAidStates {
  final GetCompletedTreatmentsModel getCompletedTreatmentsModel;

  DrAidAllCompletedTreatmentsSuccessState(this.getCompletedTreatmentsModel);
}

class DrAidAllCompletedTreatmentsErrorState extends DrAidStates {
  final String errorMsg;

  DrAidAllCompletedTreatmentsErrorState(this.errorMsg);
}

class DrAidGetAllTreatmentsSuccessState extends DrAidStates {
  final GetAllTreamentsModel getAllTreamentsModel;

  DrAidGetAllTreatmentsSuccessState(this.getAllTreamentsModel);
}

class DrAidGetAllTreatmentsLoadingState extends DrAidStates {
  final GetAllTreamentsModel getAllTreamentsModel;

  DrAidGetAllTreatmentsLoadingState(this.getAllTreamentsModel);
}

class DrAidGetAllTreatmentsErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetAllTreatmentsErrorState(this.errorMsg);
}
///////////////////////////////////////////////////////////////////

class DrAidRevenuSuccessState extends DrAidStates {
  final RevenuModel revenuModel;

  DrAidRevenuSuccessState(this.revenuModel);
}

class DrAidRevenuLoadingState extends DrAidStates {
  final RevenuModel revenuModel;

  DrAidRevenuLoadingState(this.revenuModel);
}

class DrAidRevenuErrorState extends DrAidStates {
  final String errorMsg;

  DrAidRevenuErrorState(this.errorMsg);
}

class DrAidClinicNetProfitSuccessState extends DrAidStates {
  final ClinicNetProfitModel clinicNetProfitModel;

  DrAidClinicNetProfitSuccessState(this.clinicNetProfitModel);
}

class DrAidClinicNetProfitLoadingState extends DrAidStates {
  final ClinicNetProfitModel clinicNetProfitModel;

  DrAidClinicNetProfitLoadingState(this.clinicNetProfitModel);
}

class DrAidClinicNetProfitErrorState extends DrAidStates {
  final String errorMsg;

  DrAidClinicNetProfitErrorState(this.errorMsg);
}

class DrAidGetPatientPaymentsSuccessState extends DrAidStates {
  final GetPatientPaymentsModel getPatientPaymentsModel;

  DrAidGetPatientPaymentsSuccessState(this.getPatientPaymentsModel);
}

class DrAidGetPatientPaymentsLoadingState extends DrAidStates {
  final GetPatientPaymentsModel getPatientPaymentsModel;

  DrAidGetPatientPaymentsLoadingState(this.getPatientPaymentsModel);
}

class DrAidGetPatientPaymentsErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetPatientPaymentsErrorState(this.errorMsg);
}

class DrAidSearchPatientPaymentSuccessState extends DrAidStates {
  final SearchPatientPaymentModel searchPatientPaymentModel;

  DrAidSearchPatientPaymentSuccessState(this.searchPatientPaymentModel);
}

class DrAidSearchPatientPaymentLoadingState extends DrAidStates {
  final SearchPatientPaymentModel searchPatientPaymentModel;

  DrAidSearchPatientPaymentLoadingState(this.searchPatientPaymentModel);
}

class DrAidSearchPatientPaymentErrorState extends DrAidStates {
  final String errorMsg;

  DrAidSearchPatientPaymentErrorState(this.errorMsg);
}

class DrAidGetAccountStatementSuccessState extends DrAidStates {
  final GetAccountStatementModel getAccountStatementModel;

  DrAidGetAccountStatementSuccessState(this.getAccountStatementModel);
}

class DrAidGetAccountStatementLoadingState extends DrAidStates {
  final GetAccountStatementModel getAccountStatementModel;

  DrAidGetAccountStatementLoadingState(this.getAccountStatementModel);
}

class DrAidGetAccountStatementErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetAccountStatementErrorState(this.errorMsg);
}

class DrAidReportProviderSuccessState extends DrAidStates {
  final ReportProviderModel reportProviderModel;

  DrAidReportProviderSuccessState(this.reportProviderModel);
}

class DrAidReportProviderLoadingState extends DrAidStates {
  final ReportProviderModel reportProviderModel;

  DrAidReportProviderLoadingState(this.reportProviderModel);
}

class DrAidReportProviderErrorState extends DrAidStates {
  final String errorMsg;

  DrAidReportProviderErrorState(this.errorMsg);
}

class DrAidAddPatientPaymentSuccessState extends DrAidStates {
  final AddPatientPaymentModel addPatientPaymentModel;

  DrAidAddPatientPaymentSuccessState(this.addPatientPaymentModel);
}

class DrAidAddPatientPaymentErrorState extends DrAidStates {
  final String errorMsg;

  DrAidAddPatientPaymentErrorState(this.errorMsg);
}

class DrAidAddPatientPaymentLoadingState extends DrAidStates {
  final AddPatientPaymentModel addPatientPaymentModel;

  DrAidAddPatientPaymentLoadingState(this.addPatientPaymentModel);
}

class DrAidCreateAttachmentsSuccessState extends DrAidStates {
  final CreateAttachmentsModel createAttachmentsModel;

  DrAidCreateAttachmentsSuccessState(this.createAttachmentsModel);
}

class DrAidCreateAttachmentsLoadingState extends DrAidStates {
  final CreateAttachmentsModel createAttachmentsModel;

  DrAidCreateAttachmentsLoadingState(this.createAttachmentsModel);
}

class DrAidCreateAttachmentsErrorState extends DrAidStates {
  final String errorMsg;

  DrAidCreateAttachmentsErrorState(this.errorMsg);
}

class DrAidCreateAppointmentSuccessState extends DrAidStates {
  final CreateAppointmentModel createAppointmentModel;

  DrAidCreateAppointmentSuccessState(this.createAppointmentModel);
}

class DrAidCreateAppointmentLoadingState extends DrAidStates {
  final CreateAppointmentModel createAppointmentModel;

  DrAidCreateAppointmentLoadingState(this.createAppointmentModel);
}

class DrAidCreateAppointmentErrorState extends DrAidStates {
  final String errorMsg;

  DrAidCreateAppointmentErrorState(this.errorMsg);
}

class DrAidGetAppointmentsSuccessState extends DrAidStates {
  final GetAppointmentsModel getAppointmentsModel;

  DrAidGetAppointmentsSuccessState(this.getAppointmentsModel);
}

class DrAidGetAppointmentsLoadingState extends DrAidStates {
  final GetAppointmentsModel getAppointmentsModel;

  DrAidGetAppointmentsLoadingState(this.getAppointmentsModel);
}

class DrAidGetAppointmentsErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetAppointmentsErrorState(this.errorMsg);
}

class DrAidGetAppointmentsByDateSuccessState extends DrAidStates {
  final GetAppointmentsByDateModel getAppointmentsByDateModel;

  DrAidGetAppointmentsByDateSuccessState(this.getAppointmentsByDateModel);
}

class DrAidGetAppointmentsByDateLoadingState extends DrAidStates {
  final GetAppointmentsByDateModel getAppointmentsByDateModel;

  DrAidGetAppointmentsByDateLoadingState(this.getAppointmentsByDateModel);
}

class DrAidGetAppointmentsByDateErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetAppointmentsByDateErrorState(this.errorMsg);
}

class DeletingAppointmentState extends DrAidStates {}

class DeleteAppointmentSuccessState extends DrAidStates {}

class DeleteAppointmentErrorState extends DrAidStates {
  final String error;

  DeleteAppointmentErrorState(this.error);
}

class DrAidCreateWaitingListSuccessState extends DrAidStates {
  final CreateWaitingListModel createWaitingListModel;

  DrAidCreateWaitingListSuccessState(this.createWaitingListModel);
}

class DrAidCreateWaitingListLoadingState extends DrAidStates {
  final CreateWaitingListModel createWaitingListModel;

  DrAidCreateWaitingListLoadingState(this.createWaitingListModel);
}

class DrAidCreateWaitingListErrorState extends DrAidStates {
  final String errorMsg;

  DrAidCreateWaitingListErrorState(this.errorMsg);
}

class DrAidGetWaitingListSuccessState extends DrAidStates {
  final GetWaitingListModel getWaitingListModel;

  DrAidGetWaitingListSuccessState(this.getWaitingListModel);
}

class DrAidGetWaitingListLoadingState extends DrAidStates {
  final GetWaitingListModel getWaitingListModel;

  DrAidGetWaitingListLoadingState(this.getWaitingListModel);
}

class DrAidGetWaitingListErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetWaitingListErrorState(this.errorMsg);
}

class DrAidGetWaitingListByDateSuccessState extends DrAidStates {
  final GetWaitingListByDateModel getWaitingListByDateModel;

  DrAidGetWaitingListByDateSuccessState(this.getWaitingListByDateModel);
}

class DrAidGetWaitingListByDateLoadingState extends DrAidStates {
  final GetWaitingListByDateModel getWaitingListByDateModel;

  DrAidGetWaitingListByDateLoadingState(this.getWaitingListByDateModel);
}

class DrAidGetWaitingListByDateErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetWaitingListByDateErrorState(this.errorMsg);
}

class DrAidCheckAvailableTimesSuccessState extends DrAidStates {
  final CheckAvailableTimesModel checkAvailableTimesModel;
  final int index;

  DrAidCheckAvailableTimesSuccessState(
      this.checkAvailableTimesModel, this.index);
}

class DrAidCheckAvailableTimesErrorState extends DrAidStates {
  final String errorMsg;

  DrAidCheckAvailableTimesErrorState(this.errorMsg);
}

class DrAidMoveToAppointmentSuccessState extends DrAidStates {
  final MoveToAppointmentModel moveToAppointmentModel;

  DrAidMoveToAppointmentSuccessState(this.moveToAppointmentModel);
}

class DrAidMoveToAppointmentErrorState extends DrAidStates {
  final String errorMsg;

  DrAidMoveToAppointmentErrorState(this.errorMsg);
}

class DrAidPlanDetailSuccessState extends DrAidStates {
  final PlanDetailModel planDetailModel;

  DrAidPlanDetailSuccessState(this.planDetailModel);
}

class DrAidPlanDetailErrorState extends DrAidStates {
  final String errorMsg;

  DrAidPlanDetailErrorState(this.errorMsg);
}

class DrAidGetPlanDetailSuccessState extends DrAidStates {
  final GetPlanDetailModel getPlanDetailModel;

  DrAidGetPlanDetailSuccessState(this.getPlanDetailModel);
}

class DrAidGetPlanDetailErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetPlanDetailErrorState(this.errorMsg);
}

class DrAidGetPatientDebtsSuccessState extends DrAidStates {
  final GetPatientDebtsModel getPatientDebtsModel;

  DrAidGetPatientDebtsSuccessState(this.getPatientDebtsModel);
}

class DrAidGetPatientDebtsLoadingState extends DrAidStates {
  final GetPatientDebtsModel getPatientDebtsModel;

  DrAidGetPatientDebtsLoadingState(this.getPatientDebtsModel);
}

class DrAidGetPatientDebtsErrorState extends DrAidStates {
  final String errorMsg;

  DrAidGetPatientDebtsErrorState(this.errorMsg);
}

class DrAidChangeBillPaymentIndexState extends DrAidStates {}


class DrAidCreateAssistantSuccessState extends DrAidStates {
  final CreateAssistantModel createAssistantModel;

  DrAidCreateAssistantSuccessState(this.createAssistantModel);
}

class DrAidCreateAssistantErrorState extends DrAidStates {
  final String errorMsg;
  DrAidCreateAssistantErrorState(this.errorMsg);
}

class DrAidCreateSecretarySuccessState extends DrAidStates {
  final CreateSecretaryModel createSecretaryModel;

  DrAidCreateSecretarySuccessState(this.createSecretaryModel);
}

class DrAidCreateSecretaryErrorState extends DrAidStates {
  final String errorMsg;
  DrAidCreateSecretaryErrorState(this.errorMsg);
}
class DrAidChangeDarkOrLightModeState extends DrAidStates {}
class DrAidChangeLanguageState extends DrAidStates {}
