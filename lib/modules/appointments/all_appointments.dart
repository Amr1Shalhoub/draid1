// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/modules/sidebar/side_bar_screen.dart';
import 'package:draid/modules/waitinglist/all_waitinglist.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/network/local/cache_helper.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AllAppointments extends StatefulWidget {
  const AllAppointments({super.key});

  @override
  State<AllAppointments> createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {
  @override
  void initState() {
    super.initState();
    final cubit = DrAidCubit.get(context);
    cubit.getAllPatientsData();
    cubit.getAppointmentsByDate(
        date: DateTime.now().toIso8601String().split('T').first);
  }

  DateTime? fromDate;
  DateTime? toDate;
  String? fromDateString;
  String? toDateString;
  String patientId = '0';
  String? _selectedTimeString;
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay _selectedTimeEnd = TimeOfDay.now();
  String? _selectedTimeEndString;
  TextEditingController complaintController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController patientPhoneController = TextEditingController();

  void _handleTimeChanged(TimeOfDay time) {
    setState(() {
      _selectedTime = time;
    });
  }

  void _handleTimeEndChanged(TimeOfDay time) {
    setState(() {
      _selectedTimeEnd = time;
    });
  }

  void _onFromDateChanged(DateTime date) {
    setState(() {
      fromDate = date;
    });
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }


  void addAppointmentToPatient(BuildContext context) {
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
                        'إضافة موعد ',
                        style: TextStyle(
                          fontSize: 24,
                          color: simpleDialogTitleColor,
                        ),
                      ),
                    ),
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 500,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 50),
                          child: Column(
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
                                  Row(
                                    children: [
                                      MyDatePicker(
                                        title: 'التاريخ',
                                        initialDate: DateTime.now(),
                                        onDateChanged: _onFromDateChanged,
                                      ),
                                      const SizedBox(width: 20),
                                      const SizedBox(
                                        height: 40,
                                        child: VerticalDivider(
                                          width: 10,
                                          thickness: 1,
                                          indent: 10,
                                          endIndent: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      MyTimePicker(
                                        title: 'من وقت',
                                        initialTime: _selectedTime,
                                        onTimeChanged: _handleTimeChanged,
                                      ),
                                      const SizedBox(width: 20),
                                      MyTimePicker(
                                        title: 'إلى وقت',
                                        initialTime: _selectedTime,
                                        onTimeChanged: _handleTimeEndChanged,
                                      ),
                                      const SizedBox(width: 20),
                                    ],
                                  ),
                                  const SizedBox(height: 50),
                                  _buildTextField(
                                    context,
                                    controller: complaintController,
                                    label: 'سبب الموعد',
                                    validation: _validateComplaint,
                                  ),
                                  const SizedBox(height: 20),
                                  _buildTextField(
                                    context,
                                    controller: patientNameController,
                                    label: 'اسم المرض',
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
                                      _selectedTimeString =
                                          _formatTimeOfDay(_selectedTime);
                                      _selectedTimeEndString =
                                          _formatTimeOfDay(_selectedTimeEnd);

                                      await DrAidCubit.get(context)
                                          .createAppointment(
                                        patientName: patientNameController.text,
                                        patientPhone: patientPhoneController.text,
                                        date: fromDateString!,
                                        startTime: _selectedTimeString!,
                                        endTime: _selectedTimeEndString!,
                                        complaint: complaintController.text,
                                      );
                                      Navigator.pop(context);
                                      if (state
                                      is DrAidCreateAppointmentSuccessState &&
                                          DrAidCubit.get(context)
                                              .getAppointmentsModel
                                              ?.data
                                              .length !=
                                              null) {
                                        // Further logic if needed
                                      }
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
                      'Add ',
                      style: TextStyle(
                        fontSize: 24,
                        color: simpleDialogTitleColor,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 50),
                        child: Column(
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
                                Row(
                                  children: [
                                    MyDatePicker(
                                      title: 'Date',
                                      initialDate: DateTime.now(),
                                      onDateChanged: _onFromDateChanged,
                                    ),
                                    const SizedBox(width: 20),
                                    const SizedBox(
                                      height: 40,
                                      child: VerticalDivider(
                                        width: 10,
                                        thickness: 1,
                                        indent: 10,
                                        endIndent: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    MyTimePicker(
                                      title: 'From',
                                      initialTime: _selectedTime,
                                      onTimeChanged: _handleTimeChanged,
                                    ),
                                    const SizedBox(width: 20),
                                    MyTimePicker(
                                      title: 'To',
                                      initialTime: _selectedTime,
                                      onTimeChanged: _handleTimeEndChanged,
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                _buildTextField(
                                  context,
                                  controller: complaintController,
                                  label: 'Reason',
                                  validation: _validateComplaint,
                                ),
                                const SizedBox(height: 20),
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
                                    _selectedTimeString =
                                        _formatTimeOfDay(_selectedTime);
                                    _selectedTimeEndString =
                                        _formatTimeOfDay(_selectedTimeEnd);

                                    await DrAidCubit.get(context)
                                        .createAppointment(
                                      patientName: patientNameController.text,
                                      patientPhone: patientPhoneController.text,
                                      date: fromDateString!,
                                      startTime: _selectedTimeString!,
                                      endTime: _selectedTimeEndString!,
                                      complaint: complaintController.text,
                                    );
                                    Navigator.pop(context);
                                    if (state
                                    is DrAidCreateAppointmentSuccessState &&
                                        DrAidCubit.get(context)
                                            .getAppointmentsModel
                                            ?.data
                                            .length !=
                                            null) {
                                      // Further logic if needed
                                    }
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
              ); return Directionality(
                textDirection: TextDirection.rtl,
                child: SimpleDialog(
                  title: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 30),
                    child: Text(
                      'إضافة موعد ',
                      style: TextStyle(
                        fontSize: 24,
                        color: simpleDialogTitleColor,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 50),
                        child: Column(
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
                                Row(
                                  children: [
                                    MyDatePicker(
                                      title: 'التاريخ',
                                      initialDate: DateTime.now(),
                                      onDateChanged: _onFromDateChanged,
                                    ),
                                    const SizedBox(width: 20),
                                    const SizedBox(
                                      height: 40,
                                      child: VerticalDivider(
                                        width: 10,
                                        thickness: 1,
                                        indent: 10,
                                        endIndent: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    MyTimePicker(
                                      title: 'من وقت',
                                      initialTime: _selectedTime,
                                      onTimeChanged: _handleTimeChanged,
                                    ),
                                    const SizedBox(width: 20),
                                    MyTimePicker(
                                      title: 'إلى وقت',
                                      initialTime: _selectedTime,
                                      onTimeChanged: _handleTimeEndChanged,
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                _buildTextField(
                                  context,
                                  controller: complaintController,
                                  label: 'سبب الموعد',
                                  validation: _validateComplaint,
                                ),
                                const SizedBox(height: 20),
                                _buildTextField(
                                  context,
                                  controller: patientNameController,
                                  label: 'اسم المرض',
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
                                    _selectedTimeString =
                                        _formatTimeOfDay(_selectedTime);
                                    _selectedTimeEndString =
                                        _formatTimeOfDay(_selectedTimeEnd);

                                    await DrAidCubit.get(context)
                                        .createAppointment(
                                      patientName: patientNameController.text,
                                      patientPhone: patientPhoneController.text,
                                      date: fromDateString!,
                                      startTime: _selectedTimeString!,
                                      endTime: _selectedTimeEndString!,
                                      complaint: complaintController.text,
                                    );
                                    Navigator.pop(context);
                                    if (state
                                    is DrAidCreateAppointmentSuccessState &&
                                        DrAidCubit.get(context)
                                            .getAppointmentsModel
                                            ?.data
                                            .length !=
                                            null) {
                                      // Further logic if needed
                                    }
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

    if (_selectedTime == null || _selectedTimeEnd == null) {
      EasyLoading.showError('وقت البدء ووقت الانتهاء مطلوبان');
      return false;
    }

    if (_formatTimeOfDay(_selectedTime)
            .compareTo(_formatTimeOfDay(_selectedTimeEnd)) >=
        0) {
      EasyLoading.showError('وقت الانتهاء يجب أن يكون بعد وقت البدء');
      return false;
    }

    const startWorkingHour = "09:00:00";
    const endWorkingHour = "17:00:00";

    if (_formatTimeOfDay(_selectedTime).compareTo(startWorkingHour) < 0 ||
        _formatTimeOfDay(_selectedTimeEnd).compareTo(endWorkingHour) > 0) {
      EasyLoading.showError(
          'مواعيد العمل في العيادة هي من 09:00:00 إلى 17:00:00');
      return false;
    }

    if (_validateComplaint(complaintController.text) != null ||
        _validatePatientName(patientNameController.text) != null ||
        _validatePatientPhone(patientPhoneController.text) != null) {
      return false;
    }

    return true;
  }

  String? _validateComplaint(String value) {
    if (value.isEmpty) {
      EasyLoading.showError('رجاءً ادخل سبب الموعد');
      return 'رجاءً ادخل سبب الموعد';
    }
    return null;
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

  void showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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

                        print('From: $fromDateString');
                        // Add your logic to use the date strings
                      } else {
                        print('Please select date.');
                      }
                      if (fromDateString != null) {
                        CacheHelper.getData(key: 'id');
                        fromDateString = fromDateString?.substring(0, 10);
                        print(fromDateString);
                        DrAidCubit.get(context)
                            .getAppointmentsByDate(date: fromDateString!);
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
              title: const Text('Appintments'),
              content: SizedBox(
                height: 120,
                child: MyDatePicker(
                  title: 'Choose day',
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

                      print('From: $fromDateString');
                      // Add your logic to use the date strings
                    } else {
                      print('Please select date.');
                    }
                    if (fromDateString != null) {
                      CacheHelper.getData(key: 'id');
                      fromDateString = fromDateString?.substring(0, 10);
                      print(fromDateString);
                      DrAidCubit.get(context)
                          .getAppointmentsByDate(date: fromDateString!);
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

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    print(screenWidth);
    return BlocConsumer<DrAidCubit, DrAidStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DrAidGetAppointmentsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DrAidGetAppointmentsByDateSuccessState &&
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
                                      if(screenWidth>=800)
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
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200&&modee=='light')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1200&&modee=='dark')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1200&&modee=='light')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1200&&modee=='dark')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة الانتظار   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'الانتظار',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

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
                                                          'إضافة موعد جديد',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1200)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          'إضافة',
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
                                      if(screenWidth<800&&screenWidth>=680)
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
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200&&modee=='light')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1200&&modee=='dark')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1200&&modee=='light')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1200&&modee=='dark')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة الانتظار   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'الانتظار',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

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
                                                          'إضافة موعد جديد',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1200)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          'إضافة',
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
                                      if(screenWidth<680)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 5, end: 5),
                                          child: Row(
                                            children: [

                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200&&modee=='light')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1200&&modee=='dark')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1200&&modee=='light')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1200&&modee=='dark')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة الانتظار   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'الانتظار',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

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
                                                          'إضافة موعد جديد',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1200)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          'إضافة',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              // const SizedBox(width: 20),
                                              // const Text(
                                              //   'المواعيد',
                                              //   style: TextStyle(
                                              //       fontSize: 28, color: blueText),
                                              // ),
                                              // const Spacer(),
                                              // Container(
                                              //   width: 130,
                                              //   height: 35,
                                              //   decoration: BoxDecoration(
                                              //     color: coolGreen1,
                                              //     borderRadius: BorderRadius.circular(30),
                                              //   ),
                                              //   child: InkWell(
                                              //       onTap: () {
                                              //         navigateTo(
                                              //             context,
                                              //             const Directionality(
                                              //                 textDirection:
                                              //                     TextDirection.rtl,
                                              //                 child: AllWaitingList()));
                                              //       },
                                              //       child: const Center(
                                              //         child: Text(
                                              //           '  قائمة الانتظار   ',
                                              //           style: TextStyle(
                                              //             fontSize: 12,
                                              //             color: white,
                                              //           ),
                                              //         ),
                                              //       )),
                                              // ),
                                              // const SizedBox(width: 20),
                                              // ElevatedButton(
                                              //   style: ElevatedButton.styleFrom(
                                              //     backgroundColor: coolOrange,
                                              //   ),
                                              //   onPressed: () {
                                              //     showDatePickerDialog(context);
                                              //   },
                                              //   child: const Text(
                                              //     "مواعيد يوم آخر",
                                              //     style: TextStyle(color: white),
                                              //   ),
                                              // ),
                                              // const SizedBox(width: 20),
                                              // Container(
                                              //   width: 250,
                                              //   height: 45,
                                              //   decoration: BoxDecoration(
                                              //     color: ColorManager.buttonColor,
                                              //     borderRadius: BorderRadius.circular(30),
                                              //   ),
                                              //   child: InkWell(
                                              //     onTap: () {
                                              //       addAppointmentToPatient(context);
                                              //     },
                                              //     child: const Padding(
                                              //       padding: EdgeInsetsDirectional.only(
                                              //           start: 30),
                                              //       child: Row(children: [
                                              //         Icon(
                                              //           Icons.add,
                                              //           size: 30,
                                              //           color: Colors.white,
                                              //         ),
                                              //         SizedBox(
                                              //           width: 20,
                                              //         ),
                                              //         Text(
                                              //           'إضافة موعد جديد',
                                              //           style: TextStyle(
                                              //             fontSize: 18,
                                              //             color: Colors.white,
                                              //           ),
                                              //         )
                                              //       ]),
                                              //     ),
                                              //   ),
                                              // ),
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
                                              const SizedBox(
                                                height: 18,
                                              ),
                                              const Padding(
                                                padding:
                                                EdgeInsetsDirectional.only(start: 30),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 18),
                                              if(screenWidth>=1200)
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
                                                      SizedBox(width: 120),
                                                      Expanded(
                                                        child: Text(
                                                          'السبب',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 100),
                                                      Expanded(
                                                        child: Text(
                                                          "الموعد",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 100),
                                                      Expanded(
                                                        child: Text(
                                                          "الرقم",
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
                                                child: ListView.separated(
                                                  itemBuilder: (context, index) {
                                                    final appointmentModel =
                                                        DrAidCubit.get(context)
                                                            .getAppointmentsByDateModel;

                                                    if (appointmentModel == null ||
                                                        appointmentModel.data == null ||
                                                        appointmentModel.data!.isEmpty) {
                                                      return const Center(
                                                        child: Text(
                                                            'No appointments available'),
                                                      );
                                                    }

                                                    final appointmentData =
                                                    appointmentModel.data![index];

                                                    // Check if patient or any other property is null
                                                    final patient =
                                                        appointmentData.patient;
                                                    final fullName = patient?.fullName ??
                                                        appointmentData.patientName;
                                                    final phoneNumber =
                                                        patient?.phoneNumber ??
                                                            appointmentData.patientPhone;
                                                    final complaint =
                                                        appointmentData.complaint ??
                                                            'No complaint';
                                                    final startTime =
                                                        appointmentData.startTime ??
                                                            'Unknown time';

                                                    return Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .only(start: 30),
                                                      child: Row(
                                                        children: [
                                                          const SizedBox(width: 30),
                                                          Expanded(
                                                            child: Text(
                                                              fullName!,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: fontColor),
                                                            ),
                                                          ),
                                                          if(screenWidth>=1200)
                                                            const SizedBox(width: 40),
                                                          if(screenWidth<1200)
                                                            const SizedBox(width: 10),
                                                          if(screenWidth>=1200)
                                                            Expanded(
                                                              child: Text(
                                                                complaint,
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    color: fontColor),
                                                              ),
                                                            ),
                                                          if(screenWidth>=1200)
                                                            const SizedBox(width: 10),
                                                          if(screenWidth>=1000)
                                                            Expanded(
                                                              child: Text(
                                                                startTime,
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    color: fontColor),
                                                              ),
                                                            ),
                                                          if(screenWidth>=800)
                                                            Expanded(
                                                              child: Text(
                                                                phoneNumber!,
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    color: fontColor),
                                                              ),
                                                            ),
                                                          if(screenWidth>=900)
                                                            const SizedBox(width: 75),
                                                          Container(
                                                            width: 70,
                                                            height: 40,
                                                            color: Colors.white,
                                                            child: Center(
                                                              child: Row(
                                                                children: [
                                                                  if(screenWidth>=900)
                                                                    const Image(
                                                                      image: AssetImage(
                                                                          'images/edit1.png'),
                                                                      width: 25,
                                                                      height: 25,
                                                                    ),
                                                                  const SizedBox(
                                                                      width: 10),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context: context,
                                                                        builder:
                                                                            (BuildContext
                                                                        context) {
                                                                          return AlertDialog(
                                                                            title: const Text(
                                                                                'حذف الموعد'),
                                                                            content:
                                                                            const Text(
                                                                                'هل أنت متأكد أنك تريد حذف هذا الموعد؟'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed:
                                                                                    () {
                                                                                  Navigator.of(context)
                                                                                      .pop(false);
                                                                                },
                                                                                child: const Text(
                                                                                    'إلغاء'),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed:
                                                                                    () {
                                                                                  DrAidCubit.get(context).deleteAppointment(
                                                                                      appointmentId:
                                                                                      appointmentData.id!);

                                                                                  Navigator.of(context)
                                                                                      .pop(true);
                                                                                },
                                                                                child: const Text(
                                                                                    'حذف'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
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
                                                      .getAppointmentsByDateModel
                                                      ?.data
                                                      ?.length ??
                                                      0,
                                                ),
                                              )
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
                                    if(screenWidth>=800)
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
                                            if(screenWidth>=1250)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1250)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1250&&modee=='light')
                                              const Text(
                                                'Appointments',
                                                style: TextStyle(
                                                    fontSize: 28, color: blueText),
                                              ),
                                            if(screenWidth>=1250&&modee=='dark')
                                              const Text(
                                                'Appointments',
                                                style: TextStyle(
                                                    fontSize: 28, color: Colors.orange),
                                              ),
                                            const Spacer(),
                                            if(screenWidth>=1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  Waiting list   ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'Waiting',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
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
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1200)
                                              Container(
                                                width: 250,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                            if(screenWidth<1200)
                                              Container(
                                                width: 100,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                    if(screenWidth<800&&screenWidth>=680)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 20, end: 20),
                                        child: Row(
                                          children: [

                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            const Spacer(),
                                            if(screenWidth>=1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  Waiting list   ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'Waiting',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
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
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1200)
                                              Container(
                                                width: 250,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                            if(screenWidth<1200)
                                              Container(
                                                width: 100,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                    if(screenWidth<680)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 5, end: 5),
                                        child: Row(
                                          children: [

                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1200&&modee=='light')
                                              const Text(
                                                'Appointments',
                                                style: TextStyle(
                                                    fontSize: 28, color: blueText),
                                              ),
                                            if(screenWidth>=1200&&modee=='dark')
                                              const Text(
                                                'Appointments',
                                                style: TextStyle(
                                                    fontSize: 28, color: Colors.orange),
                                              ),
                                            const Spacer(),
                                            if(screenWidth>=1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  Waiting list   ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'Waiting',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
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
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1200)
                                              Container(
                                                width: 250,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                            if(screenWidth<1200)
                                              Container(
                                                width: 100,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                            const SizedBox(
                                              height: 18,
                                            ),
                                            const Padding(
                                              padding:
                                              EdgeInsetsDirectional.only(start: 30),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
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
                                              child: ListView.separated(
                                                itemBuilder: (context, index) {
                                                  final appointmentModel =
                                                      DrAidCubit.get(context)
                                                          .getAppointmentsByDateModel;

                                                  if (appointmentModel == null ||
                                                      appointmentModel.data == null ||
                                                      appointmentModel.data!.isEmpty) {
                                                    return const Center(
                                                      child: Text(
                                                          'No appointments available'),
                                                    );
                                                  }

                                                  final appointmentData =
                                                  appointmentModel.data![index];

                                                  // Check if patient or any other property is null
                                                  final patient =
                                                      appointmentData.patient;
                                                  final fullName = patient?.fullName ??
                                                      appointmentData.patientName;
                                                  final phoneNumber =
                                                      patient?.phoneNumber ??
                                                          appointmentData.patientPhone;
                                                  final complaint =
                                                      appointmentData.complaint ??
                                                          'No complaint';
                                                  final startTime =
                                                      appointmentData.startTime ??
                                                          'Unknown time';

                                                  return Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .only(start: 30),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(width: 30),
                                                        Expanded(
                                                          child: Text(
                                                            fullName!,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                color: fontColor),
                                                          ),
                                                        ),
                                                        if(screenWidth>=1200)
                                                          const SizedBox(width: 40),
                                                        if(screenWidth<1200)
                                                          const SizedBox(width: 10),
                                                        if(screenWidth>=1200)
                                                          Expanded(
                                                            child: Text(
                                                              complaint,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: fontColor),
                                                            ),
                                                          ),
                                                        if(screenWidth>=1200)
                                                          const SizedBox(width: 10),
                                                        if(screenWidth>=1000)
                                                          Expanded(
                                                            child: Text(
                                                              startTime,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: fontColor),
                                                            ),
                                                          ),
                                                        if(screenWidth>=800)
                                                          Expanded(
                                                            child: Text(
                                                              phoneNumber!,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: fontColor),
                                                            ),
                                                          ),
                                                        if(screenWidth>=900)
                                                          const SizedBox(width: 75),
                                                        Container(
                                                          width: 70,
                                                          height: 40,
                                                          color: Colors.white,
                                                          child: Center(
                                                            child: Row(
                                                              children: [
                                                                if(screenWidth>=900)
                                                                  const Image(
                                                                    image: AssetImage(
                                                                        'images/edit1.png'),
                                                                    width: 25,
                                                                    height: 25,
                                                                  ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context: context,
                                                                      builder:
                                                                          (BuildContext
                                                                      context) {
                                                                        return AlertDialog(
                                                                          title: const Text(
                                                                              'Delete appointment'),
                                                                          content:
                                                                          const Text(
                                                                              'Are you sure you want to delete ?'),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              onPressed:
                                                                                  () {
                                                                                Navigator.of(context)
                                                                                    .pop(false);
                                                                              },
                                                                              child: const Text(
                                                                                  'Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed:
                                                                                  () {
                                                                                DrAidCubit.get(context).deleteAppointment(
                                                                                    appointmentId:
                                                                                    appointmentData.id!);

                                                                                Navigator.of(context)
                                                                                    .pop(true);
                                                                              },
                                                                              child: const Text(
                                                                                  'Delete'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
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
                                                    .getAppointmentsByDateModel
                                                    ?.data
                                                    ?.length ??
                                                    0,
                                              ),
                                            )
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
                                      if(screenWidth>=800)
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
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200&&modee=='light')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1200&&modee=='dark')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1200&&modee=='light')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1200&&modee=='dark')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة الانتظار   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'الانتظار',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

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
                                                          'إضافة موعد جديد',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1200)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          'إضافة',
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
                                      if(screenWidth<800&&screenWidth>=680)
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
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200&&modee=='light')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 28, color: blueText),
                                                ),
                                              if(screenWidth>=1200&&modee=='dark')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 28, color: Colors.orange),
                                                ),
                                              if(screenWidth<1200&&modee=='light')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 14, color: blueText),
                                                ),
                                              if(screenWidth<1200&&modee=='dark')
                                                const Text(
                                                  'المواعيد',
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة الانتظار   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'الانتظار',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

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
                                                          'إضافة موعد جديد',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1200)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          'إضافة',
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
                                      if(screenWidth<680)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 5, end: 5),
                                          child: Row(
                                            children: [

                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              const Spacer(),
                                              if(screenWidth>=1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  قائمة الانتظار   ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1200)
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
                                                                child: AllWaitingList()));
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'الانتظار',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: coolOrange,
                                                ),
                                                onPressed: () {
                                                  showDatePickerDialog(context);
                                                },
                                                child: const Text(
                                                  "مواعيد يوم آخر",
                                                  style: TextStyle(color: white),
                                                ),
                                              ),
                                              if(screenWidth>=1200)
                                                const SizedBox(width: 20),
                                              if(screenWidth<1200)
                                                const SizedBox(width: 10),
                                              if(screenWidth>=1200)
                                                Container(
                                                  width: 250,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

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
                                                          'إضافة موعد جديد',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1200)
                                                Container(
                                                  width: 100,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addAppointmentToPatient(context);

                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsetsDirectional.only(
                                                          start: 30),
                                                      child: Row(children: [

                                                        Text(
                                                          'إضافة',
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
                                          child:  Column(
                                            children: [
                                              const SizedBox(
                                                height: 18,
                                              ),
                                              const Padding(
                                                padding:
                                                EdgeInsetsDirectional.only(start: 30),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 18),
                                              if(screenWidth>=1200)
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
                                                      SizedBox(width: 120),
                                                      Expanded(
                                                        child: Text(
                                                          'السبب',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 100),
                                                      Expanded(
                                                        child: Text(
                                                          "الموعد",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: fontColor),
                                                        ),
                                                      ),
                                                      SizedBox(width: 100),
                                                      Expanded(
                                                        child: Text(
                                                          "الرقم",
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
                                                child: ListView.separated(
                                                  itemBuilder: (context, index) {
                                                    final appointmentModel =
                                                        DrAidCubit.get(context)
                                                            .getAppointmentsByDateModel;

                                                    if (appointmentModel == null ||
                                                        appointmentModel.data == null ||
                                                        appointmentModel.data!.isEmpty) {
                                                      return const Center(
                                                        child: Text(
                                                            'No appointments available'),
                                                      );
                                                    }

                                                    final appointmentData =
                                                    appointmentModel.data![index];

                                                    // Check if patient or any other property is null
                                                    final patient =
                                                        appointmentData.patient;
                                                    final fullName = patient?.fullName ??
                                                        appointmentData.patientName;
                                                    final phoneNumber =
                                                        patient?.phoneNumber ??
                                                            appointmentData.patientPhone;
                                                    final complaint =
                                                        appointmentData.complaint ??
                                                            'No complaint';
                                                    final startTime =
                                                        appointmentData.startTime ??
                                                            'Unknown time';

                                                    return Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .only(start: 30),
                                                      child: Row(
                                                        children: [
                                                          const SizedBox(width: 30),
                                                          Expanded(
                                                            child: Text(
                                                              fullName!,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: fontColor),
                                                            ),
                                                          ),
                                                          if(screenWidth>=1200)
                                                            const SizedBox(width: 40),
                                                          if(screenWidth<1200)
                                                            const SizedBox(width: 10),
                                                          if(screenWidth>=1200)
                                                            Expanded(
                                                              child: Text(
                                                                complaint,
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    color: fontColor),
                                                              ),
                                                            ),
                                                          if(screenWidth>=1200)
                                                            const SizedBox(width: 10),
                                                          if(screenWidth>=1000)
                                                            Expanded(
                                                              child: Text(
                                                                startTime,
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    color: fontColor),
                                                              ),
                                                            ),
                                                          if(screenWidth>=800)
                                                            Expanded(
                                                              child: Text(
                                                                phoneNumber!,
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    color: fontColor),
                                                              ),
                                                            ),
                                                          if(screenWidth>=900)
                                                            const SizedBox(width: 75),
                                                          Container(
                                                            width: 70,
                                                            height: 40,
                                                            color: Colors.white,
                                                            child: Center(
                                                              child: Row(
                                                                children: [
                                                                  if(screenWidth>=900)
                                                                    const Image(
                                                                      image: AssetImage(
                                                                          'images/edit1.png'),
                                                                      width: 25,
                                                                      height: 25,
                                                                    ),
                                                                  const SizedBox(
                                                                      width: 10),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context: context,
                                                                        builder:
                                                                            (BuildContext
                                                                        context) {
                                                                          return AlertDialog(
                                                                            title: const Text(
                                                                                'حذف الموعد'),
                                                                            content:
                                                                            const Text(
                                                                                'هل أنت متأكد أنك تريد حذف هذا الموعد؟'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed:
                                                                                    () {
                                                                                  Navigator.of(context)
                                                                                      .pop(false);
                                                                                },
                                                                                child: const Text(
                                                                                    'إلغاء'),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed:
                                                                                    () {
                                                                                  DrAidCubit.get(context).deleteAppointment(
                                                                                      appointmentId:
                                                                                      appointmentData.id!);

                                                                                  Navigator.of(context)
                                                                                      .pop(true);
                                                                                },
                                                                                child: const Text(
                                                                                    'حذف'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
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
                                                      .getAppointmentsByDateModel
                                                      ?.data
                                                      ?.length ??
                                                      0,
                                                ),
                                              )
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
                                    if(screenWidth>=800)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 20, end: 130),
                                        child: Row(
                                          children: [
                                            if(modee=='light')
                                            InkWell(
                                              child: const Image(
                                                image: AssetImage('images/arrow.png'),
                                                width: 30,
                                                height: 20,
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            if(modee=='dark')
                                            InkWell(
                                              child: Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            if(screenWidth>=1250)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1250)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1250&&modee=='light')
                                              const Text(
                                                'Appointments',
                                                style: TextStyle(
                                                    fontSize: 28, color: blueText),
                                              ),
                                            if(screenWidth>=1250&&modee=='dark')
                                              const Text(
                                                'Appointments',
                                                style: TextStyle(
                                                    fontSize: 28, color: Colors.orange),
                                              ),
                                            const Spacer(),
                                            if(screenWidth>=1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  Waiting list   ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'Waiting',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
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
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1200)
                                              Container(
                                                width: 250,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                            if(screenWidth<1200)
                                              Container(
                                                width: 100,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                    if(screenWidth<800&&screenWidth>=680)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 20, end: 20),
                                        child: Row(
                                          children: [
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            const Spacer(),
                                            if(screenWidth>=1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  Waiting list   ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'Waiting',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
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
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1200)
                                              Container(
                                                width: 250,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                            if(screenWidth<1200)
                                              Container(
                                                width: 100,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                    if(screenWidth<680)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 5, end: 5),
                                        child: Row(
                                          children: [

                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            const Spacer(),
                                            if(screenWidth>=1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  Waiting list   ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1200)
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
                                                              child: AllWaitingList()));
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'Waiting',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
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
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1200)
                                              Container(
                                                width: 250,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                            if(screenWidth<1200)
                                              Container(
                                                width: 100,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAppointmentToPatient(context);

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
                                        child:  Column(
                                          children: [
                                            const SizedBox(
                                              height: 18,
                                            ),
                                            const Padding(
                                              padding:
                                              EdgeInsetsDirectional.only(start: 30),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
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
                                              child: ListView.separated(
                                                itemBuilder: (context, index) {
                                                  final appointmentModel =
                                                      DrAidCubit.get(context)
                                                          .getAppointmentsByDateModel;

                                                  if (appointmentModel == null ||
                                                      appointmentModel.data == null ||
                                                      appointmentModel.data!.isEmpty) {
                                                    return const Center(
                                                      child: Text(
                                                          'No appointments available'),
                                                    );
                                                  }

                                                  final appointmentData =
                                                  appointmentModel.data![index];

                                                  // Check if patient or any other property is null
                                                  final patient =
                                                      appointmentData.patient;
                                                  final fullName = patient?.fullName ??
                                                      appointmentData.patientName;
                                                  final phoneNumber =
                                                      patient?.phoneNumber ??
                                                          appointmentData.patientPhone;
                                                  final complaint =
                                                      appointmentData.complaint ??
                                                          'No complaint';
                                                  final startTime =
                                                      appointmentData.startTime ??
                                                          'Unknown time';

                                                  return Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .only(start: 30),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(width: 30),
                                                        Expanded(
                                                          child: Text(
                                                            fullName!,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                color: fontColor),
                                                          ),
                                                        ),
                                                        if(screenWidth>=1200)
                                                          const SizedBox(width: 40),
                                                        if(screenWidth<1200)
                                                          const SizedBox(width: 10),
                                                        if(screenWidth>=1200)
                                                          Expanded(
                                                            child: Text(
                                                              complaint,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: fontColor),
                                                            ),
                                                          ),
                                                        if(screenWidth>=1200)
                                                          const SizedBox(width: 10),
                                                        if(screenWidth>=1000)
                                                          Expanded(
                                                            child: Text(
                                                              startTime,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: fontColor),
                                                            ),
                                                          ),
                                                        if(screenWidth>=800)
                                                          Expanded(
                                                            child: Text(
                                                              phoneNumber!,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: fontColor),
                                                            ),
                                                          ),
                                                        if(screenWidth>=900)
                                                          const SizedBox(width: 75),
                                                        Container(
                                                          width: 70,
                                                          height: 40,
                                                          color: Colors.white,
                                                          child: Center(
                                                            child: Row(
                                                              children: [
                                                                if(screenWidth>=900)
                                                                  const Image(
                                                                    image: AssetImage(
                                                                        'images/edit1.png'),
                                                                    width: 25,
                                                                    height: 25,
                                                                  ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context: context,
                                                                      builder:
                                                                          (BuildContext
                                                                      context) {
                                                                        return AlertDialog(
                                                                          title: const Text(
                                                                              'Delete appointment'),
                                                                          content:
                                                                          const Text(
                                                                              'Are you sure you want to delete ?'),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              onPressed:
                                                                                  () {
                                                                                Navigator.of(context)
                                                                                    .pop(false);
                                                                              },
                                                                              child: const Text(
                                                                                  'Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed:
                                                                                  () {
                                                                                DrAidCubit.get(context).deleteAppointment(
                                                                                    appointmentId:
                                                                                    appointmentData.id!);

                                                                                Navigator.of(context)
                                                                                    .pop(true);
                                                                              },
                                                                              child: const Text(
                                                                                  'Delete'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
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
                                                    .getAppointmentsByDateModel
                                                    ?.data
                                                    ?.length ??
                                                    0,
                                              ),
                                            )
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
