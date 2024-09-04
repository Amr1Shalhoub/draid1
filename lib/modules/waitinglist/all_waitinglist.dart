// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/models/waitinglist/check_available_times_model.dart';
import 'package:draid/modules/appointments/all_appointments.dart';
import 'package:draid/modules/sidebar/side_bar_screen.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/network/local/cache_helper.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AllWaitingList extends StatefulWidget {
  const AllWaitingList({super.key});

  @override
  State<AllWaitingList> createState() => _AllWaitingListState();
}

class _AllWaitingListState extends State<AllWaitingList> {
  @override
  void initState() {
    super.initState();
    final cubit = DrAidCubit.get(context);
    cubit.getAllPatientsData();
    cubit.getWaitingListByDate(
        date: DateTime.now().toIso8601String().split('T').first);
  }

  DateTime? fromDate;
  DateTime? toDate;
  String? fromDateString;
  String? toDateString;
  String patientId = '0';

  TextEditingController complaintController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController patientPhoneController = TextEditingController();

  void _onFromDateChanged(DateTime date) {
    setState(() {
      fromDate = date;
    });
  }


  void addWaitingAppointmentToPatient(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<DrAidCubit, DrAidStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if(languagee=='arabic')
              {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: SimpleDialog(
                    title: const Padding(
                      padding: EdgeInsetsDirectional.only(start: 30),
                      child: Text(
                        'إضافة موعد انتظار',
                        style: TextStyle(
                          fontSize: 24,
                          color: simpleDialogTitleColor,
                        ),
                      ),
                    ),
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.arrow_forward),
                                    const SizedBox(width: 20),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'العودة',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: fontColor2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: 150,
                                    child: MyDatePicker(
                                      title: 'التاريخ',
                                      initialDate: DateTime.now(),
                                      onDateChanged: _onDateChanged,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  _buildTextField(
                                    context,
                                    controller: patientNameController,
                                    label: 'اسم المريض',
                                    validation: _validatePatientName,
                                  ),
                                  const SizedBox(height: 20),
                                  _buildTextField(
                                    context,
                                    controller: patientPhoneController,
                                    label: 'رقم المريض',
                                    validation: _validatePatientPhone,
                                  ),
                                  const SizedBox(height: 60),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorManager.buttonColor,
                                    ),
                                    onPressed: () async {
                                      if (!_validateFields(context)) return;

                                      fromDateString = fromDate!
                                          .toIso8601String()
                                          .substring(0, 10);

                                      await DrAidCubit.get(context)
                                          .createWaitingList(
                                        patientName: patientNameController.text,
                                        patientPhone: patientPhoneController.text,
                                        date: fromDateString!,
                                      );

                                      Navigator.pop(context);
                                      if (state
                                      is DrAidCreateWaitingListSuccessState &&
                                          DrAidCubit.get(context)
                                              .getWaitingListModel
                                              ?.data!
                                              .length !=
                                              null) {}
                                    },
                                    child: const Text(
                                      "إضافة",
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            else{
              return Directionality(
                textDirection: TextDirection.ltr,
                child: SimpleDialog(
                  title: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 30),
                    child: Text(
                      'Add to waiting',
                      style: TextStyle(
                        fontSize: 24,
                        color: simpleDialogTitleColor,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.arrow_forward),
                                  const SizedBox(width: 20),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Back',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: fontColor2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 150,
                                  child: MyDatePicker(
                                    title: 'Date',
                                    initialDate: DateTime.now(),
                                    onDateChanged: _onDateChanged,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                _buildTextField(
                                  context,
                                  controller: patientNameController,
                                  label: 'Name',
                                  validation: _validatePatientName,
                                ),
                                const SizedBox(height: 20),
                                _buildTextField(
                                  context,
                                  controller: patientPhoneController,
                                  label: 'Phone number',
                                  validation: _validatePatientPhone,
                                ),
                                const SizedBox(height: 60),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorManager.buttonColor,
                                  ),
                                  onPressed: () async {
                                    if (!_validateFields(context)) return;

                                    fromDateString = fromDate!
                                        .toIso8601String()
                                        .substring(0, 10);

                                    await DrAidCubit.get(context)
                                        .createWaitingList(
                                      patientName: patientNameController.text,
                                      patientPhone: patientPhoneController.text,
                                      date: fromDateString!,
                                    );

                                    Navigator.pop(context);
                                    if (state
                                    is DrAidCreateWaitingListSuccessState &&
                                        DrAidCubit.get(context)
                                            .getWaitingListModel
                                            ?.data!
                                            .length !=
                                            null) {}
                                  },
                                  child: const Text(
                                    "Add",
                                    style: TextStyle(color: white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

          },
        );
      },
    );
  }

  bool _validateFields(BuildContext context) {
    if (fromDate == null) {
      EasyLoading.showError('التاريخ مطلوب');
      return false;
    }

    if (_validatePatientName(patientNameController.text) != null ||
        _validatePatientPhone(patientPhoneController.text) != null) {
      return false;
    }

    return true;
  }

  String? _validatePatientName(String value) {
    if (value.isEmpty) {
      EasyLoading.showError('رجاءً ادخل اسم المريض');
      return 'رجاءً ادخل اسم المريض';
    }
    return null;
  }

  String? _validatePatientPhone(String value) {
    final phonePattern = RegExp(r'^\+?[0-9]{10,15}$');
    if (value.isEmpty) {
      EasyLoading.showError('رجاءً ادخل رقم المريض');
      return 'رجاءً ادخل رقم المريض';
    } else if (!phonePattern.hasMatch(value)) {
      EasyLoading.showError(
          'رقم الهاتف يجب أن يكون بين 10 و 15 رقمًا ويحتوي على الأرقام فقط أو "+"');
      return 'رقم الهاتف غير صالح';
    }
    return null;
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String? Function(String) validation,
  }) {
    return Container(
      height: 35,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      margin: const EdgeInsetsDirectional.only(start: 20),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 15),
        child: AddTreatmentFormField(
          type: TextInputType.text,
          controller: controller,
          validate: (value) => validation(value ?? ''),
          label: label,
        ),
      ),
    );
  }

