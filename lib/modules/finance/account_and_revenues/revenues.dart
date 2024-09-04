import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/network/local/cache_helper.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Revenues extends StatefulWidget {
  const Revenues({super.key});

  @override
  State<Revenues> createState() => _RevenuesState();
}

class _RevenuesState extends State<Revenues> {
  DateTime? fromDate;
  DateTime? toDate;
  String? fromDateString;
  String? toDateString;

  void _onFromDateChanged(DateTime date) {
    setState(() {
      fromDate = date;
    });
  }

  void _onToDateChanged(DateTime date) {
    setState(() {
      toDate = date;
    });
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
        return Builder(
          builder: (context) {
            if(languagee=='arabic')
              {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        MyDatePicker(
                          title: 'من تاريخ',
                          initialDate: DateTime.now(),
                          onDateChanged: _onFromDateChanged,
                        ),
                        if(screenWidth>=800)
                          const SizedBox(width: 20),
                        if(screenWidth>=800)
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
                        MyDatePicker(
                          title: 'إلى تاريخ',
                          initialDate: DateTime.now(),
                          onDateChanged: _onToDateChanged,
                        ),
                        if(screenWidth>=800)
                          const SizedBox(width: 20),
                        if(screenWidth<800)
                          const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.buttonColor,
                          ),
                          onPressed: () {
                            if (fromDate != null && toDate != null) {
                              fromDateString = fromDate!.toIso8601String();
                              toDateString = toDate!.toIso8601String();
                              print('From: $fromDateString, To: $toDateString');
                              // Add your logic to use the date strings
                            } else {
                              print('Please select both dates.');
                            }
                            if (fromDateString != null && toDateString != null) {
                              int? clinicId = CacheHelper.getData(key: 'id');
                              DrAidCubit.get(context).revenuFunction(
                                clinicId: clinicId!,
                                startDate: fromDateString!,
                                endDate: toDateString!,
                                token: CacheHelper.getData(key: 'token'),
                                //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiZnVsbE5hbWUiOiJhYWFhYdij2K3ZhdivINi02YrYriDYp9mE2LTYqNin2KgiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3MTg4MTgzNDJ9.Xm9JqTT-dr0UW9K1VyRHtFe1k2V0mZCXgjO0krZQiqQ',
                              );
                            }
                          },
                          child: const Text(
                            "تم",
                            style: TextStyle(color: white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Builder(
                            builder: (context) {
                              if (state is DrAidRevenuLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if(state is DrAidRevenuSuccessState&&
                                  DrAidCubit.get(context).revenuModel?.data.totalRevenue==0&&
                                  DrAidCubit.get(context).revenuModel?.data.totalPaidAmount==0&&
                                  DrAidCubit.get(context).revenuModel?.data.remainingAmount==0
                              )
                              {
                                return const Center(
                                  child: Text(
                                    'لا يوجد إيرادات ضمن هذا التاريخ لعرضها',
                                    style: TextStyle(fontSize: 24, color: Colors.grey),
                                  ),
                                );
                              }

                              else if (state is DrAidRevenuSuccessState) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'الإجمالي',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: fontColor2,
                                            ),
                                          ),
                                          Text(
                                            '${DrAidCubit.get(context).revenuModel?.data.totalRevenue} ل.س ',
                                            // '800.000 ل.س',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: fontColor2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Divider(color: fontColor2),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'المدفوع',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: fontColor2,
                                            ),
                                          ),
                                          Text(
                                            '${DrAidCubit.get(context).revenuModel?.data.totalPaidAmount} ل.س  ',
                                            // '200.000 ل.س',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: fontColor2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Divider(color: fontColor2),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'الباقي',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: fontColor2,
                                            ),
                                          ),
                                          Text(
                                            '${DrAidCubit.get(context).revenuModel?.data.remainingAmount} ل.س ',
                                            //'600.000 ل.س',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: blueText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {


                                return const Center(
                                  child: Text(
                                    'اختر التاريخ لعرض الايرادات',
                                    style: TextStyle(fontSize: 24, color: Colors.grey),
                                  ),
                                );

                                // return const Column(
                                //   children: [
                                //     SizedBox(height: 10),
                                //     Padding(
                                //       padding: EdgeInsets.all(8.0),
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Text(
                                //             'الإجمالي',
                                //             style: TextStyle(
                                //               fontSize: 18,
                                //               color: fontColor2,
                                //             ),
                                //           ),
                                //           Text(
                                //             // '${DrAidCubit.get(context).revenuModel?.data.totalRevenue}ل.س ',
                                //             ' ل.س',
                                //             style: TextStyle(
                                //               fontSize: 18,
                                //               color: fontColor2,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //     SizedBox(height: 5),
                                //     Divider(color: fontColor2),
                                //     SizedBox(height: 5),
                                //     Padding(
                                //       padding: EdgeInsets.all(8.0),
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Text(
                                //             'المدفوع',
                                //             style: TextStyle(
                                //               fontSize: 18,
                                //               color: fontColor2,
                                //             ),
                                //           ),
                                //           Text(
                                //             // '${DrAidCubit.get(context).revenuModel?.data.totalPaidAmount}ل.س ',
                                //             ' ل.س',
                                //             style: TextStyle(
                                //               fontSize: 18,
                                //               color: fontColor2,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //     SizedBox(height: 5),
                                //     Divider(color: fontColor2),
                                //     SizedBox(height: 5),
                                //     Padding(
                                //       padding: EdgeInsets.all(8.0),
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Text(
                                //             'الباقي',
                                //             style: TextStyle(
                                //               fontSize: 18,
                                //               color: fontColor2,
                                //             ),
                                //           ),
                                //           Text(
                                //             // '${DrAidCubit.get(context).revenuModel?.data.remainingAmount}ل.س ',
                                //             ' ل.س',
                                //             style: TextStyle(
                                //               fontSize: 18,
                                //               color: blueText,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            else{
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      MyDatePicker(
                        title: 'From',
                        initialDate: DateTime.now(),
                        onDateChanged: _onFromDateChanged,
                      ),
                      if(screenWidth>=800)
                        const SizedBox(width: 20),
                      if(screenWidth>=800)
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
                      MyDatePicker(
                        title: 'To',
                        initialDate: DateTime.now(),
                        onDateChanged: _onToDateChanged,
                      ),
                      if(screenWidth>=800)
                        const SizedBox(width: 20),
                      if(screenWidth<800)
                        const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.buttonColor,
                        ),
                        onPressed: () {
                          if (fromDate != null && toDate != null) {
                            fromDateString = fromDate!.toIso8601String();
                            toDateString = toDate!.toIso8601String();
                            print('From: $fromDateString, To: $toDateString');
                            // Add your logic to use the date strings
                          } else {
                            print('Please select both dates.');
                          }
                          if (fromDateString != null && toDateString != null) {
                            int? clinicId = CacheHelper.getData(key: 'id');
                            DrAidCubit.get(context).revenuFunction(
                              clinicId: clinicId!,
                              startDate: fromDateString!,
                              endDate: toDateString!,
                              token: CacheHelper.getData(key: 'token'),
                              //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiZnVsbE5hbWUiOiJhYWFhYdij2K3ZhdivINi02YrYriDYp9mE2LTYqNin2KgiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3MTg4MTgzNDJ9.Xm9JqTT-dr0UW9K1VyRHtFe1k2V0mZCXgjO0krZQiqQ',
                            );
                          }
                        },
                        child: const Text(
                          "Ok",
                          style: TextStyle(color: white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Builder(
                          builder: (context) {
                            if (state is DrAidRevenuLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if(state is DrAidRevenuSuccessState&&
                                DrAidCubit.get(context).revenuModel?.data.totalRevenue==0&&
                                DrAidCubit.get(context).revenuModel?.data.totalPaidAmount==0&&
                                DrAidCubit.get(context).revenuModel?.data.remainingAmount==0
                            )
                            {
                              return const Center(
                                child: Text(
                                  'No revenues between these dates',
                                  style: TextStyle(fontSize: 24, color: Colors.grey),
                                ),
                              );
                            }

                            else if (state is DrAidRevenuSuccessState) {
                              return Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'All',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: fontColor2,
                                          ),
                                        ),
                                        Text(
                                          '${DrAidCubit.get(context).revenuModel?.data.totalRevenue} ل.س ',
                                          // '800.000 ل.س',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: fontColor2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Divider(color: fontColor2),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Paid',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: fontColor2,
                                          ),
                                        ),
                                        Text(
                                          '${DrAidCubit.get(context).revenuModel?.data.totalPaidAmount} ل.س  ',
                                          // '200.000 ل.س',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: fontColor2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Divider(color: fontColor2),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Remaining',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: fontColor2,
                                          ),
                                        ),
                                        Text(
                                          '${DrAidCubit.get(context).revenuModel?.data.remainingAmount} ل.س ',
                                          //'600.000 ل.س',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: blueText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {


                              return const Center(
                                child: Text(
                                  'Choose date',
                                  style: TextStyle(fontSize: 24, color: Colors.grey),
                                ),
                              );

                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

          }
        );
      },
    );
  }
}
