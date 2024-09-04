// ignore_for_file: prefer_is_empty

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPayments extends StatelessWidget {
  const AllPayments({super.key});

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
                return Padding(
                  padding: const EdgeInsetsDirectional.only(end: 50.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
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
                        Builder(
                          builder: (context) {
                            if (DrAidCubit.get(context)
                                .getAllPaymentsModel!
                                .data
                                .isEmpty ||
                                DrAidCubit.get(context)
                                    .getAllPaymentsModel!
                                    .data
                                    .length ==
                                    0) {
                              return const Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'لا يوجد دفعات بعد',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }

                            if (state is DrAidGetAllPaymentsLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (
                            // state is DrAidGetAllPaymentsSuccessState||

                            DrAidCubit.get(context)
                                .getAllPaymentsModel!
                                .data
                                .isNotEmpty) {
                              return Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(start: 10),
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
                                                  // '1',
                                                  '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].id.toString()}',
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
                                                '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].amount.toString()}',
                                                //'200,000 ل.س',
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
                                                  '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].billId.toString()}',
                                                  // '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].billId}',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),
                                            const SizedBox(
                                              width: 120,
                                            ),
                                            Expanded(
                                              child: Text(
                                                //'20-8-2024',
                                                '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].createdAt.toString().substring(0, 10)}',
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
                                    itemCount: DrAidCubit.get(context)
                                        .getAllPaymentsModel!
                                        .data
                                        .length),
                              );
                            } else {
                              return const Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'لا يوجد دفعات بعد',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }

                            // return  Expanded(
                            //   child: ListView.separated(
                            //       itemBuilder: (context, index) {
                            //         return Padding(
                            //           padding: const EdgeInsetsDirectional.only(start: 10),
                            //           child: Row(
                            //             //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //             children: [
                            //               const SizedBox(
                            //                 width: 80,
                            //               ),
                            //               Expanded(
                            //                 child: Text(
                            //                   // '1',
                            //                   '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].id.toString()}',
                            //                   style:
                            //                   const TextStyle(fontSize: 16, color: fontColor),
                            //                 ),
                            //               ),
                            //               const SizedBox(
                            //                 width: 100,
                            //               ),
                            //               Expanded(
                            //                 child: Text(
                            //                   '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].amount.toString()}',
                            //                   //'200,000 ل.س',
                            //                   style:
                            //                   const TextStyle(fontSize: 16, color: fontColor),
                            //                 ),
                            //               ),
                            //               const SizedBox(
                            //                 width: 100,
                            //               ),
                            //               Expanded(
                            //                 child: Text(
                            //                   '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].billId.toString()}',
                            //                   // '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].billId}',
                            //                   style:
                            //                   const TextStyle(fontSize: 16, color: fontColor),
                            //                 ),
                            //               ),
                            //               const SizedBox(
                            //                 width: 120,
                            //               ),
                            //               Expanded(
                            //                 child: Text(
                            //                   //'20-8-2024',
                            //                   '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].createdAt.toString().substring(0, 10)}',
                            //                   style:
                            //                   const TextStyle(fontSize: 16, color: fontColor),
                            //                 ),
                            //               ),
                            //               const SizedBox(
                            //                 width: 100,
                            //               ),
                            //               Container(
                            //                 width: 70,
                            //                 height: 40,
                            //                 color: Colors.white,
                            //                 child: const Center(
                            //                   child: Row(
                            //                     children: [
                            //                       Image(
                            //                         image: AssetImage(
                            //                           'images/edit1.png',
                            //                         ),
                            //                         width: 25,
                            //                         height: 25,
                            //                       ),
                            //                       SizedBox(
                            //                         width: 10,
                            //                       ),
                            //                       Image(
                            //                         image: AssetImage(
                            //                           'images/delete.png',
                            //                         ),
                            //                         width: 30,
                            //                         height: 30,
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         );
                            //       },
                            //       separatorBuilder: (context, index) {
                            //         return const Divider(
                            //           color: borderColor,
                            //         );
                            //       },
                            //       itemCount:
                            //       DrAidCubit.get(context).getAllPaymentsModel!.data.length),
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            else{
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 50.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(30)),
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
                      Builder(
                        builder: (context) {
                          if (DrAidCubit.get(context)
                              .getAllPaymentsModel!
                              .data
                              .isEmpty ||
                              DrAidCubit.get(context)
                                  .getAllPaymentsModel!
                                  .data
                                  .length ==
                                  0) {
                            return const Column(
                              children: [
                                Center(
                                  child: Text(
                                    'No payments yet',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          if (state is DrAidGetAllPaymentsLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (
                          // state is DrAidGetAllPaymentsSuccessState||

                          DrAidCubit.get(context)
                              .getAllPaymentsModel!
                              .data
                              .isNotEmpty) {
                            return Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                      const EdgeInsetsDirectional.only(start: 10),
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
                                                // '1',
                                                '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].id.toString()}',
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
                                              '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].amount.toString()}',
                                              //'200,000 ل.س',
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
                                                '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].billId.toString()}',
                                                // '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].billId}',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),
                                          const SizedBox(
                                            width: 120,
                                          ),
                                          Expanded(
                                            child: Text(
                                              //'20-8-2024',
                                              '${DrAidCubit.get(context).getAllPaymentsModel?.data[index].createdAt.toString().substring(0, 10)}',
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
                                  itemCount: DrAidCubit.get(context)
                                      .getAllPaymentsModel!
                                      .data
                                      .length),
                            );
                          } else {
                            return const Column(
                              children: [
                                Center(
                                  child: Text(
                                    'No payments yet',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }


                        },
                      ),
                    ],
                  ),
                ),
              );
            }

          }
        );
      },
    );
  }
}
