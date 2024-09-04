import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController medicineController = TextEditingController();
    TextEditingController allergyController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void addMedicine(BuildContext context) {
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
                      'إضافة دواء',
                      style: TextStyle(
                        fontSize: 18,
                        color: simpleDialogTitleColor,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 300,
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
                                        controller: medicineController,
                                        label: 'اسم الدواء',
                                      ),
                                    ),
                                  ),
                                  FormField(
                                    validator: (value) {
                                      if (medicineController.text.isEmpty) {
                                        return 'رجاءً ادخل اسم الدواء';
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
                                        controller: allergyController,
                                        label: 'الحساسيات',
                                      ),
                                    ),
                                  ),
                                  FormField(
                                    validator: (value) {
                                      if (allergyController.text.isEmpty) {
                                        return 'رجاءً ادخل الحساسيات';
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
                                  print(" medicine: ${medicineController.text}");
                                  print(" allergy: ${allergyController.text}");
                                  DrAidCubit.get(context).createMedicine(
                                    patientId: DrAidCubit.get(context)
                                        .getPatientModel!
                                        .data
                                        .id,
                                    medicationList: medicineController.text,
                                    allergyList: allergyController.text,
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
              textDirection: TextDirection.rtl,
              child: SimpleDialog(
                title: const Padding(
                  padding: EdgeInsetsDirectional.only(start: 30),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 18,
                      color: simpleDialogTitleColor,
                    ),
                  ),
                ),
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: 300,
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
                                      controller: medicineController,
                                      label: 'Med name',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (medicineController.text.isEmpty) {
                                      return 'Please enter med name';
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
                                      controller: allergyController,
                                      label: 'allergies',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (allergyController.text.isEmpty) {
                                      return 'Please enter allergies';
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
                                print(" medicine: ${medicineController.text}");
                                print(" allergy: ${allergyController.text}");
                                DrAidCubit.get(context).createMedicine(
                                  patientId: DrAidCubit.get(context)
                                      .getPatientModel!
                                      .data
                                      .id,
                                  medicationList: medicineController.text,
                                  allergyList: allergyController.text,
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
                                    'Add med',
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
                        ' أدوية المريض',
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
                                        .medications
                                        ?.medicationList ??
                                        "لا يوجد أدوية بعد..",
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
                      addMedicine(context);
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
                            'إضافة دواء',
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
                      ' Patient meds',
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
                                      .medications
                                      ?.medicationList ??
                                      "No meds yet",
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
                    addMedicine(context);
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
                          'Add med',
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
