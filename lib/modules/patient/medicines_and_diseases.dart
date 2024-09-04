import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicinesAndDiseases extends StatelessWidget {
  final TextEditingController patientName = TextEditingController();
  final TextEditingController patientAge = TextEditingController();
  final TextEditingController patientAddress = TextEditingController();
  final TextEditingController patientPhoneNumber = TextEditingController();

  MedicinesAndDiseases({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DrAidCubit, DrAidStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 175.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  DrAidCubit.get(context).changeMedicineIndex(0);
                                },
                                child: DrAidCubit.get(context).medicineindex == 0
                                    ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'الأدوية',
                                      style: TextStyle(
                                          fontSize: 20, color: fontColor4),
                                    ),
                                    Container(
                                      width: 90,
                                      height: 3,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            linearGradiant1,
                                            linearGradiant2,
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                                    : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'الأدوية',
                                      style: TextStyle(
                                          fontSize: 20, color: fontColor3),
                                    ),
                                    Container(
                                      width: 90,
                                      height: 3,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.white,
                                            Colors.white,
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  DrAidCubit.get(context).changeMedicineIndex(1);
                                },
                                child: DrAidCubit.get(context).medicineindex == 1
                                    ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'الأمراض',
                                      style: TextStyle(
                                          fontSize: 20, color: fontColor4),
                                    ),
                                    Container(
                                      width: 90,
                                      height: 3,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            linearGradiant1,
                                            linearGradiant2,
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                                    : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'الأمراض',
                                      style: TextStyle(
                                          fontSize: 20, color: fontColor3),
                                    ),
                                    Container(
                                      width: 90,
                                      height: 3,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.white,
                                            Colors.white,
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          DrAidCubit.get(context).medicineanddiseasescreen[
                          DrAidCubit.get(context).medicineindex],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          else{
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 175.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                DrAidCubit.get(context).changeMedicineIndex(0);
                              },
                              child: DrAidCubit.get(context).medicineindex == 0
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Meds',
                                    style: TextStyle(
                                        fontSize: 20, color: fontColor4),
                                  ),
                                  Container(
                                    width: 90,
                                    height: 3,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          linearGradiant1,
                                          linearGradiant2,
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Meds',
                                    style: TextStyle(
                                        fontSize: 20, color: fontColor3),
                                  ),
                                  Container(
                                    width: 90,
                                    height: 3,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white,
                                          Colors.white,
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () {
                                DrAidCubit.get(context).changeMedicineIndex(1);
                              },
                              child: DrAidCubit.get(context).medicineindex == 1
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'diseases',
                                    style: TextStyle(
                                        fontSize: 20, color: fontColor4),
                                  ),
                                  Container(
                                    width: 90,
                                    height: 3,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          linearGradiant1,
                                          linearGradiant2,
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'diseases',
                                    style: TextStyle(
                                        fontSize: 20, color: fontColor3),
                                  ),
                                  Container(
                                    width: 90,
                                    height: 3,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white,
                                          Colors.white,
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        DrAidCubit.get(context).medicineanddiseasescreen[
                        DrAidCubit.get(context).medicineindex],
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

        });
  }
}