  void _onDateChanged(DateTime date) {
    fromDate = date;
  }

  void showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (context) {
            if(languagee=='arabic')
              {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: const Text('مواعيد يوم آخر..'),
                    content: SizedBox(
                      height: 120,
                      child: MyDatePicker(
                        title: 'اختر يوم',
                        initialDate: DateTime.now(),
                        onDateChanged: _onFromDateChanged,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.buttonColor,
                        ),
                        onPressed: () {
                          if (fromDate != null) {
                            fromDateString = fromDate!.toIso8601String();

                            // Add your logic to use the date strings
                          } else {}
                          if (fromDateString != null) {
                            CacheHelper.getData(key: 'id');
                            fromDateString = fromDateString?.substring(0, 10);
                            DrAidCubit.get(context)
                                .getWaitingListByDate(date: fromDateString!);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "تأكيد",
                          style: TextStyle(color: white),
                        ),
                      ),
                    ],
                  ),
                );
              }
            else{
              return Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: const Text('Appointments'),
                  content: SizedBox(
                    height: 120,
                    child: MyDatePicker(
                      title: 'Day',
                      initialDate: DateTime.now(),
                      onDateChanged: _onFromDateChanged,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.buttonColor,
                      ),
                      onPressed: () {
                        if (fromDate != null) {
                          fromDateString = fromDate!.toIso8601String();

                          // Add your logic to use the date strings
                        } else {}
                        if (fromDateString != null) {
                          CacheHelper.getData(key: 'id');
                          fromDateString = fromDateString?.substring(0, 10);
                          DrAidCubit.get(context)
                              .getWaitingListByDate(date: fromDateString!);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: white),
                      ),
                    ),
                  ],
                ),
              );
            }

          }
        );
      },
    );
  }

  void _showAvailableTimesDialog(
      BuildContext context, CheckAvailableTimesModel model, int index) {
    final waitingListData =
        DrAidCubit.get(context).getWaitingListByDateModel!.data![index];
    final appointmentId = waitingListData.id;
    print("appointmentId: $appointmentId");
    showDialog(
      context: context,
      builder: (context) {
        final dateString = model.data!.date?.toIso8601String().split('T').first;

        final dateController = TextEditingController(text: dateString);
        final patientNameController =
            TextEditingController(text: model.data!.patientName);
        final patientPhoneController =
            TextEditingController(text: model.data!.patientPhone);
        final startTimeController =
            TextEditingController(text: model.data!.startTime);
        final endTimeController =
            TextEditingController(text: model.data!.endTime);
        final complaintController =
            TextEditingController(text: model.data!.complaint);

        return Builder(
          builder: (context) {
            if(languagee=='arabic')
              {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: const Text('تثبيت الموعد'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: dateController,
                            readOnly: true,
                            decoration: const InputDecoration(labelText: 'التاريخ'),
                          ),
                          TextFormField(
                            controller: patientNameController,
                            readOnly: true,
                            decoration: const InputDecoration(labelText: 'اسم المريض'),
                          ),
                          TextFormField(
                            controller: patientPhoneController,
                            readOnly: true,
                            decoration: const InputDecoration(labelText: 'رقم المريض'),
                          ),
                          TextFormField(
                            controller: startTimeController,
                            readOnly: true,
                            decoration: const InputDecoration(labelText: 'بداية الموعد'),
                          ),
                          TextFormField(
                            controller: endTimeController,
                            readOnly: true,
                            decoration: const InputDecoration(labelText: 'نهاية الموعد'),
                          ),
                          TextFormField(
                            controller: complaintController,
                            decoration: const InputDecoration(labelText: 'سبب الموعد'),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: const Text('إلغاء'),
                      // ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.buttonColor,
                          ),
                          onPressed: () {
                            DrAidCubit.get(context).moveToAppointment(
                              appointmentId: appointmentId!,
                              complaint: complaintController.text,
                              date: dateController.text,
                              startTime: startTimeController.text,
                              endTime: endTimeController.text,
                              patientName: patientNameController.text,
                              patientPhone: patientPhoneController.text,
                            );
                            DrAidCubit.get(context).getWaitingListByDate(
                                date: DateTime.now().toIso8601String().split('T').first);
                            Navigator.of(context).pop();
                          },
                          child: const Text('تثبيت', style: TextStyle(color: white)),
                        ),
                      ),
                    ],
                  ),
                );
              }
            else{
              return Directionality(
                textDirection: TextDirection.ltr,
                child: AlertDialog(
                  title: const Text('Appointment'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: dateController,
                          readOnly: true,
                          decoration: const InputDecoration(labelText: 'Date'),
                        ),
                        TextFormField(
                          controller: patientNameController,
                          readOnly: true,
                          decoration: const InputDecoration(labelText: 'Name'),
                        ),
                        TextFormField(
                          controller: patientPhoneController,
                          readOnly: true,
                          decoration: const InputDecoration(labelText: 'Phone number'),
                        ),
                        TextFormField(
                          controller: startTimeController,
                          readOnly: true,
                          decoration: const InputDecoration(labelText: 'Start'),
                        ),
                        TextFormField(
                          controller: endTimeController,
                          readOnly: true,
                          decoration: const InputDecoration(labelText: 'End'),
                        ),
                        TextFormField(
                          controller: complaintController,
                          decoration: const InputDecoration(labelText: 'Reason'),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: const Text('إلغاء'),
                    // ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.buttonColor,
                        ),
                        onPressed: () {
                          DrAidCubit.get(context).moveToAppointment(
                            appointmentId: appointmentId!,
                            complaint: complaintController.text,
                            date: dateController.text,
                            startTime: startTimeController.text,
                            endTime: endTimeController.text,
                            patientName: patientNameController.text,
                            patientPhone: patientPhoneController.text,
                          );
                          DrAidCubit.get(context).getWaitingListByDate(
                              date: DateTime.now().toIso8601String().split('T').first);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Confirm', style: TextStyle(color: white)),
                      ),
                    ),
                  ],
                ),
              );
            }

          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    return BlocConsumer<DrAidCubit, DrAidStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DrAidGetWaitingListLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DrAidGetWaitingListByDateSuccessState &&
            DrAidCubit.get(context).getAppointmentsByDateModel!.data!.length !=
                null) {
          return Builder(
            builder: (context) {
              if(languagee=='arabic')
                {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      backgroundColor: coolWhite2,
                      appBar: const CustomAppBar(),
                      body: Row(
                        children: [
                          if(screenWidth>1530)
                            const SideBarScreen(),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.80,
                                height: 700,
                                color: coolWhite2,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    children: [
                                      if(screenWidth>=850)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 20, end: 130),
                                          child: Row(
                                            children: [

                                              Builder(
                                                  builder: (context) {
                                                    if(modee=='light')
                                                    {
                                                      return InkWell(
                                                        child: const Image(
                                                          image: AssetImage('images/arrow.png'),
                                                          width: 30,
                                                          height: 20,
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }
                                                    else{
                                                      return InkWell(
                                                        child: Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }

                                                  }
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300&&modee=='light')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 130,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة المواعيد   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'مواعيد',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد انتظار يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          ' إضافة موعد للانتظار',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          ' إضافة',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      if(screenWidth<850&&screenWidth>=700)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 20, end: 20),
                                          child: Row(
                                            children: [
                                              Builder(
                                                  builder: (context) {
                                                    if(modee=='light')
                                                    {
                                                      return InkWell(
                                                        child: const Image(
                                                          image: AssetImage('images/arrow.png'),
                                                          width: 30,
                                                          height: 20,
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }
                                                    else{
                                                      return InkWell(
                                                        child: Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }

                                                  }
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300&&modee=='light')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 130,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة المواعيد   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'مواعيد',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد انتظار يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          ' إضافة موعد للانتظار',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          ' إضافة',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      if(screenWidth<700)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 5, end: 5),
                                          child: Row(
                                            children: [

                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300&&modee=='light')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 130,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة المواعيد   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'مواعيد',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد انتظار يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          ' إضافة موعد للانتظار',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          ' إضافة',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 60),
                                      Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(end: 175.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.70,
                                          height: 450,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 18),
                                              if(screenWidth>=1400)
                                                const Padding(
                                                  padding:
                                                  EdgeInsetsDirectional.only(start: 30),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 30),
                                                      Expanded(
                                                        child: Text(
                                                          "اسم المريض",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 85),
                                                      Expanded(
                                                        child: Text(
                                                          'السبب',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 50),
                                                      Expanded(
                                                        child: Text(
                                                          "الموعد",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 70),
                                                      Expanded(
                                                        child: Text(
                                                          "الرقم",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 40),
                                                      Expanded(
                                                        child: Text(
                                                          "قائمة الانتظار",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 60),
                                                      Expanded(
                                                        child: Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              const SizedBox(height: 10),
                                              if(screenWidth>=1450)
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 900,
                                                      height: 1,
                                                      color: dividerColor,
                                                    ),
                                                  ],
                                                ),
                                              const SizedBox(height: 10),
                                              Expanded(
                                                  child: BlocConsumer<DrAidCubit,
                                                      DrAidStates>(
                                                    listener: (context, state) {
                                                      if (state
                                                      is DrAidCheckAvailableTimesSuccessState) {
                                                        print("check dine successfully");

                                                        _showAvailableTimesDialog(
                                                          context,
                                                          state.checkAvailableTimesModel,
                                                          state.index,
                                                        );
                                                      } else if (state
                                                      is DrAidCheckAvailableTimesErrorState) {
                                                        EasyLoading.showError(
                                                            'Failed to check available times');
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      return ListView.separated(
                                                        itemBuilder: (context, index) {
                                                          final waitingListModel =
                                                              DrAidCubit.get(context)
                                                                  .getWaitingListByDateModel;

                                                          if (waitingListModel == null ||
                                                              waitingListModel.data == null ||
                                                              waitingListModel
                                                                  .data!.isEmpty) {
                                                            return const Center(
                                                              child: Text(
                                                                  'No patients available'),
                                                            );
                                                          }

                                                          final waitingListData =
                                                          waitingListModel.data![index];
                                                          final patient =
                                                              waitingListData.patient;
                                                          final fullName =
                                                              patient?.fullName ??
                                                                  waitingListData.patientName;
                                                          final phoneNumber = patient
                                                              ?.phoneNumber ??
                                                              waitingListData.patientPhone;
                                                          final appointmentDate =
                                                          waitingListData.date
                                                              .toString()
                                                              .substring(0, 10);

                                                          return Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .only(start: 30),
                                                            child: Row(
                                                              children: [
                                                                if(screenWidth>=1300)
                                                                  const SizedBox(width: 30),
                                                                Expanded(
                                                                  child: Text(
                                                                    fullName!,
                                                                    style: const TextStyle(
                                                                        fontSize: 16,
                                                                        color: fontColor),
                                                                  ),
                                                                ),
                                                                if(screenWidth>=1250)
                                                                  const SizedBox(width: 40),
                                                                if(screenWidth>=1250)
                                                                  const Expanded(
                                                                    child: Text(
                                                                      'انتظار',
                                                                      style: TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor),
                                                                    ),
                                                                  ),
                                                                const SizedBox(width: 10),
                                                                if(screenWidth>=1050)
                                                                  Expanded(
                                                                    child: Text(
                                                                      appointmentDate,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=1050)
                                                                  Expanded(
                                                                    child: Text(
                                                                      phoneNumber!,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=800)
                                                                  Container(
                                                                    width: 130,
                                                                    height: 35,
                                                                    decoration: BoxDecoration(
                                                                      color: coolGreen1,
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          30),
                                                                    ),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        DrAidCubit.get(context)
                                                                            .checkAvailableTimes(
                                                                          waitingListId:
                                                                          waitingListData
                                                                              .id!,
                                                                          index: index,
                                                                        );
                                                                      },
                                                                      child: const Center(
                                                                        child: Text(
                                                                          ' Check ',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if(screenWidth<800)
                                                                  Container(
                                                                    width: 80,
                                                                    height: 35,
                                                                    decoration: BoxDecoration(
                                                                      color: coolGreen1,
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          30),
                                                                    ),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        DrAidCubit.get(context)
                                                                            .checkAvailableTimes(
                                                                          waitingListId:
                                                                          waitingListData
                                                                              .id!,
                                                                          index: index,
                                                                        );
                                                                      },
                                                                      child: const Center(
                                                                        child: Text(
                                                                          ' Check ',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=900)
                                                                  const SizedBox(width: 75),
                                                                if(screenWidth<900)
                                                                  const SizedBox(width: 10),
                                                                Container(
                                                                  width: 70,
                                                                  height: 40,
                                                                  color: Colors.white,
                                                                  child: Center(
                                                                    child: Row(
                                                                      children: [
                                                                        if(screenWidth>=800)
                                                                          const Image(
                                                                            image: AssetImage(
                                                                                'images/edit1.png'),
                                                                            width: 25,
                                                                            height: 25,
                                                                          ),
                                                                        const SizedBox(
                                                                            width: 10),
                                                                        InkWell(
                                                                          onTap: () {},
                                                                          child: const Image(
                                                                            image: AssetImage(
                                                                                'images/delete.png'),
                                                                            width: 30,
                                                                            height: 30,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        separatorBuilder: (context, index) {
                                                          return const SizedBox(height: 10);
                                                        },
                                                        itemCount: DrAidCubit.get(context)
                                                            .getWaitingListByDateModel
                                                            ?.data
                                                            ?.length ??
                                                            0,
                                                      );
                                                    },
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              else{
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: Scaffold(
                    backgroundColor: coolWhite2,
                    appBar: const CustomAppBar(),
                    body: Row(
                      children: [
                        if(screenWidth>1530)
                          const SideBarScreen(),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.80,
                              height: 700,
                              color: coolWhite2,
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    if(screenWidth>=850)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 20, end: 130),
                                        child: Row(
                                          children: [

                                            Builder(
                                                builder: (context) {
                                                  if(modee=='light')
                                                  {
                                                    return InkWell(
                                                      child: const Image(
                                                        image: AssetImage('images/arrow.png'),
                                                        width: 30,
                                                        height: 20,
                                                      ),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }
                                                  else{
                                                    return InkWell(
                                                      child: Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }

                                                }
                                            ),
                                            if(screenWidth>=1300)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1300)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1300&&modee=='light')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 28, color: blueText),
                                              ),
                                            if(screenWidth>=1300&&modee=='dark')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 28, color: Colors.orange),
                                              ),
                                            if(screenWidth<1300&&modee=='light')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 14, color: blueText),
                                              ),
                                            if(screenWidth<1300&&modee=='dark')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 14, color: Colors.orange),
                                              ),
                                            const Spacer(),
                                            if(screenWidth>=1300)
                                              Container(
                                                width: 130,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: coolGreen1,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      navigateTo(
                                                          context,
                                                          const Directionality(
                                                              textDirection:
                                                              TextDirection.rtl,
                                                              child: AllAppointments()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  Appointments   ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1300)
                                              Container(
                                                width: 80,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: coolGreen1,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      navigateTo(
                                                          context,
                                                          const Directionality(
                                                              textDirection:
                                                              TextDirection.rtl,
                                                              child: AllAppointments()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'Appointments',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            const SizedBox(width: 20),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: coolOrange,
                                              ),
                                              onPressed: () {
                                                showDatePickerDialog(context);
                                              },
                                              child: const Text(
                                                "Appointments",
                                                style: TextStyle(color: white),
                                              ),
                                            ),
                                            if(screenWidth>=1300)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1300)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1300)
                                              Container(
                                                width: 250,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.buttonColor,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addWaitingAppointmentToPatient(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: 30),
                                                    child: Row(children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        ' Add',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth<1300)
                                              Container(
                                                width: 100,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.buttonColor,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addWaitingAppointmentToPatient(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: 30),
                                                    child: Row(children: [

                                                      Text(
                                                        ' Add',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    if(screenWidth<850&&screenWidth>=700)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 20, end: 20),
                                        child: Row(
                                          children: [
                                            Builder(
                                                builder: (context) {
                                                  if(modee=='light')
                                                  {
                                                    return InkWell(
                                                      child: const Image(
                                                        image: AssetImage('images/arrow.png'),
                                                        width: 30,
                                                        height: 20,
                                                      ),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }
                                                  else{
                                                    return InkWell(
                                                      child: Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }

                                                }
                                            ),
                                            if(screenWidth>=1300)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1300)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1300&&modee=='light')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 28, color: blueText),
                                              ),
                                            if(screenWidth>=1300&&modee=='dark')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 28, color: Colors.orange),
                                              ),
                                            if(screenWidth<1300&&modee=='light')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 14, color: blueText),
                                              ),
                                            if(screenWidth<1300&&modee=='dark')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 14, color: Colors.orange),
                                              ),
                                            const Spacer(),
                                            if(screenWidth>=1300)
                                              Container(
                                                width: 130,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: coolGreen1,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      navigateTo(
                                                          context,
                                                          const Directionality(
                                                              textDirection:
                                                              TextDirection.rtl,
                                                              child: AllAppointments()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  Appointments   ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1300)
                                              Container(
                                                width: 80,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: coolGreen1,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      navigateTo(
                                                          context,
                                                          const Directionality(
                                                              textDirection:
                                                              TextDirection.rtl,
                                                              child: AllAppointments()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'Appointments',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            const SizedBox(width: 20),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: coolOrange,
                                              ),
                                              onPressed: () {
                                                showDatePickerDialog(context);
                                              },
                                              child: const Text(
                                                "Appointments",
                                                style: TextStyle(color: white),
                                              ),
                                            ),
                                            if(screenWidth>=1300)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1300)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1300)
                                              Container(
                                                width: 250,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.buttonColor,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addWaitingAppointmentToPatient(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: 30),
                                                    child: Row(children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        'Add',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth<1300)
                                              Container(
                                                width: 100,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.buttonColor,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addWaitingAppointmentToPatient(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: 30),
                                                    child: Row(children: [

                                                      Text(
                                                        'Add',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    if(screenWidth<700)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 5, end: 5),
                                        child: Row(
                                          children: [

                                            if(screenWidth>=1300)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1300)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1300&&modee=='light')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 28, color: blueText),
                                              ),
                                            if(screenWidth>=1300&&modee=='dark')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 28, color: Colors.orange),
                                              ),
                                            if(screenWidth<1300&&modee=='light')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 14, color: blueText),
                                              ),
                                            if(screenWidth<1300&&modee=='dark')
                                              const Text(
                                                'Waiting',
                                                style: TextStyle(
                                                    fontSize: 14, color: Colors.orange),
                                              ),
                                            const Spacer(),
                                            if(screenWidth>=1300)
                                              Container(
                                                width: 130,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: coolGreen1,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      navigateTo(
                                                          context,
                                                          const Directionality(
                                                              textDirection:
                                                              TextDirection.rtl,
                                                              child: AllAppointments()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  Waiting   ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1300)
                                              Container(
                                                width: 80,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: coolGreen1,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      navigateTo(
                                                          context,
                                                          const Directionality(
                                                              textDirection:
                                                              TextDirection.rtl,
                                                              child: AllAppointments()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'Appointments',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            const SizedBox(width: 20),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: coolOrange,
                                              ),
                                              onPressed: () {
                                                showDatePickerDialog(context);
                                              },
                                              child: const Text(
                                                "Appointments",
                                                style: TextStyle(color: white),
                                              ),
                                            ),
                                            if(screenWidth>=1300)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1300)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1300)
                                              Container(
                                                width: 250,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.buttonColor,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addWaitingAppointmentToPatient(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: 30),
                                                    child: Row(children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        ' Add',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth<1300)
                                              Container(
                                                width: 100,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.buttonColor,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addWaitingAppointmentToPatient(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(
                                                        start: 30),
                                                    child: Row(children: [

                                                      Text(
                                                        'Add',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    const SizedBox(height: 60),
                                    Padding(
                                      padding:
                                      const EdgeInsetsDirectional.only(end: 175.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.70,
                                        height: 450,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 18),
                                            const SizedBox(height: 10),
                                            if(screenWidth>=1450)
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 900,
                                                    height: 1,
                                                    color: dividerColor,
                                                  ),
                                                ],
                                              ),
                                            const SizedBox(height: 10),
                                            Expanded(
                                                child: BlocConsumer<DrAidCubit,
                                                    DrAidStates>(
                                                  listener: (context, state) {
                                                    if (state
                                                    is DrAidCheckAvailableTimesSuccessState) {
                                                      print("check done successfully");

                                                      _showAvailableTimesDialog(
                                                        context,
                                                        state.checkAvailableTimesModel,
                                                        state.index,
                                                      );
                                                    } else if (state
                                                    is DrAidCheckAvailableTimesErrorState) {
                                                      EasyLoading.showError(
                                                          'Failed to check available times');
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    return ListView.separated(
                                                      itemBuilder: (context, index) {
                                                        final waitingListModel =
                                                            DrAidCubit.get(context)
                                                                .getWaitingListByDateModel;

                                                        if (waitingListModel == null ||
                                                            waitingListModel.data == null ||
                                                            waitingListModel
                                                                .data!.isEmpty) {
                                                          return const Center(
                                                            child: Text(
                                                                'No patients available'),
                                                          );
                                                        }

                                                        final waitingListData =
                                                        waitingListModel.data![index];
                                                        final patient =
                                                            waitingListData.patient;
                                                        final fullName =
                                                            patient?.fullName ??
                                                                waitingListData.patientName;
                                                        final phoneNumber = patient
                                                            ?.phoneNumber ??
                                                            waitingListData.patientPhone;
                                                        final appointmentDate =
                                                        waitingListData.date
                                                            .toString()
                                                            .substring(0, 10);

                                                        return Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional
                                                              .only(start: 30),
                                                          child: Row(
                                                            children: [
                                                              if(screenWidth>=1300)
                                                                const SizedBox(width: 30),
                                                              Expanded(
                                                                child: Text(
                                                                  fullName!,
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      color: fontColor),
                                                                ),
                                                              ),
                                                              if(screenWidth>=1250)
                                                                const SizedBox(width: 40),
                                                              if(screenWidth>=1250)
                                                                const Expanded(
                                                                  child: Text(
                                                                    'Waiting',
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        color: fontColor),
                                                                  ),
                                                                ),
                                                              const SizedBox(width: 10),
                                                              if(screenWidth>=1050)
                                                                Expanded(
                                                                  child: Text(
                                                                    appointmentDate,
                                                                    style: const TextStyle(
                                                                        fontSize: 16,
                                                                        color: fontColor),
                                                                  ),
                                                                ),
                                                              if(screenWidth>=1050)
                                                                Expanded(
                                                                  child: Text(
                                                                    phoneNumber!,
                                                                    style: const TextStyle(
                                                                        fontSize: 16,
                                                                        color: fontColor),
                                                                  ),
                                                                ),
                                                              if(screenWidth>=800)
                                                                Container(
                                                                  width: 130,
                                                                  height: 35,
                                                                  decoration: BoxDecoration(
                                                                    color: coolGreen1,
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        30),
                                                                  ),
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      DrAidCubit.get(context)
                                                                          .checkAvailableTimes(
                                                                        waitingListId:
                                                                        waitingListData
                                                                            .id!,
                                                                        index: index,
                                                                      );
                                                                    },
                                                                    child: const Center(
                                                                      child: Text(
                                                                        ' Check ',
                                                                        style: TextStyle(
                                                                            fontSize: 12,
                                                                            color: white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if(screenWidth<800)
                                                                Container(
                                                                  width: 80,
                                                                  height: 35,
                                                                  decoration: BoxDecoration(
                                                                    color: coolGreen1,
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        30),
                                                                  ),
                                                                  child: InkWell(
                                                                    onTap: () {
                                                                      DrAidCubit.get(context)
                                                                          .checkAvailableTimes(
                                                                        waitingListId:
                                                                        waitingListData
                                                                            .id!,
                                                                        index: index,
                                                                      );
                                                                    },
                                                                    child: const Center(
                                                                      child: Text(
                                                                        ' Check ',
                                                                        style: TextStyle(
                                                                            fontSize: 12,
                                                                            color: white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if(screenWidth>=900)
                                                                const SizedBox(width: 75),
                                                              if(screenWidth<900)
                                                                const SizedBox(width: 10),
                                                              Container(
                                                                width: 70,
                                                                height: 40,
                                                                color: Colors.white,
                                                                child: Center(
                                                                  child: Row(
                                                                    children: [
                                                                      if(screenWidth>=800)
                                                                        const Image(
                                                                          image: AssetImage(
                                                                              'images/edit1.png'),
                                                                          width: 25,
                                                                          height: 25,
                                                                        ),
                                                                      const SizedBox(
                                                                          width: 10),
                                                                      InkWell(
                                                                        onTap: () {},
                                                                        child: const Image(
                                                                          image: AssetImage(
                                                                              'images/delete.png'),
                                                                          width: 30,
                                                                          height: 30,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder: (context, index) {
                                                        return const SizedBox(height: 10);
                                                      },
                                                      itemCount: DrAidCubit.get(context)
                                                          .getWaitingListByDateModel
                                                          ?.data
                                                          ?.length ??
                                                          0,
                                                    );
                                                  },
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

            }
          );
        } else if (DrAidCubit.get(context).getAppointmentsModel?.data.length !=
                null ||
            state is DrAidGetAppointmentsSuccessState) {
          return Builder(
              builder: (context) {
                if(languagee=='arabic')
                {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      backgroundColor: coolWhite2,
                      appBar: const CustomAppBar(),
                      body: Row(
                        children: [
                          if(screenWidth>1530)
                            const SideBarScreen(),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.80,
                                height: 700,
                                color: coolWhite2,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    children: [
                                      if(screenWidth>=850)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 20, end: 130),
                                          child: Row(
                                            children: [

                                              Builder(
                                                  builder: (context) {
                                                    if(modee=='light')
                                                    {
                                                      return InkWell(
                                                        child: const Image(
                                                          image: AssetImage('images/arrow.png'),
                                                          width: 30,
                                                          height: 20,
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }
                                                    else{
                                                      return InkWell(
                                                        child: Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }

                                                  }
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300&&modee=='light')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 130,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة المواعيد   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'مواعيد',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد انتظار يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          ' إضافة موعد للانتظار',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          ' إضافة',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      if(screenWidth<850&&screenWidth>=700)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 20, end: 20),
                                          child: Row(
                                            children: [
                                              Builder(
                                                  builder: (context) {
                                                    if(modee=='light')
                                                    {
                                                      return InkWell(
                                                        child: const Image(
                                                          image: AssetImage('images/arrow.png'),
                                                          width: 30,
                                                          height: 20,
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }
                                                    else{
                                                      return InkWell(
                                                        child: Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }

                                                  }
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300&&modee=='light')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 130,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة المواعيد   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'مواعيد',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد انتظار يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          ' إضافة موعد للانتظار',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          ' إضافة',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      if(screenWidth<700)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 5, end: 5),
                                          child: Row(
                                            children: [

                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300&&modee=='light')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                const Text(
                                                  'قائمة الانتظار',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                const Text(
                                                  'انتظار',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 130,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة المواعيد   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'مواعيد',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد انتظار يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          ' إضافة موعد للانتظار',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          ' إضافة',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 60),
                                      Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(end: 175.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.70,
                                          height: 450,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 18),
                                              if(screenWidth>=1400)
                                                const Padding(
                                                  padding:
                                                  EdgeInsetsDirectional.only(start: 30),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 30),
                                                      Expanded(
                                                        child: Text(
                                                          "اسم المريض",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 85),
                                                      Expanded(
                                                        child: Text(
                                                          'السبب',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 50),
                                                      Expanded(
                                                        child: Text(
                                                          "الموعد",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 70),
                                                      Expanded(
                                                        child: Text(
                                                          "الرقم",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 40),
                                                      Expanded(
                                                        child: Text(
                                                          "قائمة الانتظار",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 60),
                                                      Expanded(
                                                        child: Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              const SizedBox(height: 10),
                                              if(screenWidth>=1450)
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 900,
                                                      height: 1,
                                                      color: dividerColor,
                                                    ),
                                                  ],
                                                ),
                                              const SizedBox(height: 10),
                                              Expanded(
                                                  child: BlocConsumer<DrAidCubit,
                                                      DrAidStates>(
                                                    listener: (context, state) {
                                                      if (state
                                                      is DrAidCheckAvailableTimesSuccessState) {
                                                        print("check dine successfully");

                                                        _showAvailableTimesDialog(
                                                          context,
                                                          state.checkAvailableTimesModel,
                                                          state.index,
                                                        );
                                                      } else if (state
                                                      is DrAidCheckAvailableTimesErrorState) {
                                                        EasyLoading.showError(
                                                            'Failed to check available times');
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      return ListView.separated(
                                                        itemBuilder: (context, index) {
                                                          final waitingListModel =
                                                              DrAidCubit.get(context)
                                                                  .getWaitingListByDateModel;

                                                          if (waitingListModel == null ||
                                                              waitingListModel.data == null ||
                                                              waitingListModel
                                                                  .data!.isEmpty) {
                                                            return const Center(
                                                              child: Text(
                                                                  'No patients available'),
                                                            );
                                                          }

                                                          final waitingListData =
                                                          waitingListModel.data![index];
                                                          final patient =
                                                              waitingListData.patient;
                                                          final fullName =
                                                              patient?.fullName ??
                                                                  waitingListData.patientName;
                                                          final phoneNumber = patient
                                                              ?.phoneNumber ??
                                                              waitingListData.patientPhone;
                                                          final appointmentDate =
                                                          waitingListData.date
                                                              .toString()
                                                              .substring(0, 10);

                                                          return Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .only(start: 30),
                                                            child: Row(
                                                              children: [
                                                                if(screenWidth>=1300)
                                                                  const SizedBox(width: 30),
                                                                Expanded(
                                                                  child: Text(
                                                                    fullName!,
                                                                    style: const TextStyle(
                                                                        fontSize: 16,
                                                                        color: fontColor),
                                                                  ),
                                                                ),
                                                                if(screenWidth>=1250)
                                                                  const SizedBox(width: 40),
                                                                if(screenWidth>=1250)
                                                                  const Expanded(
                                                                    child: Text(
                                                                      'انتظار',
                                                                      style: TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor),
                                                                    ),
                                                                  ),
                                                                const SizedBox(width: 10),
                                                                if(screenWidth>=1050)
                                                                  Expanded(
                                                                    child: Text(
                                                                      appointmentDate,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=1050)
                                                                  Expanded(
                                                                    child: Text(
                                                                      phoneNumber!,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=800)
                                                                  Container(
                                                                    width: 130,
                                                                    height: 35,
                                                                    decoration: BoxDecoration(
                                                                      color: coolGreen1,
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          30),
                                                                    ),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        DrAidCubit.get(context)
                                                                            .checkAvailableTimes(
                                                                          waitingListId:
                                                                          waitingListData
                                                                              .id!,
                                                                          index: index,
                                                                        );
                                                                      },
                                                                      child: const Center(
                                                                        child: Text(
                                                                          ' Check ',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if(screenWidth<800)
                                                                  Container(
                                                                    width: 80,
                                                                    height: 35,
                                                                    decoration: BoxDecoration(
                                                                      color: coolGreen1,
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          30),
                                                                    ),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        DrAidCubit.get(context)
                                                                            .checkAvailableTimes(
                                                                          waitingListId:
                                                                          waitingListData
                                                                              .id!,
                                                                          index: index,
                                                                        );
                                                                      },
                                                                      child: const Center(
                                                                        child: Text(
                                                                          ' Check ',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=900)
                                                                  const SizedBox(width: 75),
                                                                if(screenWidth<900)
                                                                  const SizedBox(width: 10),
                                                                Container(
                                                                  width: 70,
                                                                  height: 40,
                                                                  color: Colors.white,
                                                                  child: Center(
                                                                    child: Row(
                                                                      children: [
                                                                        if(screenWidth>=800)
                                                                          const Image(
                                                                            image: AssetImage(
                                                                                'images/edit1.png'),
                                                                            width: 25,
                                                                            height: 25,
                                                                          ),
                                                                        const SizedBox(
                                                                            width: 10),
                                                                        InkWell(
                                                                          onTap: () {},
                                                                          child: const Image(
                                                                            image: AssetImage(
                                                                                'images/delete.png'),
                                                                            width: 30,
                                                                            height: 30,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        separatorBuilder: (context, index) {
                                                          return const SizedBox(height: 10);
                                                        },
                                                        itemCount: DrAidCubit.get(context)
                                                            .getWaitingListByDateModel
                                                            ?.data
                                                            ?.length ??
                                                            0,
                                                      );
                                                    },
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else{
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: Scaffold(
                      backgroundColor: coolWhite2,
                      appBar: const CustomAppBar(),
                      body: Row(
                        children: [
                          if(screenWidth>1530)
                            const SideBarScreen(),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.80,
                                height: 700,
                                color: coolWhite2,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    children: [
                                      if(screenWidth>=850)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 20, end: 130),
                                          child: Row(
                                            children: [

                                              Builder(
                                                  builder: (context) {
                                                    if(modee=='light')
                                                    {
                                                      return InkWell(
                                                        child: const Image(
                                                          image: AssetImage('images/arrow.png'),
                                                          width: 30,
                                                          height: 20,
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }
                                                    else{
                                                      return InkWell(
                                                        child: Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }

                                                  }
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300&&modee=='light')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 130,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  Appointments   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'Appointments',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "Appointments",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          ' Add',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          ' Add',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      if(screenWidth<850&&screenWidth>=700)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 20, end: 20),
                                          child: Row(
                                            children: [
                                              Builder(
                                                  builder: (context) {
                                                    if(modee=='light')
                                                    {
                                                      return InkWell(
                                                        child: const Image(
                                                          image: AssetImage('images/arrow.png'),
                                                          width: 30,
                                                          height: 20,
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }
                                                    else{
                                                      return InkWell(
                                                        child: Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    }

                                                  }
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300&&modee=='light')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 130,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  Appointments   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'Appointments',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "Appointments",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          'Add',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          'Add',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      if(screenWidth<700)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 5, end: 5),
                                          child: Row(
                                            children: [

                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300&&modee=='light')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                const Text(
                                                  'Waiting',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 130,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  Waiting   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: coolGreen1,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                            context,
                                                            const Directionality(
                                                                textDirection:
                                                                TextDirection.rtl,
                                                                child: AllAppointments()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'Appointments',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "Appointments",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1300)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1300)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1300)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          ' Add',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.buttonColor,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addWaitingAppointmentToPatient(context);
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          'Add',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 60),
                                      Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(end: 175.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.70,
                                          height: 450,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 18),
                                              const SizedBox(height: 10),
                                              if(screenWidth>=1450)
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 900,
                                                      height: 1,
                                                      color: dividerColor,
                                                    ),
                                                  ],
                                                ),
                                              const SizedBox(height: 10),
                                              Expanded(
                                                  child: BlocConsumer<DrAidCubit,
                                                      DrAidStates>(
                                                    listener: (context, state) {
                                                      if (state
                                                      is DrAidCheckAvailableTimesSuccessState) {
                                                        print("check done successfully");

                                                        _showAvailableTimesDialog(
                                                          context,
                                                          state.checkAvailableTimesModel,
                                                          state.index,
                                                        );
                                                      } else if (state
                                                      is DrAidCheckAvailableTimesErrorState) {
                                                        EasyLoading.showError(
                                                            'Failed to check available times');
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      return ListView.separated(
                                                        itemBuilder: (context, index) {
                                                          final waitingListModel =
                                                              DrAidCubit.get(context)
                                                                  .getWaitingListByDateModel;

                                                          if (waitingListModel == null ||
                                                              waitingListModel.data == null ||
                                                              waitingListModel
                                                                  .data!.isEmpty) {
                                                            return const Center(
                                                              child: Text(
                                                                  'No patients available'),
                                                            );
                                                          }

                                                          final waitingListData =
                                                          waitingListModel.data![index];
                                                          final patient =
                                                              waitingListData.patient;
                                                          final fullName =
                                                              patient?.fullName ??
                                                                  waitingListData.patientName;
                                                          final phoneNumber = patient
                                                              ?.phoneNumber ??
                                                              waitingListData.patientPhone;
                                                          final appointmentDate =
                                                          waitingListData.date
                                                              .toString()
                                                              .substring(0, 10);

                                                          return Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .only(start: 30),
                                                            child: Row(
                                                              children: [
                                                                if(screenWidth>=1300)
                                                                  const SizedBox(width: 30),
                                                                Expanded(
                                                                  child: Text(
                                                                    fullName!,
                                                                    style: const TextStyle(
                                                                        fontSize: 16,
                                                                        color: fontColor),
                                                                  ),
                                                                ),
                                                                if(screenWidth>=1250)
                                                                  const SizedBox(width: 40),
                                                                if(screenWidth>=1250)
                                                                  const Expanded(
                                                                    child: Text(
                                                                      'Waiting',
                                                                      style: TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor),
                                                                    ),
                                                                  ),
                                                                const SizedBox(width: 10),
                                                                if(screenWidth>=1050)
                                                                  Expanded(
                                                                    child: Text(
                                                                      appointmentDate,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=1050)
                                                                  Expanded(
                                                                    child: Text(
                                                                      phoneNumber!,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=800)
                                                                  Container(
                                                                    width: 130,
                                                                    height: 35,
                                                                    decoration: BoxDecoration(
                                                                      color: coolGreen1,
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          30),
                                                                    ),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        DrAidCubit.get(context)
                                                                            .checkAvailableTimes(
                                                                          waitingListId:
                                                                          waitingListData
                                                                              .id!,
                                                                          index: index,
                                                                        );
                                                                      },
                                                                      child: const Center(
                                                                        child: Text(
                                                                          ' Check ',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if(screenWidth<800)
                                                                  Container(
                                                                    width: 80,
                                                                    height: 35,
                                                                    decoration: BoxDecoration(
                                                                      color: coolGreen1,
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          30),
                                                                    ),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        DrAidCubit.get(context)
                                                                            .checkAvailableTimes(
                                                                          waitingListId:
                                                                          waitingListData
                                                                              .id!,
                                                                          index: index,
                                                                        );
                                                                      },
                                                                      child: const Center(
                                                                        child: Text(
                                                                          ' Check ',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=900)
                                                                  const SizedBox(width: 75),
                                                                if(screenWidth<900)
                                                                  const SizedBox(width: 10),
                                                                Container(
                                                                  width: 70,
                                                                  height: 40,
                                                                  color: Colors.white,
                                                                  child: Center(
                                                                    child: Row(
                                                                      children: [
                                                                        if(screenWidth>=800)
                                                                          const Image(
                                                                            image: AssetImage(
                                                                                'images/edit1.png'),
                                                                            width: 25,
                                                                            height: 25,
                                                                          ),
                                                                        const SizedBox(
                                                                            width: 10),
                                                                        InkWell(
                                                                          onTap: () {},
                                                                          child: const Image(
                                                                            image: AssetImage(
                                                                                'images/delete.png'),
                                                                            width: 30,
                                                                            height: 30,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        separatorBuilder: (context, index) {
                                                          return const SizedBox(height: 10);
                                                        },
                                                        itemCount: DrAidCubit.get(context)
                                                            .getWaitingListByDateModel
                                                            ?.data
                                                            ?.length ??
                                                            0,
                                                      );
                                                    },
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

              }
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
