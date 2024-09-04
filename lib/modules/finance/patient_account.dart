// ignore_for_file: use_build_context_synchronously

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientAccount extends StatelessWidget {
  const PatientAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    return BlocConsumer<DrAidCubit, DrAidStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Builder(
            builder: (context) {
              if(languagee=='arabic')
                {
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(end: 40.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 450,
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Builder(
                                builder: (context) {
                                  if(screenWidth<1000)
                                  {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                DrAidCubit.get(context)
                                                    .changePatineAccountIndex(0);
                                              },
                                              child:
                                              DrAidCubit.get(context).patientAccountIndex ==
                                                  0
                                                  ? Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'حسابات',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: fontColor4),
                                                  ),
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
                                                  )
                                                ],
                                              )
                                                  : Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'حسابات',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: fontColor3),
                                                  ),
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
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                DrAidCubit.get(context)
                                                    .changePatineAccountIndex(1);
                                              },
                                              child:
                                              DrAidCubit.get(context).patientAccountIndex ==
                                                  1
                                                  ? Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'إيرادات',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: fontColor4),
                                                  ),
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
                                                  )
                                                ],
                                              )
                                                  : Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'إيرادات',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: fontColor3),
                                                  ),
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
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () //async
                                              {
                                                 DrAidCubit.get(context).getPatientDebts();
                                                DrAidCubit.get(context)
                                                    .changePatineAccountIndex(2);
                                              },
                                              child:
                                              DrAidCubit.get(context).patientAccountIndex ==
                                                  2
                                                  ? Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'ديون',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: fontColor4),
                                                  ),
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
                                                  )
                                                ],
                                              )
                                                  : Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'ديون',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: fontColor3),
                                                  ),
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
                                        // if (DrAidCubit.get(context).patientAccountIndex == 0 ||
                                        //     DrAidCubit.get(context).patientAccountIndex == 2)
                                        //   Flexible(
                                        //     child: SizedBox(
                                        //       width: 200,
                                        //       child: CustomSearchField(
                                        //         icon: Icons.search,
                                        //         hintText: 'بحث عن مريض',
                                        //         controller: TextEditingController(),
                                        //       ),
                                        //     ),
                                        //   ),
                                      ],
                                    );
                                  }
                                  else{
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                DrAidCubit.get(context)
                                                    .changePatineAccountIndex(0);
                                              },
                                              child:
                                              DrAidCubit.get(context).patientAccountIndex ==
                                                  0
                                                  ? Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'كامل الحسابات',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: fontColor4),
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
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'كامل الحسابات',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: fontColor3),
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
                                                DrAidCubit.get(context)
                                                    .changePatineAccountIndex(1);
                                              },
                                              child:
                                              DrAidCubit.get(context).patientAccountIndex ==
                                                  1
                                                  ? Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'حساب الإيرادات',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: fontColor4),
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
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'حساب الإيرادات',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: fontColor3),
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
                                              onTap: () //async
                                              {
                                                 DrAidCubit.get(context).getPatientDebts();
                                                DrAidCubit.get(context)
                                                    .changePatineAccountIndex(2);
                                              },
                                              child:
                                              DrAidCubit.get(context).patientAccountIndex ==
                                                  2
                                                  ? Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'المرضى الذين عليهم ديون',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: fontColor4),
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
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'المرضى الذين عليهم ديون',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: fontColor3),
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
                                        // if (DrAidCubit.get(context).patientAccountIndex == 0 ||
                                        //     DrAidCubit.get(context).patientAccountIndex == 2)
                                        //   Flexible(
                                        //     child: SizedBox(
                                        //       width: 200,
                                        //       child: CustomSearchField(
                                        //         icon: Icons.search,
                                        //         hintText: 'بحث عن مريض',
                                        //         controller: TextEditingController(),
                                        //       ),
                                        //     ),
                                        //   ),
                                      ],
                                    );
                                  }

                                }
                            ),

                            DrAidCubit.get(context).accountAndRevenues[
                            DrAidCubit.get(context).patientAccountIndex],
                            // buildMedicineItem(context),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              else{
                return Padding(
                  padding: const EdgeInsetsDirectional.only(end: 40.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 450,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Builder(
                              builder: (context) {
                                if(screenWidth<1000)
                                {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              DrAidCubit.get(context)
                                                  .changePatineAccountIndex(0);
                                            },
                                            child:
                                            DrAidCubit.get(context).patientAccountIndex ==
                                                0
                                                ? Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Accounts',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: fontColor4),
                                                ),
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
                                                )
                                              ],
                                            )
                                                : Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Accounts',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: fontColor3),
                                                ),
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
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              DrAidCubit.get(context)
                                                  .changePatineAccountIndex(1);
                                            },
                                            child:
                                            DrAidCubit.get(context).patientAccountIndex ==
                                                1
                                                ? Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Revenue',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: fontColor4),
                                                ),
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
                                                )
                                              ],
                                            )
                                                : Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Revenue',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: fontColor3),
                                                ),
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
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: ()// async
                                            {
                                               DrAidCubit.get(context).getPatientDebts();
                                              DrAidCubit.get(context)
                                                  .changePatineAccountIndex(2);
                                            },
                                            child:
                                            DrAidCubit.get(context).patientAccountIndex ==
                                                2
                                                ? Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Debts',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: fontColor4),
                                                ),
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
                                                )
                                              ],
                                            )
                                                : Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Debts',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: fontColor3),
                                                ),
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
                                      // if (DrAidCubit.get(context).patientAccountIndex == 0 ||
                                      //     DrAidCubit.get(context).patientAccountIndex == 2)
                                      //   Flexible(
                                      //     child: SizedBox(
                                      //       width: 200,
                                      //       child: CustomSearchField(
                                      //         icon: Icons.search,
                                      //         hintText: 'بحث عن مريض',
                                      //         controller: TextEditingController(),
                                      //       ),
                                      //     ),
                                      //   ),
                                    ],
                                  );
                                }
                                else{
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              DrAidCubit.get(context)
                                                  .changePatineAccountIndex(0);
                                            },
                                            child:
                                            DrAidCubit.get(context).patientAccountIndex ==
                                                0
                                                ? Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'All accounts',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: fontColor4),
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
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'All accounts',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: fontColor3),
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
                                              DrAidCubit.get(context)
                                                  .changePatineAccountIndex(1);
                                            },
                                            child:
                                            DrAidCubit.get(context).patientAccountIndex ==
                                                1
                                                ? Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Revenue',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: fontColor4),
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
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Revenue',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: fontColor3),
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
                                            onTap: () //async
                                            {

                                              DrAidCubit.get(context).getPatientDebts();
                                              DrAidCubit.get(context)
                                                  .changePatineAccountIndex(2);
                                            },
                                            child:
                                            DrAidCubit.get(context).patientAccountIndex ==
                                                2
                                                ? Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Debts',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: fontColor4),
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
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Debts',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: fontColor3),
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

                                    ],
                                  );
                                }

                              }
                          ),

                          DrAidCubit.get(context).accountAndRevenues[
                          DrAidCubit.get(context).patientAccountIndex],
                          // buildMedicineItem(context),
                        ],
                      ),
                    ),
                  ),
                );
              }

            }
          );
        });
  }
}
