import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../models/get_completed_treatments_model.dart';

class CompleteTreatmentsScreen extends StatefulWidget {
  const CompleteTreatmentsScreen({super.key});

  @override
  State<CompleteTreatmentsScreen> createState() =>
      _CompleteTreatmentsScreenState();
}

class _CompleteTreatmentsScreenState extends State<CompleteTreatmentsScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = DrAidCubit.get(context);
    print("patient id: ${cubit.getPatientModel?.data.id} ");
    cubit.getAllCompletedTreatments(
      patientId: '${DrAidCubit.get(context).getPatientModel?.data.id}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    void addCompleteTreatmentItem(BuildContext context) {
      TextEditingController fromTeethController = TextEditingController();
      TextEditingController toTeethController = TextEditingController();
      TextEditingController notesController = TextEditingController();
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Builder(
            builder: (context) {
              if(languagee=='arabic')
                {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: GestureDetector(
                      onTap: () {
                        DrAidCubit.get(context).getAllCompletedTreatments(
                          patientId:
                          '${DrAidCubit.get(context).getPatientModel?.data.id}',
                        );
                        Navigator.of(context).pop();
                      },
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: SimpleDialog(
                                title: const Padding(
                                  padding: EdgeInsetsDirectional.only(start: 100),
                                  child: Text(
                                    'إضافة علاج مكتمل',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: simpleDialogTitleColor,
                                    ),
                                  ),
                                ),
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.30,
                                    height: 500,
                                    child: Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.only(start: 50),
                                              child: Text(
                                                'مكان العلاج',
                                                style: TextStyle(
                                                    fontSize: 16, color: fontColor3),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if(screenWidth>=1450)
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: 400,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: borderColor,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 40),
                                                    child: Text(
                                                      DrAidCubit.get(context)
                                                          .selectedPlaceCompleted ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: fontColor3,
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        end: 30),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<String>(
                                                        icon:
                                                        const Icon(Icons.arrow_drop_up),
                                                        style: const TextStyle(
                                                            color: Colors.black),
                                                        value: DrAidCubit.get(context)
                                                            .selectedPlaceCompleted,
                                                        items: const [
                                                          DropdownMenuItem(
                                                            value: 'سن',
                                                            child: Text('سن'),
                                                          ),
                                                          DropdownMenuItem(
                                                            value: 'لثة',
                                                            child: Text('لثة'),
                                                          ),
                                                          DropdownMenuItem(
                                                            value: 'فم',
                                                            child: Text('فم'),
                                                          ),
                                                        ],
                                                        onChanged: (String? newValue) {
                                                          DrAidCubit.get(context)
                                                              .changeToothOrGumCompleted(
                                                              newValue!);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if(screenWidth<1450)
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: 200,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: borderColor,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 40),
                                                    child: Text(
                                                      DrAidCubit.get(context)
                                                          .selectedPlaceCompleted ??
                                                          '',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: fontColor3,
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        end: 30),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<String>(
                                                        icon:
                                                        const Icon(Icons.arrow_drop_up),
                                                        style: const TextStyle(
                                                            color: Colors.black),
                                                        value: DrAidCubit.get(context)
                                                            .selectedPlaceCompleted,
                                                        items: const [
                                                          DropdownMenuItem(
                                                            value: 'سن',
                                                            child: Text('سن'),
                                                          ),
                                                          DropdownMenuItem(
                                                            value: 'لثة',
                                                            child: Text('لثة'),
                                                          ),
                                                          DropdownMenuItem(
                                                            value: 'فم',
                                                            child: Text('فم'),
                                                          ),
                                                        ],
                                                        onChanged: (String? newValue) {
                                                          DrAidCubit.get(context)
                                                              .changeToothOrGumCompleted(
                                                              newValue!);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if (DrAidCubit.get(context)
                                            .selectedPlaceCompleted ==
                                            'سن') ...[
                                          const Row(
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsetsDirectional.only(start: 50),
                                                child: Text(
                                                  'رقم السن',
                                                  style: TextStyle(
                                                      fontSize: 16, color: fontColor3),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.only(
                                                start: 30),
                                            child: Row(
                                              children: [
                                                if(screenWidth>=1450)
                                                  Container(
                                                    height: 40,
                                                    width: 180,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    margin:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 20),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional.only(
                                                          start: 15),
                                                      child: AddTreatmentFormField(
                                                        type: TextInputType.number,
                                                        controller: fromTeethController,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'رجاءً ادخل رقم السن';
                                                          }
                                                          return null;
                                                        },
                                                        label: 'أدخل رقم السن',
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth<1450)
                                                  Container(
                                                    height: 40,
                                                    width: 130,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    margin:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 20),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional.only(
                                                          start: 15),
                                                      child: AddTreatmentFormField(
                                                        type: TextInputType.number,
                                                        controller: fromTeethController,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'رجاءً ادخل رقم السن';
                                                          }
                                                          return null;
                                                        },
                                                        label: 'أدخل رقم السن',
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth>=1450)
                                                  const SizedBox(width: 15),
                                                if(screenWidth<1450)
                                                  const SizedBox(width: 5),
                                                Checkbox(
                                                  value: DrAidCubit.get(context)
                                                      .checkBoxValueCompleted,
                                                  onChanged: (bool? value) {
                                                    DrAidCubit.get(context)
                                                        .changeCheckBoxCompleted();
                                                  },
                                                  activeColor: Colors.green,
                                                  checkColor: Colors.white,
                                                  shape: const RoundedRectangleBorder(
                                                    side: BorderSide(color: fontColor2),
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                const Text(
                                                  'أكثر من سن',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: fontColor2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          if (DrAidCubit.get(context)
                                              .checkBoxValueCompleted) ...[
                                            Padding(
                                              padding: const EdgeInsetsDirectional.only(
                                                  start: 30),
                                              child: Row(
                                                children: [
                                                  if(screenWidth>=1450)
                                                    Container(
                                                      height: 40,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        border: Border.all(
                                                          color: borderColor,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      margin:
                                                      const EdgeInsetsDirectional.only(
                                                          start: 20),
                                                      child: Padding(
                                                        padding: const EdgeInsetsDirectional
                                                            .only(start: 15),
                                                        child: AddTreatmentFormField(
                                                          type: TextInputType.number,
                                                          controller: fromTeethController,
                                                          validate: (value) {
                                                            if (value!.isEmpty) {
                                                              return 'رجاءً ادخل رقم السن الأول';
                                                            }
                                                            return null;
                                                          },
                                                          label: 'من',
                                                        ),
                                                      ),
                                                    ),
                                                  if(screenWidth<1450)
                                                    Container(
                                                      height: 40,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        border: Border.all(
                                                          color: borderColor,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      margin:
                                                      const EdgeInsetsDirectional.only(
                                                          start: 20),
                                                      child: Padding(
                                                        padding: const EdgeInsetsDirectional
                                                            .only(start: 15),
                                                        child: AddTreatmentFormField(
                                                          type: TextInputType.number,
                                                          controller: fromTeethController,
                                                          validate: (value) {
                                                            if (value!.isEmpty) {
                                                              return 'رجاءً ادخل رقم السن الأول';
                                                            }
                                                            return null;
                                                          },
                                                          label: 'من',
                                                        ),
                                                      ),
                                                    ),
                                                  if(screenWidth>=1450)
                                                    const SizedBox(width: 15),
                                                  if(screenWidth<1450)
                                                    const SizedBox(width: 5),
                                                  if(screenWidth>=1450)
                                                    Container(
                                                      height: 40,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        border: Border.all(
                                                          color: borderColor,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      margin:
                                                      const EdgeInsets.only(left: 20),
                                                      child: Padding(
                                                        padding: const EdgeInsetsDirectional
                                                            .only(start: 15),
                                                        child: AddTreatmentFormField(
                                                          type: TextInputType.number,
                                                          controller: toTeethController,
                                                          validate: (value) {
                                                            if (value!.isEmpty) {
                                                              return 'رجاءً ادخل رقم السن الأخير';
                                                            }
                                                            return null;
                                                          },
                                                          label: 'إلى',
                                                        ),
                                                      ),
                                                    ),
                                                  if(screenWidth<1450)
                                                    Container(
                                                      height: 40,
                                                      width: 130,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        border: Border.all(
                                                          color: borderColor,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      margin:
                                                      const EdgeInsets.only(left: 20),
                                                      child: Padding(
                                                        padding: const EdgeInsetsDirectional
                                                            .only(start: 15),
                                                        child: AddTreatmentFormField(
                                                          type: TextInputType.number,
                                                          controller: toTeethController,
                                                          validate: (value) {
                                                            if (value!.isEmpty) {
                                                              return 'رجاءً ادخل رقم السن الأخير';
                                                            }
                                                            return null;
                                                          },
                                                          label: 'إلى',
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                        const SizedBox(height: 10),
                                        const Padding(
                                          padding: EdgeInsetsDirectional.only(start: 50),
                                          child: Row(
                                            children: [
                                              Text(
                                                'العلاج',
                                                style: TextStyle(
                                                    fontSize: 16, color: fontColor3),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(start: 30),
                                          child: Row(
                                            children: [
                                              if(screenWidth>=1450)
                                                Container(
                                                  height: 40,
                                                  width: 400,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(
                                                      color: borderColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  margin: const EdgeInsetsDirectional.only(
                                                      start: 20),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 15),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<String>(
                                                        isExpanded: true,
                                                        value: DrAidCubit.get(context)
                                                            .selectedTreatmentCompleted,
                                                        onChanged: (String? newValue) {
                                                          DrAidCubit.get(context)
                                                              .changeSelectedTreatmentCompleted(
                                                              newValue!);
                                                        },
                                                        items: DrAidCubit.get(context)
                                                            .alltreatments
                                                            .map((treatment) {
                                                          return DropdownMenuItem<String>(
                                                            value: treatment.id.toString(),
                                                            child: Text(treatment.title),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1450)
                                                Container(
                                                  height: 40,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(
                                                      color: borderColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  margin: const EdgeInsetsDirectional.only(
                                                      start: 20),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 15),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<String>(
                                                        isExpanded: true,
                                                        value: DrAidCubit.get(context)
                                                            .selectedTreatmentCompleted,
                                                        onChanged: (String? newValue) {
                                                          DrAidCubit.get(context)
                                                              .changeSelectedTreatmentCompleted(
                                                              newValue!);
                                                        },
                                                        items: DrAidCubit.get(context)
                                                            .alltreatments
                                                            .map((treatment) {
                                                          return DropdownMenuItem<String>(
                                                            value: treatment.id.toString(),
                                                            child: Text(treatment.title),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Padding(
                                          padding: EdgeInsetsDirectional.only(start: 50),
                                          child: Row(
                                            children: [
                                              Text(
                                                'ملاحظات',
                                                style: TextStyle(
                                                    fontSize: 16, color: fontColor3),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(start: 30),
                                          child: Row(
                                            children: [
                                              if(screenWidth>=1450)
                                                Container(
                                                  height: 40,
                                                  width: 400,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(
                                                      color: borderColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  margin: const EdgeInsetsDirectional.only(
                                                      start: 20),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 15),
                                                    child: AddTreatmentFormField(
                                                      type: TextInputType.text,
                                                      controller: notesController,
                                                      validate: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'رجاءً ادخل ملاحظات';
                                                        }
                                                        return null;
                                                      },
                                                      label: 'أدخل ملاحظات',
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1450)
                                                Container(
                                                  height: 40,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(
                                                      color: borderColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  margin: const EdgeInsetsDirectional.only(
                                                      start: 20),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 15),
                                                    child: AddTreatmentFormField(
                                                      type: TextInputType.text,
                                                      controller: notesController,
                                                      validate: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'رجاءً ادخل ملاحظات';
                                                        }
                                                        return null;
                                                      },
                                                      label: 'أدخل ملاحظات',
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            final DrAidCubit cubit =
                                            DrAidCubit.get(context);

                                            if (cubit.selectedTreatmentCompleted ==
                                                null) {
                                              EasyLoading.showError(
                                                  'لم يتم تحديد العلاج');
                                              return;
                                            }
                                            String place =
                                                cubit.selectedPlaceCompleted ?? '';
                                            if (place.isEmpty) {
                                              EasyLoading.showError(
                                                  'رجاءً حدد مكان العلاج');
                                              return;
                                            }

                                            int? fromTeeth;
                                            int? toTeeth;

                                            if (place == 'سن') {
                                              fromTeeth =
                                                  int.tryParse(fromTeethController.text);
                                              if (fromTeeth == null) {
                                                EasyLoading.showError(
                                                    'رجاءً ادخل رقم السن');
                                                return;
                                              }

                                              if (cubit.checkBoxValueCompleted) {
                                                toTeeth =
                                                    int.tryParse(toTeethController.text);
                                                if (toTeeth == null) {
                                                  EasyLoading.showError(
                                                      'رجاءً ادخل رقم السن الأخير');
                                                  return;
                                                }
                                                if (toTeeth < fromTeeth) {
                                                  EasyLoading.showError(
                                                      'رقم السن الأخير يجب أن يكون أكبر من أو يساوي رقم السن الأول');
                                                  return;
                                                }
                                              } else {
                                                toTeeth = fromTeeth;
                                              }
                                            }

                                            if (notesController.text.isEmpty) {
                                              EasyLoading.showError(
                                                  'رجاءً ادخل ملاحظاتك ');
                                              return;
                                            }
                                            String notes = notesController.text;

                                            try {
                                              int treatmentId = int.parse(
                                                  cubit.selectedTreatmentCompleted!);
                                              cubit.createCompletedTreatment(
                                                patientId: cubit.getPatientModel!.data.id,
                                                treatmentId: treatmentId,
                                                fromTeeth: fromTeeth,
                                                toTeeth: toTeeth,
                                                place: place,
                                                notes: notes,
                                              );
                                              cubit.getAllCompletedTreatments(
                                                  patientId:
                                                  '${DrAidCubit.get(context).getPatientModel?.data.id}');
                                              Navigator.pop(context);
                                            } catch (e) {
                                              EasyLoading.showError(
                                                  'حدث خطأ أثناء إضافة علاج مكتمل: ${e.toString()}');
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: 45,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: buttonColor,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'إضافة بند معالجة جديد',
                                                  style: TextStyle(
                                                      fontSize: 18, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              else{
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: GestureDetector(
                    onTap: () {
                      DrAidCubit.get(context).getAllCompletedTreatments(
                        patientId:
                        '${DrAidCubit.get(context).getPatientModel?.data.id}',
                      );
                      Navigator.of(context).pop();
                    },
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: SimpleDialog(
                              title: const Padding(
                                padding: EdgeInsetsDirectional.only(start: 100),
                                child: Text(
                                  'Add complete',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: simpleDialogTitleColor,
                                  ),
                                ),
                              ),
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.30,
                                  height: 500,
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.only(start: 50),
                                            child: Text(
                                              'Place',
                                              style: TextStyle(
                                                  fontSize: 16, color: fontColor3),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if(screenWidth>=1450)
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            width: 400,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: borderColor,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(
                                                      start: 40),
                                                  child: Text(
                                                    DrAidCubit.get(context)
                                                        .selectedPlaceCompleted ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: fontColor3,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(
                                                      end: 30),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      icon:
                                                      const Icon(Icons.arrow_drop_up),
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                      value: DrAidCubit.get(context)
                                                          .selectedPlaceCompleted,
                                                      items: const [
                                                        DropdownMenuItem(
                                                          value: 'سن',
                                                          child: Text('Tooth'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'لثة',
                                                          child: Text('Gum'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'فم',
                                                          child: Text('Mouth'),
                                                        ),
                                                      ],
                                                      onChanged: (String? newValue) {
                                                        DrAidCubit.get(context)
                                                            .changeToothOrGumCompleted(
                                                            newValue!);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if(screenWidth<1450)
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            width: 200,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: borderColor,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(
                                                      start: 40),
                                                  child: Text(
                                                    DrAidCubit.get(context)
                                                        .selectedPlaceCompleted ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: fontColor3,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(
                                                      end: 30),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      icon:
                                                      const Icon(Icons.arrow_drop_up),
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                      value: DrAidCubit.get(context)
                                                          .selectedPlaceCompleted,
                                                      items: const [
                                                        DropdownMenuItem(
                                                          value: 'سن',
                                                          child: Text('Tooth'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'لثة',
                                                          child: Text('Gum'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'فم',
                                                          child: Text('Mouth'),
                                                        ),
                                                      ],
                                                      onChanged: (String? newValue) {
                                                        DrAidCubit.get(context)
                                                            .changeToothOrGumCompleted(
                                                            newValue!);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (DrAidCubit.get(context)
                                          .selectedPlaceCompleted ==
                                          'سن') ...[
                                        const Row(
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.only(start: 50),
                                              child: Text(
                                                'Tooth num',
                                                style: TextStyle(
                                                    fontSize: 16, color: fontColor3),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 30),
                                          child: Row(
                                            children: [
                                              if(screenWidth>=1450)
                                                Container(
                                                  height: 40,
                                                  width: 180,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    border: Border.all(
                                                      color: borderColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  margin:
                                                  const EdgeInsetsDirectional.only(
                                                      start: 20),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 15),
                                                    child: AddTreatmentFormField(
                                                      type: TextInputType.number,
                                                      controller: fromTeethController,
                                                      validate: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Please enter tooth num';
                                                        }
                                                        return null;
                                                      },
                                                      label: 'Enter num',
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1450)
                                                Container(
                                                  height: 40,
                                                  width: 130,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    border: Border.all(
                                                      color: borderColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  margin:
                                                  const EdgeInsetsDirectional.only(
                                                      start: 20),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 15),
                                                    child: AddTreatmentFormField(
                                                      type: TextInputType.number,
                                                      controller: fromTeethController,
                                                      validate: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Please enter tooth num';
                                                        }
                                                        return null;
                                                      },
                                                      label: 'Enter tooth num',
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth>=1450)
                                                const SizedBox(width: 15),
                                              if(screenWidth<1450)
                                                const SizedBox(width: 5),
                                              Checkbox(
                                                value: DrAidCubit.get(context)
                                                    .checkBoxValueCompleted,
                                                onChanged: (bool? value) {
                                                  DrAidCubit.get(context)
                                                      .changeCheckBoxCompleted();
                                                },
                                                activeColor: Colors.green,
                                                checkColor: Colors.white,
                                                shape: const RoundedRectangleBorder(
                                                  side: BorderSide(color: fontColor2),
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              const Text(
                                                'Teeth',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: fontColor2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        if (DrAidCubit.get(context)
                                            .checkBoxValueCompleted) ...[
                                          Padding(
                                            padding: const EdgeInsetsDirectional.only(
                                                start: 30),
                                            child: Row(
                                              children: [
                                                if(screenWidth>=1450)
                                                  Container(
                                                    height: 40,
                                                    width: 180,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    margin:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 20),
                                                    child: Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .only(start: 15),
                                                      child: AddTreatmentFormField(
                                                        type: TextInputType.number,
                                                        controller: fromTeethController,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Please enter start';
                                                          }
                                                          return null;
                                                        },
                                                        label: 'From',
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth<1450)
                                                  Container(
                                                    height: 40,
                                                    width: 130,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    margin:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 20),
                                                    child: Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .only(start: 15),
                                                      child: AddTreatmentFormField(
                                                        type: TextInputType.number,
                                                        controller: fromTeethController,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Please enter start';
                                                          }
                                                          return null;
                                                        },
                                                        label: 'From',
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth>=1450)
                                                  const SizedBox(width: 15),
                                                if(screenWidth<1450)
                                                  const SizedBox(width: 5),
                                                if(screenWidth>=1450)
                                                  Container(
                                                    height: 40,
                                                    width: 180,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    margin:
                                                    const EdgeInsets.only(left: 20),
                                                    child: Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .only(start: 15),
                                                      child: AddTreatmentFormField(
                                                        type: TextInputType.number,
                                                        controller: toTeethController,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Please enter last';
                                                          }
                                                          return null;
                                                        },
                                                        label: 'To',
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth<1450)
                                                  Container(
                                                    height: 40,
                                                    width: 130,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      border: Border.all(
                                                        color: borderColor,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    margin:
                                                    const EdgeInsets.only(left: 20),
                                                    child: Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .only(start: 15),
                                                      child: AddTreatmentFormField(
                                                        type: TextInputType.number,
                                                        controller: toTeethController,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Please enter last';
                                                          }
                                                          return null;
                                                        },
                                                        label: 'To',
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ],
                                      const SizedBox(height: 10),
                                      const Padding(
                                        padding: EdgeInsetsDirectional.only(start: 50),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Treat',
                                              style: TextStyle(
                                                  fontSize: 16, color: fontColor3),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(start: 30),
                                        child: Row(
                                          children: [
                                            if(screenWidth>=1450)
                                              Container(
                                                height: 40,
                                                width: 400,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: borderColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                margin: const EdgeInsetsDirectional.only(
                                                    start: 20),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(
                                                      start: 15),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      isExpanded: true,
                                                      value: DrAidCubit.get(context)
                                                          .selectedTreatmentCompleted,
                                                      onChanged: (String? newValue) {
                                                        DrAidCubit.get(context)
                                                            .changeSelectedTreatmentCompleted(
                                                            newValue!);
                                                      },
                                                      items: DrAidCubit.get(context)
                                                          .alltreatments
                                                          .map((treatment) {
                                                        return DropdownMenuItem<String>(
                                                          value: treatment.id.toString(),
                                                          child: Text(treatment.title),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth<1450)
                                              Container(
                                                height: 40,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: borderColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                margin: const EdgeInsetsDirectional.only(
                                                    start: 20),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(
                                                      start: 15),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      isExpanded: true,
                                                      value: DrAidCubit.get(context)
                                                          .selectedTreatmentCompleted,
                                                      onChanged: (String? newValue) {
                                                        DrAidCubit.get(context)
                                                            .changeSelectedTreatmentCompleted(
                                                            newValue!);
                                                      },
                                                      items: DrAidCubit.get(context)
                                                          .alltreatments
                                                          .map((treatment) {
                                                        return DropdownMenuItem<String>(
                                                          value: treatment.id.toString(),
                                                          child: Text(treatment.title),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Padding(
                                        padding: EdgeInsetsDirectional.only(start: 50),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Comments',
                                              style: TextStyle(
                                                  fontSize: 16, color: fontColor3),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(start: 30),
                                        child: Row(
                                          children: [
                                            if(screenWidth>=1450)
                                              Container(
                                                height: 40,
                                                width: 400,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: borderColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                margin: const EdgeInsetsDirectional.only(
                                                    start: 20),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(
                                                      start: 15),
                                                  child: AddTreatmentFormField(
                                                    type: TextInputType.text,
                                                    controller: notesController,
                                                    validate: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please enter comments';
                                                      }
                                                      return null;
                                                    },
                                                    label: 'Enter comments',
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth<1450)
                                              Container(
                                                height: 40,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: borderColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                margin: const EdgeInsetsDirectional.only(
                                                    start: 20),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(
                                                      start: 15),
                                                  child: AddTreatmentFormField(
                                                    type: TextInputType.text,
                                                    controller: notesController,
                                                    validate: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please enter comments';
                                                      }
                                                      return null;
                                                    },
                                                    label: 'Enter comments',
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          final DrAidCubit cubit =
                                          DrAidCubit.get(context);

                                          if (cubit.selectedTreatmentCompleted ==
                                              null) {
                                            EasyLoading.showError(
                                                'Treat not selected');
                                            return;
                                          }
                                          String place =
                                              cubit.selectedPlaceCompleted ?? '';
                                          if (place.isEmpty) {
                                            EasyLoading.showError(
                                                'Please ente place');
                                            return;
                                          }

                                          int? fromTeeth;
                                          int? toTeeth;

                                          if (place == 'سن') {
                                            fromTeeth =
                                                int.tryParse(fromTeethController.text);
                                            if (fromTeeth == null) {
                                              EasyLoading.showError(
                                                  'Please enter tooth');
                                              return;
                                            }

                                            if (cubit.checkBoxValueCompleted) {
                                              toTeeth =
                                                  int.tryParse(toTeethController.text);
                                              if (toTeeth == null) {
                                                EasyLoading.showError(
                                                    'Please enter last');
                                                return;
                                              }
                                              if (toTeeth < fromTeeth) {
                                                EasyLoading.showError(
                                                    'Last must be bigger than start');
                                                return;
                                              }
                                            } else {
                                              toTeeth = fromTeeth;
                                            }
                                          }

                                          if (notesController.text.isEmpty) {
                                            EasyLoading.showError(
                                                'Please enter comments ');
                                            return;
                                          }
                                          String notes = notesController.text;

                                          try {
                                            int treatmentId = int.parse(
                                                cubit.selectedTreatmentCompleted!);
                                            cubit.createCompletedTreatment(
                                              patientId: cubit.getPatientModel!.data.id,
                                              treatmentId: treatmentId,
                                              fromTeeth: fromTeeth,
                                              toTeeth: toTeeth,
                                              place: place,
                                              notes: notes,
                                            );
                                            cubit.getAllCompletedTreatments(
                                                patientId:
                                                '${DrAidCubit.get(context).getPatientModel?.data.id}');
                                            Navigator.pop(context);
                                          } catch (e) {
                                            EasyLoading.showError(
                                                'Something went wrong ${e.toString()}');
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            height: 45,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: buttonColor,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Add item',
                                                style: TextStyle(
                                                    fontSize: 18, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

            }
          );
        },
      );
    }

    Widget completeTreatmentItem(Datum completedTreatment) {
      if(screenWidth>=1450)
      return Builder(
        builder: (context) {
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'رقم السن',
                          style: TextStyle(fontSize: 24, color: fontColor),
                        ),
                        SizedBox(
                          width: 335,
                        ),
                        Text(
                          'العلاج ',
                          style: TextStyle(fontSize: 24, color: fontColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        ItemBasicInformation(
                          text: '${completedTreatment.fromTeeth}',
                        ),
                        SizedBox(width: 20,),
                        ItemBasicInformation(
                          text: completedTreatment.treatment!.title!,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          else{
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Tooth num',
                        style: TextStyle(fontSize: 24, color: fontColor),
                      ),
                      SizedBox(
                        width: 335,
                      ),
                      Text(
                        'Treat ',
                        style: TextStyle(fontSize: 24, color: fontColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      ItemBasicInformation(
                        text: '${completedTreatment.fromTeeth}',
                      ),
                      SizedBox(width: 20,),
                      ItemBasicInformation(
                        text: completedTreatment.treatment!.title!,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

        }
      );
      else{
        return Builder(
          builder: (context) {
            if(languagee=='arabic')
              {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      Text(
                        'رقم السن',
                        style: TextStyle(fontSize: 24, color: fontColor),
                      ),
                      SizedBox(height: 15,),
                      ItemBasicInformationResponsive(
                        text: '${completedTreatment.fromTeeth}',
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'العلاج ',
                        style: TextStyle(fontSize: 24, color: fontColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ItemBasicInformationResponsive(
                        text: completedTreatment.treatment!.title!,
                      ),
                    ],
                  ),
                );
              }
            else{
              return Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    Text(
                      'Tooth num',
                      style: TextStyle(fontSize: 24, color: fontColor),
                    ),
                    SizedBox(height: 15,),
                    ItemBasicInformationResponsive(
                      text: '${completedTreatment.fromTeeth}',
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'Treat ',
                      style: TextStyle(fontSize: 24, color: fontColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ItemBasicInformationResponsive(
                      text: completedTreatment.treatment!.title!,
                    ),
                  ],
                ),
              );
            }

          }
        );
      }
    }

    return BlocBuilder<DrAidCubit, DrAidStates>(
      builder: (context, state) {
        List<Datum>? completedTreatment;
        if (state is DrAidAllCompletedTreatmentsSuccessState) {
          completedTreatment = state.getCompletedTreatmentsModel.data;
        }
        if(screenWidth>=1450)
        return Builder(
          builder: (context) {
            if(languagee=='arabic')
              {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      if (completedTreatment != null && completedTreatment.isNotEmpty)
                        Row(
                          children: [
                            Container(
                              width: 800,
                              height: 260,
                              color: Colors.white,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return completeTreatmentItem(
                                      completedTreatment![index]);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: completedTreatment.length,
                              ),
                            ),
                          ],
                        )
                      else if (state is DrAidAllCompletedTreatmentsErrorState)
                        const Text(
                          'لا يوجد خطط علاجية مكتملة بعد',
                          style: TextStyle(color: Colors.red),
                        )
                      else
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          DrAidCubit.get(context).getAllTreatments();
                          addCompleteTreatmentItem(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 45,
                            width: 230,
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'إضافة علاج مكتمل جديد',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    if (completedTreatment != null && completedTreatment.isNotEmpty)
                      Row(
                        children: [
                          Container(
                            width: 800,
                            height: 260,
                            color: Colors.white,
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return completeTreatmentItem(
                                    completedTreatment![index]);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: completedTreatment.length,
                            ),
                          ),
                        ],
                      )
                    else if (state is DrAidAllCompletedTreatmentsErrorState)
                      const Text(
                        'No completed plans yet',
                        style: TextStyle(color: Colors.red),
                      )
                    else
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        DrAidCubit.get(context).getAllTreatments();
                        addCompleteTreatmentItem(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 45,
                          width: 230,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'Add Treatment',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

          }
        );
        else if(screenWidth<1450&&screenWidth>=850){
          return  Builder(
            builder: (context) {
              if(languagee=='arabic')
                {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        if (completedTreatment != null && completedTreatment.isNotEmpty)
                          Row(
                            children: [
                              Container(
                                width: 300,
                                height: 260,
                                color: Colors.white,
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return completeTreatmentItem(
                                        completedTreatment![index]);
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: completedTreatment.length,
                                ),
                              ),
                            ],
                          )
                        else if (state is DrAidAllCompletedTreatmentsErrorState)
                          const Text(
                            'لا يوجد خطط علاجية مكتملة بعد',
                            style: TextStyle(color: Colors.red),
                          )
                        else
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            DrAidCubit.get(context).getAllTreatments();
                            addCompleteTreatmentItem(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 45,
                              width: 230,
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  'إضافة علاج مكتمل جديد',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ),
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      if (completedTreatment != null && completedTreatment.isNotEmpty)
                        Row(
                          children: [
                            Container(
                              width: 300,
                              height: 260,
                              color: Colors.white,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return completeTreatmentItem(
                                      completedTreatment![index]);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: completedTreatment.length,
                              ),
                            ),
                          ],
                        )
                      else if (state is DrAidAllCompletedTreatmentsErrorState)
                        const Text(
                          'Np completed plans yet',
                          style: TextStyle(color: Colors.red),
                        )
                      else
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          DrAidCubit.get(context).getAllTreatments();
                          addCompleteTreatmentItem(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 45,
                            width: 230,
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'Add treatment',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

            }
          );
        }
        else{
          return  Builder(
            builder: (context) {
              if(languagee=='')
                {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        if (completedTreatment != null && completedTreatment.isNotEmpty)
                          Row(
                            children: [
                              Container(
                                width: 200,
                                height: 260,
                                color: Colors.white,
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return completeTreatmentItem(
                                        completedTreatment![index]);
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: completedTreatment.length,
                                ),
                              ),
                            ],
                          )
                        else if (state is DrAidAllCompletedTreatmentsErrorState)
                          const Text(
                            'لا يوجد خطط علاجية مكتملة بعد',
                            style: TextStyle(color: Colors.red),
                          )
                        else
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            DrAidCubit.get(context).getAllTreatments();
                            addCompleteTreatmentItem(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 45,
                              width: 230,
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  'إضافة علاج مكتمل جديد',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ),
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      if (completedTreatment != null && completedTreatment.isNotEmpty)
                        Row(
                          children: [
                            Container(
                              width: 200,
                              height: 260,
                              color: Colors.white,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return completeTreatmentItem(
                                      completedTreatment![index]);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: completedTreatment.length,
                              ),
                            ),
                          ],
                        )
                      else if (state is DrAidAllCompletedTreatmentsErrorState)
                        const Text(
                          'No completed plans yet',
                          style: TextStyle(color: Colors.red),
                        )
                      else
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          DrAidCubit.get(context).getAllTreatments();
                          addCompleteTreatmentItem(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 45,
                            width: 230,
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'Add treatment',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

            }
          );

        }
      },
    );
  }
}
