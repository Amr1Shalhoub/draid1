import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncompleteBill extends StatefulWidget {
  const IncompleteBill({super.key});

  @override
  State<IncompleteBill> createState() => _IncompleteBillState();
}

class _IncompleteBillState extends State<IncompleteBill> {
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
                      const SizedBox(
                        height: 15,
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
                                DrAidCubit.get(context).inCompleteBills(
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
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 50.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 240,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              if(screenWidth>1530)
                                const Padding(
                                  padding: EdgeInsetsDirectional.only(start: 10),
                                  child: Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        'المعرف',
                                        style: TextStyle(fontSize: 18, color: fontColor),
                                      ),
                                      SizedBox(
                                        width: 165,
                                      ),
                                      Text(
                                        'دفعة',
                                        style: TextStyle(fontSize: 18, color: fontColor),
                                      ),
                                      SizedBox(
                                        width: 155,
                                      ),
                                      Text(
                                        'الفاتورة',
                                        style: TextStyle(fontSize: 18, color: fontColor),
                                      ),
                                      SizedBox(
                                        width: 205,
                                      ),
                                      Text(
                                        'التاريخ',
                                        style: TextStyle(fontSize: 18, color: fontColor),
                                      ),
                                      SizedBox(
                                        width: 125,
                                      ),
                                      Text(
                                        'الخيارات',
                                        style: TextStyle(fontSize: 18, color: fontColor),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              if(screenWidth>1470)
                                Row(
                                  children: [
                                    Container(
                                      width: 900,
                                      height: 1,
                                      color: dividerColor,
                                    ),
                                  ],
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              // if(state is DrAidIncompleteBillsSuccessState)

                              Builder(
                                builder: (context) {
                                  if(
                                  state is DrAidIncompleteBillsSuccessState&&
                                      // DrAidCubit.get(context).incompleteBillsModel!.
                                      DrAidCubit.get(context).incompleteBillsModel!.data.isEmpty
                                  )
                                  {
                                    return

                                      const Center(
                                        child: Text(
                                          'لا يوجد فواتير غير مكتملة في هذا التاريخ',
                                          style:  TextStyle(
                                              fontSize: 20, color: Colors.grey),
                                        ),
                                      );

                                  }


                                  if (state is DrAidIncompleteBillsSuccessState&&DrAidCubit.get(context).incompleteBillsModel!.data.isNotEmpty) {
                                    return Expanded(
                                      child:

                                      ListView.separated(
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsetsDirectional.only(
                                                start: 10),
                                            child: Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                if(screenWidth>1460)
                                                  const SizedBox(
                                                    width: 80,
                                                  ),
                                                if(screenWidth>1460)
                                                  Expanded(
                                                    child: Text(
                                                      //  '1',
                                                      '${DrAidCubit.get(context).incompleteBillsModel?.data[index].id.toString()}',
                                                      style: const TextStyle(
                                                          fontSize: 16, color: fontColor),
                                                    ),
                                                  ),
                                                if(screenWidth>1460)
                                                  const SizedBox(
                                                    width: 100,
                                                  ),
                                                Expanded(
                                                  child: Text(
                                                    '${DrAidCubit.get(context).incompleteBillsModel?.data[index].total.toString()}',
                                                    // '200,000 ل.س',
                                                    style: const TextStyle(
                                                        fontSize: 16, color: fontColor),
                                                  ),
                                                ),
                                                if(screenWidth>1460)
                                                  const SizedBox(
                                                    width: 100,
                                                  ),
                                                if(screenWidth>=1005)
                                                  Expanded(
                                                    child: Text(
                                                      '${DrAidCubit.get(context).incompleteBillsModel?.data[index].id.toString()}',
                                                      // '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].billId}',
                                                      // '134',
                                                      style: const TextStyle(
                                                          fontSize: 16, color: fontColor),
                                                    ),
                                                  ),
                                                const SizedBox(
                                                  width: 120,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    // '20-8-2024',
                                                    '${DrAidCubit.get(context).incompleteBillsModel?.data[index].createdAt.toString().substring(0, 10)}',
                                                    style: const TextStyle(
                                                        fontSize: 16, color: fontColor),
                                                  ),
                                                ),
                                                if(screenWidth>=1005)
                                                  const SizedBox(
                                                    width: 100,
                                                  ),
                                                if(screenWidth>=1005)
                                                  Container(
                                                    width: 70,
                                                    height: 40,
                                                    color: Colors.white,
                                                    child: const Center(
                                                      child: Row(
                                                        children: [
                                                          Image(
                                                            image: AssetImage(
                                                              'images/edit1.png',
                                                            ),
                                                            width: 25,
                                                            height: 25,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Image(
                                                            image: AssetImage(
                                                              'images/delete.png',
                                                            ),
                                                            width: 30,
                                                            height: 30,
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
                                          return const Divider(
                                            color: borderColor,
                                          );
                                        },
                                        itemCount:
                                        //30,
                                        DrAidCubit.get(context)
                                            .incompleteBillsModel!
                                            .data
                                            .length,
                                      ),
                                    );
                                  } else if (state is DrAidIncompleteBillsErrorState) {
                                    return const Center(
                                        child: Text('Something went wrong'));
                                  } else if (state
                                  is DrAidIncompleteBillsLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return const Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Text(
                                            'اختر التاريخ لعرض الفواتير غير المكتملة',
                                            style: TextStyle(
                                                fontSize: 20, color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    );

                                    // return Expanded(
                                    //   child:
                                    //       // ListView.separated(
                                    //       //     itemBuilder: (context, index) {
                                    //       //       return Padding(
                                    //       //         padding: const EdgeInsetsDirectional.only(start: 10),
                                    //       //         child: Row(
                                    //       //           //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //       //           children: [
                                    //       //             const SizedBox(
                                    //       //               width: 80,
                                    //       //             ),
                                    //       //             const Text(
                                    //       //               '1',
                                    //       //               style:
                                    //       //                   TextStyle(fontSize: 16, color: fontColor),
                                    //       //             ),
                                    //       //             const SizedBox(
                                    //       //               width: 100,
                                    //       //             ),
                                    //       //             const Text(
                                    //       //               '200,000 ل.س',
                                    //       //               style:
                                    //       //                   TextStyle(fontSize: 16, color: fontColor),
                                    //       //             ),
                                    //       //             const SizedBox(
                                    //       //               width: 100,
                                    //       //             ),
                                    //       //             const Text(
                                    //       //               '134',
                                    //       //               style:
                                    //       //                   TextStyle(fontSize: 16, color: fontColor),
                                    //       //             ),
                                    //       //             const SizedBox(
                                    //       //               width: 120,
                                    //       //             ),
                                    //       //             const Text(
                                    //       //               '20-8-2024',
                                    //       //               style:
                                    //       //                   TextStyle(fontSize: 16, color: fontColor),
                                    //       //             ),
                                    //       //             const SizedBox(
                                    //       //               width: 100,
                                    //       //             ),
                                    //       //             Container(
                                    //       //               width: 70,
                                    //       //               height: 40,
                                    //       //               color: Colors.white,
                                    //       //               child: const Center(
                                    //       //                 child: Row(
                                    //       //                   children: [
                                    //       //                     Image(
                                    //       //                       image: AssetImage(
                                    //       //                         'images/edit1.png',
                                    //       //                       ),
                                    //       //                       width: 25,
                                    //       //                       height: 25,
                                    //       //                     ),
                                    //       //                     SizedBox(
                                    //       //                       width: 10,
                                    //       //                     ),
                                    //       //                     Image(
                                    //       //                       image: AssetImage(
                                    //       //                         'images/delete.png',
                                    //       //                       ),
                                    //       //                       width: 30,
                                    //       //                       height: 30,
                                    //       //                     ),
                                    //       //                   ],
                                    //       //                 ),
                                    //       //               ),
                                    //       //             ),
                                    //       //           ],
                                    //       //         ),
                                    //       //       );
                                    //       //     },
                                    //       //     separatorBuilder: (context, index) {
                                    //       //       return const Divider(
                                    //       //         color: borderColor,
                                    //       //       );
                                    //       //     },
                                    //       //     itemCount: 30),
                                    //
                                    //       ListView.separated(
                                    //     itemBuilder: (context, index) {
                                    //       return Padding(
                                    //         padding: const EdgeInsetsDirectional.only(
                                    //             start: 10),
                                    //         child: Row(
                                    //           //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //           children: [
                                    //             const SizedBox(
                                    //               width: 80,
                                    //             ),
                                    //             const Text(
                                    //               '1',
                                    //               // '${DrAidCubit.get(context).incompleteBillsModel?.data[index].id.toString()}',
                                    //               style: TextStyle(
                                    //                   fontSize: 16, color: fontColor),
                                    //             ),
                                    //             const SizedBox(
                                    //               width: 100,
                                    //             ),
                                    //             const Text(
                                    //               // '${DrAidCubit.get(context).incompleteBillsModel?.data[index].total.toString().padLeft(12)}',
                                    //               '200,000 ل.س',
                                    //               style: TextStyle(
                                    //                   fontSize: 16, color: fontColor),
                                    //             ),
                                    //             const SizedBox(
                                    //               width: 100,
                                    //             ),
                                    //             const Text(
                                    //               //'${DrAidCubit.get(context).getAllPaymentsModel?.data[index].billId.toString().padLeft(12)}',
                                    //               // '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].billId}',
                                    //               '134',
                                    //               style: TextStyle(
                                    //                   fontSize: 16, color: fontColor),
                                    //             ),
                                    //             const SizedBox(
                                    //               width: 120,
                                    //             ),
                                    //             const Text(
                                    //               '20-8-2024',
                                    //               // '${DrAidCubit.get(context).incompleteBillsModel?.data[index].createdAt.toString().substring(0, 10)}',
                                    //               style: TextStyle(
                                    //                   fontSize: 16, color: fontColor),
                                    //             ),
                                    //             const SizedBox(
                                    //               width: 100,
                                    //             ),
                                    //             Container(
                                    //               width: 70,
                                    //               height: 40,
                                    //               color: Colors.white,
                                    //               child: const Center(
                                    //                 child: Row(
                                    //                   children: [
                                    //                     Image(
                                    //                       image: AssetImage(
                                    //                         'images/edit1.png',
                                    //                       ),
                                    //                       width: 25,
                                    //                       height: 25,
                                    //                     ),
                                    //                     SizedBox(
                                    //                       width: 10,
                                    //                     ),
                                    //                     Image(
                                    //                       image: AssetImage(
                                    //                         'images/delete.png',
                                    //                       ),
                                    //                       width: 30,
                                    //                       height: 30,
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       );
                                    //     },
                                    //     separatorBuilder: (context, index) {
                                    //       return const Divider(
                                    //         color: borderColor,
                                    //       );
                                    //     },
                                    //     itemCount: 30,
                                    //     // DrAidCubit.get(context).incompleteBillsModel!.data.length
                                    //   ),
                                    // );
                                  }
                                },
                              ),

                              //
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              else{
                return Column(
                  children: [
                    const SizedBox(
                      height: 15,
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
                              DrAidCubit.get(context).inCompleteBills(
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
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 50.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 240,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 35,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if(screenWidth>1470)
                              Row(
                                children: [
                                  Container(
                                    width: 900,
                                    height: 1,
                                    color: dividerColor,
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            // if(state is DrAidIncompleteBillsSuccessState)

                            Builder(
                              builder: (context) {
                                if(
                                state is DrAidIncompleteBillsSuccessState&&
                                    // DrAidCubit.get(context).incompleteBillsModel!.
                                    DrAidCubit.get(context).incompleteBillsModel!.data.isEmpty
                                )
                                {
                                  return

                                    const Center(
                                      child: Text(
                                        'No incomplete bills in this date',
                                        style:  TextStyle(
                                            fontSize: 20, color: Colors.grey),
                                      ),
                                    );

                                }


                                if (state is DrAidIncompleteBillsSuccessState&&DrAidCubit.get(context).incompleteBillsModel!.data.isNotEmpty) {
                                  return Expanded(
                                    child:

                                    ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 10),
                                          child: Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              if(screenWidth>1460)
                                                const SizedBox(
                                                  width: 80,
                                                ),
                                              if(screenWidth>1460)
                                                Expanded(
                                                  child: Text(
                                                    //  '1',
                                                    '${DrAidCubit.get(context).incompleteBillsModel?.data[index].id.toString()}',
                                                    style: const TextStyle(
                                                        fontSize: 16, color: fontColor),
                                                  ),
                                                ),
                                              if(screenWidth>1460)
                                                const SizedBox(
                                                  width: 100,
                                                ),
                                              Expanded(
                                                child: Text(
                                                  '${DrAidCubit.get(context).incompleteBillsModel?.data[index].total.toString()}',
                                                  // '200,000 ل.س',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),
                                              if(screenWidth>1460)
                                                const SizedBox(
                                                  width: 100,
                                                ),
                                              if(screenWidth>=1005)
                                                Expanded(
                                                  child: Text(
                                                    '${DrAidCubit.get(context).incompleteBillsModel?.data[index].id.toString()}',
                                                    // '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].billId}',
                                                    // '134',
                                                    style: const TextStyle(
                                                        fontSize: 16, color: fontColor),
                                                  ),
                                                ),
                                              const SizedBox(
                                                width: 120,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  // '20-8-2024',
                                                  '${DrAidCubit.get(context).incompleteBillsModel?.data[index].createdAt.toString().substring(0, 10)}',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),
                                              if(screenWidth>=1005)
                                                const SizedBox(
                                                  width: 100,
                                                ),
                                              if(screenWidth>=1005)
                                                Container(
                                                  width: 70,
                                                  height: 40,
                                                  color: Colors.white,
                                                  child: const Center(
                                                    child: Row(
                                                      children: [
                                                        Image(
                                                          image: AssetImage(
                                                            'images/edit1.png',
                                                          ),
                                                          width: 25,
                                                          height: 25,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image(
                                                          image: AssetImage(
                                                            'images/delete.png',
                                                          ),
                                                          width: 30,
                                                          height: 30,
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
                                        return const Divider(
                                          color: borderColor,
                                        );
                                      },
                                      itemCount:
                                      //30,
                                      DrAidCubit.get(context)
                                          .incompleteBillsModel!
                                          .data
                                          .length,
                                    ),
                                  );
                                } else if (state is DrAidIncompleteBillsErrorState) {
                                  return const Center(
                                      child: Text('Something went wrong'));
                                } else if (state
                                is DrAidIncompleteBillsLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return const Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Text(
                                          'Choose date',
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  );

                                }
                              },
                            ),

                            //
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

            }
          );
        });
  }
}
