import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TreatmentsInformation extends StatelessWidget {
  final TextEditingController patientName = TextEditingController();
  final TextEditingController patientAge = TextEditingController();
  final TextEditingController patientAddress = TextEditingController();
  final TextEditingController patientPhoneNumber = TextEditingController();

  TreatmentsInformation({super.key});

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
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 175.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 450,
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
                                  DrAidCubit.get(context).changeTreatmentIndex(0);
                                },
                                child: DrAidCubit.get(context).treatmentindex == 0
                                    ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if(screenWidth>=750)
                                      const Text(
                                        'الخطط العلاجية',
                                        style: TextStyle(
                                            fontSize: 20, color: fontColor4),
                                      ),
                                    if(screenWidth<750)
                                      const Text(
                                        'الخطط',
                                        style: TextStyle(
                                            fontSize: 14, color: fontColor4),
                                      ),
                                    if(screenWidth>=750)
                                      Container(
                                        width: 120,
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
                                      ),
                                    if(screenWidth<750)
                                      Container(
                                        width: 60,
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
                                      ),
                                  ],
                                )
                                    : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if(screenWidth>=750)
                                      const Text(
                                        'الخطط العلاجية',
                                        style: TextStyle(
                                            fontSize: 20, color: fontColor3),
                                      ),
                                    if(screenWidth<750)
                                      const Text(
                                        'الخطط',
                                        style: TextStyle(
                                            fontSize: 14, color: fontColor3),
                                      ),
                                    if(screenWidth>=750)
                                      Container(
                                        width: 120,
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
                                      ),
                                    if(screenWidth<750)
                                      Container(
                                        width: 60,
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
                                      ),
                                  ],
                                ),
                              ),
                              if(screenWidth>=750)
                                const SizedBox(
                                  width: 30,
                                ),
                              if(screenWidth<750)
                                const SizedBox(
                                  width: 10,
                                ),
                              InkWell(
                                onTap: () {
                                  DrAidCubit.get(context).changeTreatmentIndex(1);
                                },
                                child: DrAidCubit.get(context).treatmentindex == 1
                                    ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if(screenWidth>=750)
                                      const Text(
                                        'علاجات مكتملة',
                                        style: TextStyle(
                                            fontSize: 20, color: fontColor4),
                                      ),
                                    if(screenWidth<750)
                                      const Text(
                                        'علاجات',
                                        style: TextStyle(
                                            fontSize: 14, color: fontColor4),
                                      ),
                                    if(screenWidth>=750)
                                      Container(
                                        width: 120,
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
                                      ),
                                    if(screenWidth<750)
                                      Container(
                                        width: 60,
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
                                      ),
                                  ],
                                )
                                    : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if(screenWidth>=750)
                                      const Text(
                                        'علاجات مكتملة',
                                        style: TextStyle(
                                            fontSize: 20, color: fontColor3),
                                      ),
                                    if(screenWidth<750)
                                      const Text(
                                        'علاجات',
                                        style: TextStyle(
                                            fontSize: 14, color: fontColor3),
                                      ),
                                    if(screenWidth<750)
                                      Container(
                                        width: 60,
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
                          DrAidCubit.get(context).treatmentsScreens[
                          DrAidCubit.get(context).treatmentindex],
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
                  height: 450,
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
                                DrAidCubit.get(context).changeTreatmentIndex(0);
                              },
                              child: DrAidCubit.get(context).treatmentindex == 0
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if(screenWidth>=750)
                                    const Text(
                                      'Treatment plans',
                                      style: TextStyle(
                                          fontSize: 20, color: fontColor4),
                                    ),
                                  if(screenWidth<750)
                                    const Text(
                                      'Plans',
                                      style: TextStyle(
                                          fontSize: 14, color: fontColor4),
                                    ),
                                  if(screenWidth>=750)
                                    Container(
                                      width: 120,
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
                                    ),
                                  if(screenWidth<750)
                                    Container(
                                      width: 60,
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
                                    ),
                                ],
                              )
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if(screenWidth>=750)
                                    const Text(
                                      'Treatment plans',
                                      style: TextStyle(
                                          fontSize: 20, color: fontColor3),
                                    ),
                                  if(screenWidth<750)
                                    const Text(
                                      'Plans',
                                      style: TextStyle(
                                          fontSize: 14, color: fontColor3),
                                    ),
                                  if(screenWidth>=750)
                                    Container(
                                      width: 120,
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
                                    ),
                                  if(screenWidth<750)
                                    Container(
                                      width: 60,
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
                                    ),
                                ],
                              ),
                            ),
                            if(screenWidth>=750)
                              const SizedBox(
                                width: 30,
                              ),
                            if(screenWidth<750)
                              const SizedBox(
                                width: 10,
                              ),
                            InkWell(
                              onTap: () {
                                DrAidCubit.get(context).changeTreatmentIndex(1);
                              },
                              child: DrAidCubit.get(context).treatmentindex == 1
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if(screenWidth>=900)
                                    const Text(
                                      'Full treatments',
                                      style: TextStyle(
                                          fontSize: 20, color: fontColor4),
                                    ),
                                  if(screenWidth<900)
                                    const Text(
                                      'treatments',
                                      style: TextStyle(
                                          fontSize: 14, color: fontColor4),
                                    ),
                                  if(screenWidth>=900)
                                    Container(
                                      width: 120,
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
                                    ),
                                  if(screenWidth<900)
                                    Container(
                                      width: 60,
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
                                    ),
                                ],
                              )
                                  : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if(screenWidth>=900)
                                    const Text(
                                      'Full treatments',
                                      style: TextStyle(
                                          fontSize: 20, color: fontColor3),
                                    ),
                                  if(screenWidth<900)
                                    const Text(
                                      'treatments',
                                      style: TextStyle(
                                          fontSize: 14, color: fontColor3),
                                    ),
                                  if(screenWidth<900)
                                    Container(
                                      width: 60,
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
                        DrAidCubit.get(context).treatmentsScreens[
                        DrAidCubit.get(context).treatmentindex],
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
