import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../models/get_all_treatment_plans_model.dart';

class TreatmentsPlansScreen extends StatefulWidget {
  const TreatmentsPlansScreen({super.key});

  @override
  State<TreatmentsPlansScreen> createState() => _TreatmentsPlansScreenState();
}

class _TreatmentsPlansScreenState extends State<TreatmentsPlansScreen> {
  TextEditingController fromTeethController = TextEditingController();
  TextEditingController toTeethController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController sessionNumberController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController totalCostController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = DrAidCubit.get(context);
    cubit.getAllTreatmentPlans(
      patientId: '${DrAidCubit.get(context).getPatientModel?.data.id}',
    );
    cubit.alltreatments;
    print("all treatment: ${cubit.alltreatments}");
    cubit.getPlanDetailModel;
    print("allplanDetail: ${cubit.getPlanDetailModel}");
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    void treatmentPlanDetails(BuildContext context, int id) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Dialog(
                  child: Container(
                    height: 400,
                    width: 300,
                    padding: const EdgeInsets.all(16),
                    child: BlocConsumer<DrAidCubit, DrAidStates>(
                      listener: (context, state) {
                        // Optionally handle state changes here if needed
                      },
                      builder: (context, state) {
                        if (state is DrAidGetPlanDetailSuccessState ||
                            DrAidCubit.get(context).getPlanDetailModel != null) {
                          final planDetails = DrAidCubit.get(context)
                              .getPlanDetailModel!
                              .data
                              ?.where((datum) => datum.treatmentPlanId == id)
                              .toList() ??
                              [];

                          if (planDetails.isNotEmpty) {
                            return Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        height: 1,
                                        color: buttonColor,
                                      );
                                    },
                                    itemCount: planDetails.length,
                                    itemBuilder: (context, index) {
                                      final detail = planDetails[index];
                                      final treatments = detail.treatments;

                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'السن: ${detail.fromTeeth ?? 'غير محدد'}',
                                              style: const TextStyle(fontSize: 18)),
                                          Text(
                                            'العلاج: ${treatments?.isNotEmpty == true ? treatments!.first.title : 'غير محدد'}',
                                            style: const TextStyle(fontSize: 18),
                                          ),
                                          Text('الكلفة: ${detail.cost ?? 'غير محدد'}',
                                              style: const TextStyle(fontSize: 18)),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'لا يوجد بنود لهذه الخطة العلاجية .',
                                style: TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            );
                          }
                        } else if (state is DrAidGetPlanDetailErrorState) {
                          return Center(child: Text('Error: ${state.errorMsg}'));
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
              );
            }
          else{
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Dialog(
                child: Container(
                  height: 400,
                  width: 300,
                  padding: const EdgeInsets.all(16),
                  child: BlocConsumer<DrAidCubit, DrAidStates>(
                    listener: (context, state) {
                      // Optionally handle state changes here if needed
                    },
                    builder: (context, state) {
                      if (state is DrAidGetPlanDetailSuccessState ||
                          DrAidCubit.get(context).getPlanDetailModel != null) {
                        final planDetails = DrAidCubit.get(context)
                            .getPlanDetailModel!
                            .data
                            ?.where((datum) => datum.treatmentPlanId == id)
                            .toList() ??
                            [];

                        if (planDetails.isNotEmpty) {
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      height: 1,
                                      color: buttonColor,
                                    );
                                  },
                                  itemCount: planDetails.length,
                                  itemBuilder: (context, index) {
                                    final detail = planDetails[index];
                                    final treatments = detail.treatments;

                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Tooth: ${detail.fromTeeth ?? 'Not selected'}',
                                            style: const TextStyle(fontSize: 18)),
                                        Text(
                                          'Treatment: ${treatments?.isNotEmpty == true ? treatments!.first.title : 'Not selected'}',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text('Cost: ${detail.cost ?? 'Not selected'}',
                                            style: const TextStyle(fontSize: 18)),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'No items for this plan .',
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                          );
                        }
                      } else if (state is DrAidGetPlanDetailErrorState) {
                        return Center(child: Text('Error: ${state.errorMsg}'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            );
          }

        },
      );
    }

    void addTreatmentItem(BuildContext context, int id) {
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
                        DrAidCubit.get(context).getAllTreatmentPlans(
                            patientId:
                            '${DrAidCubit.get(context).getPatientModel?.data.id}');

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
                                    'إضافة بند معالجة',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black, // Replace with your color
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
                                                        .selectedPlace ??
                                                        'لثة',
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
                                                    child: DropdownButton(
                                                      icon:
                                                      const Icon(Icons.arrow_drop_up),
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                      value: DrAidCubit.get(context)
                                                          .selectedPlace,
                                                      items: const [
                                                        DropdownMenuItem(
                                                          value: 'لثة',
                                                          child: Text('لثة'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'سن',
                                                          child: Text('سن'),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: 'فم',
                                                          child: Text('فم'),
                                                        ),
                                                      ],
                                                      onChanged: (String? newValue) {
                                                        DrAidCubit.get(context)
                                                            .changeToothOrGum(newValue!);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            if (DrAidCubit.get(context).selectedPlace ==
                                                'سن') ...[
                                              const Padding(
                                                padding:
                                                EdgeInsetsDirectional.only(start: 50),
                                                child: Text(
                                                  'رقم السن',
                                                  style: TextStyle(
                                                      fontSize: 16, color: fontColor3),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.only(
                                                    start: 30),
                                                child: Row(
                                                  children: [
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
                                                      margin: const EdgeInsetsDirectional
                                                          .only(start: 20),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional
                                                            .only(start: 15),
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
                                                    const SizedBox(width: 15),
                                                    Checkbox(
                                                      value: DrAidCubit.get(context)
                                                          .checkBoxValue,
                                                      onChanged: (bool? value) {
                                                        DrAidCubit.get(context)
                                                            .changeCheckBox();
                                                      },
                                                      activeColor: Colors.green,
                                                      checkColor: Colors.white,
                                                      shape: const RoundedRectangleBorder(
                                                        side:
                                                        BorderSide(color: fontColor2),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    const Text(
                                                      'أكثر من سن',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: fontColor2),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        if (DrAidCubit.get(context).checkBoxValue)
                                          Padding(
                                            padding: const EdgeInsetsDirectional.only(
                                                start: 30),
                                            child: Row(
                                              children: [
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
                                                          return 'رجاءً ادخل رقم السن الأول';
                                                        }
                                                        return null;
                                                      },
                                                      label: 'من',
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
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
                                                  margin: const EdgeInsets.only(left: 20),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional.only(
                                                        start: 15),
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
                                                          .selectedTreatment,
                                                      onChanged: (String? newValue) {
                                                        DrAidCubit.get(context)
                                                            .changeSelectedTreatment(
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
                                                'تكلفة العلاج',
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
                                                    type: TextInputType.number,
                                                    controller: costController,
                                                    validate: null,
                                                    label: 'أدخل التكلفة',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            try {
                                              print("on tap");
                                              print("treatmentPlanId: $id");

                                              final selectedPlace =
                                                  DrAidCubit.get(context).selectedPlace;
                                              final selectedTreatment =
                                                  DrAidCubit.get(context)
                                                      .selectedTreatment;

                                              if (selectedPlace == null) {
                                                EasyLoading.showError(
                                                    'لم يتم تحديد مكان العلاج');
                                                return;
                                              }

                                              if (selectedTreatment == null) {
                                                EasyLoading.showError(
                                                    'لم يتم تحديد العلاج');
                                                return;
                                              }

                                              int treatmentId =
                                              int.parse(selectedTreatment);
                                              print("treatmentId: $treatmentId");

                                              String place = selectedPlace;
                                              print("place: $place");

                                              int? fromTeeth;
                                              int? toTeeth;

                                              if (place == 'سن') {
                                                if (fromTeethController.text.isEmpty) {
                                                  EasyLoading.showError(
                                                      'رجاءً ادخل رقم السن');
                                                  return;
                                                }
                                                fromTeeth = int.tryParse(
                                                    fromTeethController.text);

                                                if (DrAidCubit.get(context)
                                                    .checkBoxValue) {
                                                  if (toTeethController.text.isEmpty) {
                                                    EasyLoading.showError(
                                                        'رجاءً ادخل رقم السن الأخير');
                                                    return;
                                                  }
                                                  toTeeth = int.tryParse(
                                                      toTeethController.text);
                                                } else {
                                                  toTeeth = null;
                                                }
                                              } else {
                                                fromTeeth = null;
                                                toTeeth = null;
                                              }

                                              if (costController.text.isEmpty) {
                                                EasyLoading.showError(
                                                    'رجاءً ادخل تكلفة العلاج');
                                                return;
                                              }
                                              double cost =
                                              double.parse(costController.text);
                                              print("cost: $cost");

                                              DrAidCubit.get(context).createDetail(
                                                treatmentPlanId: id,
                                                treatmentId: treatmentId,
                                                fromTeeth: fromTeeth,
                                                toTeeth: toTeeth,
                                                place: place,
                                                cost: cost,
                                              );
                                              DrAidCubit.get(context).getAllTreatmentPlans(
                                                  patientId:
                                                  '${DrAidCubit.get(context).getPatientModel?.data.id}');
                                              Navigator.pop(context);
                                            } catch (e) {
                                              print("Error: $e");
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: 45,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .blue, // Replace with your button color
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
                                        )
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
                      DrAidCubit.get(context).getAllTreatmentPlans(
                          patientId:
                          '${DrAidCubit.get(context).getPatientModel?.data.id}');

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
                                  'Add item',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black, // Replace with your color
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
                                                      .selectedPlace ??
                                                      'لثة',
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
                                                  child: DropdownButton(
                                                    icon:
                                                    const Icon(Icons.arrow_drop_up),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    value: DrAidCubit.get(context)
                                                        .selectedPlace,
                                                    items: const [
                                                      DropdownMenuItem(
                                                        value: 'لثة',
                                                        child: Text('Gum'),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: 'سن',
                                                        child: Text('Tooth'),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: 'فم',
                                                        child: Text('Mouth'),
                                                      ),
                                                    ],
                                                    onChanged: (String? newValue) {
                                                      DrAidCubit.get(context)
                                                          .changeToothOrGum(newValue!);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          if (DrAidCubit.get(context).selectedPlace ==
                                              'سن') ...[
                                            const Padding(
                                              padding:
                                              EdgeInsetsDirectional.only(start: 50),
                                              child: Text(
                                                'Tooth num',
                                                style: TextStyle(
                                                    fontSize: 16, color: fontColor3),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.only(
                                                  start: 30),
                                              child: Row(
                                                children: [
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
                                                    margin: const EdgeInsetsDirectional
                                                        .only(start: 20),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .only(start: 15),
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
                                                  const SizedBox(width: 15),
                                                  Checkbox(
                                                    value: DrAidCubit.get(context)
                                                        .checkBoxValue,
                                                    onChanged: (bool? value) {
                                                      DrAidCubit.get(context)
                                                          .changeCheckBox();
                                                    },
                                                    activeColor: Colors.green,
                                                    checkColor: Colors.white,
                                                    shape: const RoundedRectangleBorder(
                                                      side:
                                                      BorderSide(color: fontColor2),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  const Text(
                                                    'Teeth',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: fontColor2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      if (DrAidCubit.get(context).checkBoxValue)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 30),
                                          child: Row(
                                            children: [
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
                                                        return 'Enter the start';
                                                      }
                                                      return null;
                                                    },
                                                    label: 'From',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 15),
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
                                                margin: const EdgeInsets.only(left: 20),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(
                                                      start: 15),
                                                  child: AddTreatmentFormField(
                                                    type: TextInputType.number,
                                                    controller: toTeethController,
                                                    validate: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Enter last';
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
                                      const SizedBox(height: 10),
                                      const Padding(
                                        padding: EdgeInsetsDirectional.only(start: 50),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Treatment',
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
                                                        .selectedTreatment,
                                                    onChanged: (String? newValue) {
                                                      DrAidCubit.get(context)
                                                          .changeSelectedTreatment(
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
                                              'Cost',
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
                                                  type: TextInputType.number,
                                                  controller: costController,
                                                  validate: null,
                                                  label: 'Enter cost',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          try {
                                            print("on tap");
                                            print("treatmentPlanId: $id");

                                            final selectedPlace =
                                                DrAidCubit.get(context).selectedPlace;
                                            final selectedTreatment =
                                                DrAidCubit.get(context)
                                                    .selectedTreatment;

                                            if (selectedPlace == null) {
                                              EasyLoading.showError(
                                                  'Treatment not selected');
                                              return;
                                            }

                                            if (selectedTreatment == null) {
                                              EasyLoading.showError(
                                                  'Treatment not selected');
                                              return;
                                            }

                                            int treatmentId =
                                            int.parse(selectedTreatment);
                                            print("treatmentId: $treatmentId");

                                            String place = selectedPlace;
                                            print("place: $place");

                                            int? fromTeeth;
                                            int? toTeeth;

                                            if (place == 'سن') {
                                              if (fromTeethController.text.isEmpty) {
                                                EasyLoading.showError(
                                                    'Please enter tooth');
                                                return;
                                              }
                                              fromTeeth = int.tryParse(
                                                  fromTeethController.text);

                                              if (DrAidCubit.get(context)
                                                  .checkBoxValue) {
                                                if (toTeethController.text.isEmpty) {
                                                  EasyLoading.showError(
                                                      'Please enter last');
                                                  return;
                                                }
                                                toTeeth = int.tryParse(
                                                    toTeethController.text);
                                              } else {
                                                toTeeth = null;
                                              }
                                            } else {
                                              fromTeeth = null;
                                              toTeeth = null;
                                            }

                                            if (costController.text.isEmpty) {
                                              EasyLoading.showError(
                                                  'Please enter cost');
                                              return;
                                            }
                                            double cost =
                                            double.parse(costController.text);
                                            print("cost: $cost");

                                            DrAidCubit.get(context).createDetail(
                                              treatmentPlanId: id,
                                              treatmentId: treatmentId,
                                              fromTeeth: fromTeeth,
                                              toTeeth: toTeeth,
                                              place: place,
                                              cost: cost,
                                            );
                                            DrAidCubit.get(context).getAllTreatmentPlans(
                                                patientId:
                                                '${DrAidCubit.get(context).getPatientModel?.data.id}');
                                            Navigator.pop(context);
                                          } catch (e) {
                                            print("Error: $e");
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            height: 45,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .blue, // Replace with your button color
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Add Item',
                                                style: TextStyle(
                                                    fontSize: 18, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
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

    void addNewTreatmentPlan(BuildContext context) {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: SimpleDialog(
                  title: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 40),
                    child: Text(
                      'خطة علاجية جديدة',
                      style: TextStyle(
                        fontSize: 18,
                        color: simpleDialogTitleColor,
                      ),
                    ),
                  ),
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 400,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 5),
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
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: sessionNumberController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'عدد الجلسات',
                                        ),
                                      ),
                                    ),
                                  ),
                                  FormField(
                                    validator: (value) {
                                      if (sessionNumberController.text.isEmpty) {
                                        return 'رجاءً ادخل عدد الجلسات';
                                      }
                                      if (int.tryParse(
                                          sessionNumberController.text) ==
                                          null) {
                                        return 'عدد الجلسات يجب أن يكون رقم';
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
                              padding: const EdgeInsetsDirectional.only(start: 5),
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
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: discountController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'الحسم',
                                        ),
                                      ),
                                    ),
                                  ),
                                  FormField(
                                    validator: (value) {
                                      if (discountController.text.isEmpty) {
                                        return 'رجاءً ادخل قيمة الحسم';
                                      }
                                      if (double.tryParse(
                                          discountController.text) ==
                                          null) {
                                        return 'الحسم يجب أن يكون رقم';
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
                              padding: const EdgeInsetsDirectional.only(start: 5),
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
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: totalCostController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'الكلفة',
                                        ),
                                      ),
                                    ),
                                  ),
                                  FormField(
                                    validator: (value) {
                                      if (totalCostController.text.isEmpty) {
                                        return 'رجاءً ادخل الكلفة';
                                      }
                                      if (double.tryParse(
                                          totalCostController.text) ==
                                          null) {
                                        return 'الكلفة يجب أن تكون رقم';
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

                            // Submit Button
                            InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  print("on Tap");
                                  print(
                                      " patient id: ${DrAidCubit.get(context).getPatientModel!.data.id}");
                                  print(
                                      " sessionNumber: ${sessionNumberController.text}");
                                  print(" discount: ${discountController.text}");
                                  print(" totalCost: ${totalCostController.text}");
                                  DrAidCubit.get(context).createTreatmentPlan(
                                    patientId: DrAidCubit.get(context)
                                        .getPatientModel!
                                        .data
                                        .id,
                                    sessionNumber:
                                    int.parse(sessionNumberController.text),
                                    discount: double.parse(discountController.text),
                                    totalCost:
                                    double.parse(totalCostController.text),
                                  );
                                  DrAidCubit.get(context).getAllTreatmentPlans(
                                    patientId:
                                    '${DrAidCubit.get(context).getPatientModel?.data.id}',
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
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),
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
                  padding: EdgeInsetsDirectional.only(start: 40),
                  child: Text(
                    'New plan',
                    style: TextStyle(
                      fontSize: 18,
                      color: simpleDialogTitleColor,
                    ),
                  ),
                ),
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: 400,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 5),
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
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: sessionNumberController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Sessions',
                                      ),
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (sessionNumberController.text.isEmpty) {
                                      return 'Please enter number of sessions';
                                    }
                                    if (int.tryParse(
                                        sessionNumberController.text) ==
                                        null) {
                                      return 'Sessions must be number';
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
                            padding: const EdgeInsetsDirectional.only(start: 5),
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
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: discountController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Discount',
                                      ),
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (discountController.text.isEmpty) {
                                      return 'Please enter discount value';
                                    }
                                    if (double.tryParse(
                                        discountController.text) ==
                                        null) {
                                      return 'Discount must be number';
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
                            padding: const EdgeInsetsDirectional.only(start: 5),
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
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: totalCostController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Cost',
                                      ),
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (totalCostController.text.isEmpty) {
                                      return 'Please enter cost';
                                    }
                                    if (double.tryParse(
                                        totalCostController.text) ==
                                        null) {
                                      return 'Cost must be number';
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

                          // Submit Button
                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                print("on Tap");
                                print(
                                    " patient id: ${DrAidCubit.get(context).getPatientModel!.data.id}");
                                print(
                                    " sessionNumber: ${sessionNumberController.text}");
                                print(" discount: ${discountController.text}");
                                print(" totalCost: ${totalCostController.text}");
                                DrAidCubit.get(context).createTreatmentPlan(
                                  patientId: DrAidCubit.get(context)
                                      .getPatientModel!
                                      .data
                                      .id,
                                  sessionNumber:
                                  int.parse(sessionNumberController.text),
                                  discount: double.parse(discountController.text),
                                  totalCost:
                                  double.parse(totalCostController.text),
                                );
                                DrAidCubit.get(context).getAllTreatmentPlans(
                                  patientId:
                                  '${DrAidCubit.get(context).getPatientModel?.data.id}',
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
                                    'Add plan',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),
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

    void addNewDetailPlan(BuildContext context, int id) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            if(languagee=='arabic')
              {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: SimpleDialog(
                    title: const Padding(
                      padding: EdgeInsetsDirectional.only(start: 80),
                      child: Text(
                        'بند علاجي جديد',
                        style: TextStyle(
                          fontSize: 18,
                          color: simpleDialogTitleColor,
                        ),
                      ),
                    ),
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: 400,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
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
                                child: InkWell(
                                  onTap: () {
                                    DrAidCubit.get(context).getAllTreatments();
                                    addTreatmentItem(context, id);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 20, top: 10.0),
                                    child: Text(
                                      '+ إضافة بند علاجي',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: simpleDialogTitleColor,
                                      ),
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
                );
              }
            else{
              return Directionality(
                textDirection: TextDirection.ltr,
                child: SimpleDialog(
                  title: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 80),
                    child: Text(
                      'New item',
                      style: TextStyle(
                        fontSize: 18,
                        color: simpleDialogTitleColor,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 400,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
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
                              child: InkWell(
                                onTap: () {
                                  DrAidCubit.get(context).getAllTreatments();
                                  addTreatmentItem(context, id);
                                },
                                child: const Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 20, top: 10.0),
                                  child: Text(
                                    'Add item',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: simpleDialogTitleColor,
                                    ),
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
              );
            }

          });
    }

    Widget treatmentPlanItem(Datum treatmentPlan) {
      if(screenWidth>=1450)
      return Builder(
        builder: (context) {
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                      child: Container(
                        width: 250,
                        height: 230,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: coolBorderColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'التكلفة:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: fontColor2,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${treatmentPlan.totalCost ?? 0}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: fontColor2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'عدد الجلسات:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: fontColor2,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${treatmentPlan.sessionNumber}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: fontColor2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'الحسم:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: fontColor2,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${treatmentPlan.discount}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: fontColor2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print("البنود العلاجية للخطة : ${treatmentPlan.id}");
                                context.read<DrAidCubit>().getDetail(
                                    treatmentPlanId: treatmentPlan.id.toString());
                                treatmentPlanDetails(context, treatmentPlan.id!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 30,
                                  width: 175,
                                  decoration: BoxDecoration(
                                    color: coolOrange,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'البنود العلاجية',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                addNewDetailPlan(context, treatmentPlan.id!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 30,
                                  width: 175,
                                  decoration: BoxDecoration(
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'إضافة بند علاجي',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if(screenWidth>=1450)
                      Positioned(
                        top: 0.0,
                        left: 75,
                        right: 75,
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: coolGreen1,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'غير مكتملة',
                              style: TextStyle(fontSize: 16, color: Colors.white),
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    child: Container(
                      width: 250,
                      height: 230,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: coolBorderColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Cost:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: fontColor2,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${treatmentPlan.totalCost ?? 0}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: fontColor2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Sessions:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: fontColor2,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${treatmentPlan.sessionNumber}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: fontColor2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Discount:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: fontColor2,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${treatmentPlan.discount}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: fontColor2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print("Therapeutic items : ${treatmentPlan.id}");
                              context.read<DrAidCubit>().getDetail(
                                  treatmentPlanId: treatmentPlan.id.toString());
                              treatmentPlanDetails(context, treatmentPlan.id!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 30,
                                width: 175,
                                decoration: BoxDecoration(
                                  color: coolOrange,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Therapeutic items',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              addNewDetailPlan(context, treatmentPlan.id!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 30,
                                width: 175,
                                decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Add item',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(screenWidth>=1450)
                    Positioned(
                      top: 0.0,
                      left: 75,
                      right: 75,
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: coolGreen1,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'Incomplete',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
      else{
        if(languagee=='arabic')
          {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start:10),
                child: Container(
                  width: 250,
                  height: 230,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: coolBorderColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Text(
                              'التكلفة:',
                              style: TextStyle(
                                fontSize: 18,
                                color: fontColor2,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${treatmentPlan.totalCost ?? 0}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: fontColor2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Text(
                              'عدد الجلسات:',
                              style: TextStyle(
                                fontSize: 18,
                                color: fontColor2,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${treatmentPlan.sessionNumber}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: fontColor2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Text(
                              'الحسم:',
                              style: TextStyle(
                                fontSize: 18,
                                color: fontColor2,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${treatmentPlan.discount}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: fontColor2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("البنود العلاجية للخطة : ${treatmentPlan.id}");
                          context.read<DrAidCubit>().getDetail(
                              treatmentPlanId: treatmentPlan.id.toString());
                          treatmentPlanDetails(context, treatmentPlan.id!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 30,
                            width: 175,
                            decoration: BoxDecoration(
                              color: coolOrange,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'البنود العلاجية',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addNewDetailPlan(context, treatmentPlan.id!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 30,
                            width: 175,
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'إضافة بند علاجي',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        else{
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start:10),
              child: Container(
                width: 250,
                height: 230,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: coolBorderColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          const Text(
                            'Cost:',
                            style: TextStyle(
                              fontSize: 18,
                              color: fontColor2,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${treatmentPlan.totalCost ?? 0}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: fontColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          const Text(
                            'Sessions:',
                            style: TextStyle(
                              fontSize: 18,
                              color: fontColor2,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${treatmentPlan.sessionNumber}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: fontColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          const Text(
                            'Discount:',
                            style: TextStyle(
                              fontSize: 18,
                              color: fontColor2,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${treatmentPlan.discount}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: fontColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("Therapeutic items : ${treatmentPlan.id}");
                        context.read<DrAidCubit>().getDetail(
                            treatmentPlanId: treatmentPlan.id.toString());
                        treatmentPlanDetails(context, treatmentPlan.id!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 30,
                          width: 175,
                          decoration: BoxDecoration(
                            color: coolOrange,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'Items',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        addNewDetailPlan(context, treatmentPlan.id!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 30,
                          width: 175,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'Add item',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

      }
    }

    return BlocBuilder<DrAidCubit, DrAidStates>(
      builder: (context, state) {
        List<Datum>? treatmentPlans;
        if (state is DrAidGetAllTreatmentPlansSuccessState) {
          treatmentPlans = state.getAllTreatmentPlanModel.data;
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
                      if (treatmentPlans != null && treatmentPlans.isNotEmpty)
                        Row(
                          children: [
                            Container(
                              width: 800,
                              height: 260,
                              color: Colors.white,
                              child: GridView.count(
                                crossAxisCount: 3,
                                children: List.generate(
                                  treatmentPlans.length,
                                      (index) {
                                    return treatmentPlanItem(treatmentPlans![index]);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      else if (state is DrAidGetAllTreatmentPlansErrorState)
                        const Text(
                          'لا يوجد خطط علاجية بعد',
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
                          addNewTreatmentPlan(context);
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
                                'إضافة خطة علاجية جديدة',
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
                    if (treatmentPlans != null && treatmentPlans.isNotEmpty)
                      Row(
                        children: [
                          Container(
                            width: 800,
                            height: 260,
                            color: Colors.white,
                            child: GridView.count(
                              crossAxisCount: 3,
                              children: List.generate(
                                treatmentPlans.length,
                                    (index) {
                                  return treatmentPlanItem(treatmentPlans![index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (state is DrAidGetAllTreatmentPlansErrorState)
                      const Text(
                        'No plans yet',
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
                        addNewTreatmentPlan(context);
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
                              'Add new plan',
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
        else{
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    if (treatmentPlans != null && treatmentPlans.isNotEmpty)
                      Row(
                        children: [
                          if(screenWidth>=750)
                            Container(
                              width: 300,
                              height: 260,
                              color: Colors.white,
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,  // Makes the list scroll vertically
                                itemCount: treatmentPlans.length,
                                itemBuilder: (context, index) {
                                  return treatmentPlanItem(treatmentPlans![index]);
                                },
                                separatorBuilder: (context, index) => const SizedBox(
                                  height: 10,  // Adds space between list items
                                ),
                              ),
                            ),
                          if(screenWidth<750)
                            Container(
                              width: 200,
                              height: 260,
                              color: Colors.white,
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,  // Makes the list scroll vertically
                                itemCount: treatmentPlans.length,
                                itemBuilder: (context, index) {
                                  return treatmentPlanItem(treatmentPlans![index]);
                                },
                                separatorBuilder: (context, index) => const SizedBox(
                                  height: 10,  // Adds space between list items
                                ),
                              ),
                            ),

                        ],
                      )
                    else if (state is DrAidGetAllTreatmentPlansErrorState)
                      const Text(
                        'لا يوجد خطط بعد',
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
                        addNewTreatmentPlan(context);
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
                              'إضافة خطة جديدة',
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
                  if (treatmentPlans != null && treatmentPlans.isNotEmpty)
                    Row(
                      children: [
                        if(screenWidth>=750)
                          Container(
                            width: 300,
                            height: 260,
                            color: Colors.white,
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,  // Makes the list scroll vertically
                              itemCount: treatmentPlans.length,
                              itemBuilder: (context, index) {
                                return treatmentPlanItem(treatmentPlans![index]);
                              },
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 10,  // Adds space between list items
                              ),
                            ),
                          ),
                        if(screenWidth<750)
                          Container(
                            width: 200,
                            height: 260,
                            color: Colors.white,
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,  // Makes the list scroll vertically
                              itemCount: treatmentPlans.length,
                              itemBuilder: (context, index) {
                                return treatmentPlanItem(treatmentPlans![index]);
                              },
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 10,  // Adds space between list items
                              ),
                            ),
                          ),

                      ],
                    )
                  else if (state is DrAidGetAllTreatmentPlansErrorState)
                    const Text(
                      'No plans yet',
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
                      addNewTreatmentPlan(context);
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
                            'Add new plan',
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
      },
    );
  }
}
