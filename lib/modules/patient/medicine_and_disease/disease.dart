import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiseaseScreen extends StatelessWidget {
  const DiseaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController diseaseController = TextEditingController();
    TextEditingController notesController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void addDisease(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: SimpleDialog(
                  title: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 30),
                    child: Text(
                      'إضافة مرض مزمن',
                      style: TextStyle(
                        fontSize: 18,
                        color: simpleDialogTitleColor,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 250,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 30),
                              child: Column(
                                children: [
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
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: AddAttachmentField(
                                        type: TextInputType.text,
                                        controller: diseaseController,
                                        label: 'اسم المرض',
                                      ),
                                    ),
                                  ),
                                  FormField(
                                    validator: (value) {
                                      if (diseaseController.text.isEmpty) {
                                        return 'رجاءً ادخل اسم المرض';
                                      }
                                      return null;
                                    },
                                    builder: (state) {
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          if (state.errorText != null)
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 20, top: 5),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 30),
                              child: Column(
                                children: [
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
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: AddAttachmentField(
                                        type: TextInputType.text,
                                        controller: notesController,
                                        label: 'الملاحظات',
                                      ),
                                    ),
                                  ),
                                  FormField(
                                    validator: (value) {
                                      if (notesController.text.isEmpty) {
                                        return 'رجاءً ادخل ملاحظاتك ';
                                      }
                                      return null;
                                    },
                                    builder: (state) {
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          if (state.errorText != null)
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 20, top: 5),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  print("on Tap");
                                  print(
                                      " patient id: ${DrAidCubit.get(context).getPatientModel!.data.id}");
                                  print(" disease: ${diseaseController.text}");
                                  print(" notes: ${notesController.text}");
                                  DrAidCubit.get(context).createDisease(
                                    patientId: DrAidCubit.get(context)
                                        .getPatientModel!
                                        .data
                                        .id,
                                    diseaseList: diseaseController.text,
                                    notes: notesController.text,
                                  );
                                  Navigator.pop(context);
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
                                      'تأكيد الإضافة',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                    'Add illness',
                    style: TextStyle(
                      fontSize: 18,
                      color: simpleDialogTitleColor,
                    ),
                  ),
                ),
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: 250,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              children: [
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
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 15),
                                    child: AddAttachmentField(
                                      type: TextInputType.text,
                                      controller: diseaseController,
                                      label: 'Name',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (diseaseController.text.isEmpty) {
                                      return 'Please enter illness name';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              children: [
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
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 15),
                                    child: AddAttachmentField(
                                      type: TextInputType.text,
                                      controller: notesController,
                                      label: 'Comments',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (notesController.text.isEmpty) {
                                      return 'Please enter comments ';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                print("on Tap");
                                print(
                                    " patient id: ${DrAidCubit.get(context).getPatientModel!.data.id}");
                                print(" disease: ${diseaseController.text}");
                                print(" notes: ${notesController.text}");
                                DrAidCubit.get(context).createDisease(
                                  patientId: DrAidCubit.get(context)
                                      .getPatientModel!
                                      .data
                                      .id,
                                  diseaseList: diseaseController.text,
                                  notes: notesController.text,
                                );
                                Navigator.pop(context);
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
                                    'Add',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
    }

    return BlocConsumer<DrAidCubit, DrAidStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < 600;
        final isTablet = screenWidth >= 600 && screenWidth < 1200;
        final isDesktop = screenWidth >= 1200;
        if(languagee=='arabic')
          {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    children: [
                      Text(
                        'الأمراض المزمنة',
                        style: TextStyle(fontSize: 24, color: fontColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 20),
                              child: Row(
                                children: [
                                  Text(
                                    DrAidCubit.get(context)
                                        .getPatientModel
                                        ?.data
                                        .diseases
                                        ?.diseaseList ??
                                        "لا يوجد أمراض بعد..",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: fontColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      addDisease(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 20),
                      child: Container(
                        height: 45,
                        width: 230,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'إضافة مرض',
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
                  height: 15,
                ),
                const Row(
                  children: [
                    Text(
                      'Diseases',
                      style: TextStyle(fontSize: 24, color: fontColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 20),
                            child: Row(
                              children: [
                                Text(
                                  DrAidCubit.get(context)
                                      .getPatientModel
                                      ?.data
                                      .diseases
                                      ?.diseaseList ??
                                      "No Diseases yet",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: fontColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    addDisease(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Container(
                      height: 45,
                      width: 230,
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Add illness',
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

      },
    );
  }
}
