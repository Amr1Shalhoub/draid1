import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
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
    return BlocConsumer<DrAidCubit, DrAidStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Builder(
          builder: (context) {
            if(languagee=='arabic')
              {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        MyDatePicker(
                          title: 'من تاريخ',
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
                        MyDatePicker(
                          title: 'إلى تاريخ',
                          initialDate: DateTime.now(),
                          onDateChanged: _onToDateChanged,
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.buttonColor,
                          ),
                          // ButtonStyle(
                          //   backgroundColor: WidgetStateProperty.all<Color>(coolGreen1),
                          // ),
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
                              DrAidCubit.get(context).expenseFunction(
                                startDate: fromDateString!,
                                endDate: toDateString!,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        // Container(
                        //   width: MediaQuery.of(context).size.width * 0.55,
                        //   height: 200,
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: borderColor,
                        //       width: 2,
                        //     ),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: const Column(
                        //     children: [
                        //       SizedBox(height: 10),
                        //       Padding(
                        //         padding: EdgeInsets.all(8.0),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               'الإجمالي',
                        //               style: TextStyle(
                        //                 fontSize: 18,
                        //                 color: fontColor2,
                        //               ),
                        //             ),
                        //             Text(
                        //               '800.000 ل.س',
                        //               style: TextStyle(
                        //                 fontSize: 18,
                        //                 color: fontColor2,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Divider(
                        //         color: fontColor2,
                        //       ),
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Padding(
                        //         padding: EdgeInsets.all(8.0),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               'المدفوع',
                        //               style: TextStyle(
                        //                 fontSize: 18,
                        //                 color: fontColor2,
                        //               ),
                        //             ),
                        //             Text(
                        //               '200.000 ل.س',
                        //               style: TextStyle(
                        //                 fontSize: 18,
                        //                 color: fontColor2,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Divider(
                        //         color: fontColor2,
                        //       ),
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Padding(
                        //         padding: EdgeInsets.all(8.0),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               'الباقي',
                        //               style: TextStyle(
                        //                 fontSize: 18,
                        //                 color: fontColor2,
                        //               ),
                        //             ),
                        //             Text(
                        //               '600.000 ل.س',
                        //               style: TextStyle(
                        //                 fontSize: 18,
                        //                 color: blueText,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

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
                              if (state is DrAidExpenseLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              else if (
                              state is DrAidExpenseSuccessState&&
                                  DrAidCubit.get(context).expenseModel?.data.remainingAmount==0&&
                                  DrAidCubit.get(context).expenseModel?.data.totalPaidAmount==0&&
                                  DrAidCubit.get(context).expenseModel?.data.totalRevenue==0
                              )
                              {
                                return  const Center(
                                  child: Text(
                                    'لا يوجد مصاريف لعرضها ضمن هذا التاريخ ',
                                    style: TextStyle(fontSize: 20, color: Colors.grey),
                                  ),
                                );
                              }



                              else if (
                              state is DrAidExpenseSuccessState
                              // DrAidCubit.get(context).expenseModel?.data.remainingAmount!=0&&
                              // DrAidCubit.get(context).expenseModel?.data.totalPaidAmount!=0&&
                              // DrAidCubit.get(context).expenseModel?.data.totalRevenue!=0
                              ) {
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
                                            '${DrAidCubit.get(context).expenseModel?.data.totalRevenue} ل.س ',
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
                                            '${DrAidCubit.get(context).expenseModel?.data.totalPaidAmount} ل.س  ',
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
                                            '${DrAidCubit.get(context).expenseModel?.data.remainingAmount} ل.س ',
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
                                    'اختر التاريخ لعرض المصاريف ',
                                    style: TextStyle(fontSize: 20, color: Colors.grey),
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
                                //             '800.000 ل.س',
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
                                //             '200.000 ل.س',
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
                                //             '600.000 ل.س',
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
                    )
                  ],
                );
              }
            else{
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      MyDatePicker(
                        title: 'From',
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
                      MyDatePicker(
                        title: 'To',
                        initialDate: DateTime.now(),
                        onDateChanged: _onToDateChanged,
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.buttonColor,
                        ),
                        // ButtonStyle(
                        //   backgroundColor: WidgetStateProperty.all<Color>(coolGreen1),
                        // ),
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
                            DrAidCubit.get(context).expenseFunction(
                              startDate: fromDateString!,
                              endDate: toDateString!,
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
                  const SizedBox(
                    height: 20,
                  ),
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
                            if (state is DrAidExpenseLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            else if (
                            state is DrAidExpenseSuccessState&&
                                DrAidCubit.get(context).expenseModel?.data.remainingAmount==0&&
                                DrAidCubit.get(context).expenseModel?.data.totalPaidAmount==0&&
                                DrAidCubit.get(context).expenseModel?.data.totalRevenue==0
                            )
                            {
                              return  const Center(
                                child: Text(
                                  'No expenses in this date',
                                  style: TextStyle(fontSize: 20, color: Colors.grey),
                                ),
                              );
                            }



                            else if (
                            state is DrAidExpenseSuccessState
                            // DrAidCubit.get(context).expenseModel?.data.remainingAmount!=0&&
                            // DrAidCubit.get(context).expenseModel?.data.totalPaidAmount!=0&&
                            // DrAidCubit.get(context).expenseModel?.data.totalRevenue!=0
                            ) {
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
                                          '${DrAidCubit.get(context).expenseModel?.data.totalRevenue} ل.س ',
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
                                          '${DrAidCubit.get(context).expenseModel?.data.totalPaidAmount} ل.س  ',
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
                                          '${DrAidCubit.get(context).expenseModel?.data.remainingAmount} ل.س ',
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
                                  'Choose date ',
                                  style: TextStyle(fontSize: 20, color: Colors.grey),
                                ),
                              );


                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              );
            }

          }
        );
      },
    );
  }
}
