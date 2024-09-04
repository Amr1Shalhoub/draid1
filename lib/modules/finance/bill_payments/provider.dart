import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Provider extends StatefulWidget {
  const Provider({super.key});

  @override
  State<Provider> createState() => _ProviderState();
}

class _ProviderState extends State<Provider> {
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

  TextEditingController providerNameController = TextEditingController();

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
                  padding: const EdgeInsetsDirectional.only(end: 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 342,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            if(screenWidth>=1400)
                              Container(
                                height: 35,
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: borderColor, // Set the border color
                                    width: 1, // Set the border width
                                  ),
                                ),
                                margin: const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 15),
                                  child: AddTreatmentFormField(
                                    // imagePath: 'images/tooth_icon.svg',
                                    //SvgIconData('images/vector.svg',) ,
                                    //SvgIconData('images/vector.svg',),
                                      type: TextInputType.emailAddress,
                                      controller: providerNameController,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your email address';
                                        }
                                        return null;
                                      },
                                      label: 'اسم المزود '),
                                ),
                              ),
                            if(screenWidth<1400)
                              Container(
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: borderColor, // Set the border color
                                    width: 1, // Set the border width
                                  ),
                                ),
                                margin: const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 15),
                                  child: AddTreatmentFormField(
                                    // imagePath: 'images/tooth_icon.svg',
                                    //SvgIconData('images/vector.svg',) ,
                                    //SvgIconData('images/vector.svg',),
                                      type: TextInputType.emailAddress,
                                      controller: providerNameController,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your email address';
                                        }
                                        return null;
                                      },
                                      label: 'المزود'),
                                ),
                              ),

                            // MyDatePicker(title: 'اختر مزود', initialDate: DateTime.now(),onDateChanged:_onFromDateChanged ,),
                            if(screenWidth>=1400)
                              const SizedBox(width: 20),
                            if(screenWidth<1400)
                              const SizedBox(width: 10),
                            if(screenWidth>=1400)
                              const SizedBox(
                                height: 30,
                                child: VerticalDivider(
                                  width: 10,
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            if(screenWidth>=1400)
                              const SizedBox(width: 20),
                            MyDatePicker(
                              title: 'من تاريخ',
                              initialDate: DateTime.now(),
                              onDateChanged: _onFromDateChanged,
                            ),
                            if(screenWidth>=1400)
                              const SizedBox(width: 20),
                            if(screenWidth<1400)
                              const SizedBox(width: 10),
                            if(screenWidth>=1400)
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
                            if(screenWidth>=1400)
                              const SizedBox(width: 20),
                            MyDatePicker(
                              title: 'إلى تاريخ',
                              initialDate: DateTime.now(),
                              onDateChanged: _onToDateChanged,
                            ),
                            if(screenWidth>=1400)
                              const SizedBox(width: 20),
                            if(screenWidth<1400)
                              const SizedBox(width: 10),
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
                                if (fromDateString != null &&
                                    toDateString != null &&
                                    providerNameController.text != '') {
                                  DrAidCubit.get(context).reportProviderFunction(
                                    provider: providerNameController.text,
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
                          height: 10,
                        ),
                        Builder(builder: (context) {
                          if (state is DrAidReportProviderLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }


                          else if(state is DrAidReportProviderSuccessState&&DrAidCubit.get(context).reportProviderModel!.data.isNotEmpty)
                          {
                            return Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width * 0.55,
                                        height: 260,
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
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    'رقم الفاتورة',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: fontColor2,
                                                    ),
                                                  ),
                                                  Text(
                                                    //'800.000 ل.س',
                                                    '${DrAidCubit.get(context).reportProviderModel?.data[index].billId}    ',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: fontColor2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Divider(
                                              color: fontColor2,
                                            ),
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
                                                    //'800.000 ل.س',
                                                    '${DrAidCubit.get(context).reportProviderModel?.data[index].totalOwed} ل.س ',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: fontColor2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Divider(
                                              color: fontColor2,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
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
                                                    //'200.000 ل.س',
                                                    '${DrAidCubit.get(context).reportProviderModel?.data[index].totalPaid} ل.س ',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: fontColor2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Divider(
                                              color: fontColor2,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
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
                                                    //'600.000 ل.س',
                                                    '${DrAidCubit.get(context).reportProviderModel?.data[index].remainingAmount} ل.س ',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: blueText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                itemCount:
                                // 4,
                                DrAidCubit.get(context)
                                    .reportProviderModel!
                                    .data
                                    .length +
                                    1,
                              ),
                            );
                          }

                          else {

                            if(state is DrAidReportProviderSuccessState&&DrAidCubit.get(context).reportProviderModel!.data.isEmpty)
                            {
                              return const Center(child: Text(

                                'لا يوجد بيانات مزود بهذا الاسم ضمن هذا التاريخ',

                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.grey,
                                ),
                              ),
                              );
                            }



                            else {
                              return const Center(child: Text(

                                'اختر اسم المزود والتاريخ لعرض حساباته',

                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.grey,
                                ),
                              ),
                              );
                            }



                            // if (state is DrAidReportProviderSuccessState ||
                            //     DrAidCubit.get(context)
                            //                 .reportProviderModel
                            //                 ?.data
                            //                 .length !=
                            //             0 &&
                            //         DrAidCubit.get(context)
                            //                 .reportProviderModel
                            //                 ?.data
                            //                 .length !=
                            //             null) {
                            //   return Expanded(
                            //     child: ListView.separated(
                            //       itemBuilder: (context, index) {
                            //         return const SizedBox(
                            //           height: 10,
                            //         );
                            //       },
                            //       separatorBuilder: (context, index) {
                            //         return Row(
                            //           children: [
                            //             Container(
                            //               width:
                            //                   MediaQuery.of(context).size.width * 0.55,
                            //               height: 260,
                            //               decoration: BoxDecoration(
                            //                 border: Border.all(
                            //                   color: borderColor,
                            //                   width: 2,
                            //                 ),
                            //                 borderRadius: BorderRadius.circular(10),
                            //               ),
                            //               child: Column(
                            //                 children: [
                            //                   const SizedBox(
                            //                     height: 10,
                            //                   ),
                            //                   Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.spaceBetween,
                            //                       children: [
                            //                         const Text(
                            //                           'رقم الفاتورة',
                            //                           style: TextStyle(
                            //                             fontSize: 18,
                            //                             color: fontColor2,
                            //                           ),
                            //                         ),
                            //                         Text(
                            //                           //'800.000 ل.س',
                            //                           '${DrAidCubit.get(context).reportProviderModel?.data[index].billId}    ',
                            //                           style: const TextStyle(
                            //                             fontSize: 18,
                            //                             color: fontColor2,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                   const SizedBox(
                            //                     height: 5,
                            //                   ),
                            //                   const Divider(
                            //                     color: fontColor2,
                            //                   ),
                            //                   Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.spaceBetween,
                            //                       children: [
                            //                         const Text(
                            //                           'الإجمالي',
                            //                           style: TextStyle(
                            //                             fontSize: 18,
                            //                             color: fontColor2,
                            //                           ),
                            //                         ),
                            //                         Text(
                            //                           //'800.000 ل.س',
                            //                           '${DrAidCubit.get(context).reportProviderModel?.data[index].totalOwed} ل.س ',
                            //                           style: const TextStyle(
                            //                             fontSize: 18,
                            //                             color: fontColor2,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                   const SizedBox(
                            //                     height: 5,
                            //                   ),
                            //                   const Divider(
                            //                     color: fontColor2,
                            //                   ),
                            //                   const SizedBox(
                            //                     height: 5,
                            //                   ),
                            //                   Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.spaceBetween,
                            //                       children: [
                            //                         const Text(
                            //                           'المدفوع',
                            //                           style: TextStyle(
                            //                             fontSize: 18,
                            //                             color: fontColor2,
                            //                           ),
                            //                         ),
                            //                         Text(
                            //                           //'200.000 ل.س',
                            //                           '${DrAidCubit.get(context).reportProviderModel?.data[index].totalPaid} ل.س ',
                            //                           style: const TextStyle(
                            //                             fontSize: 18,
                            //                             color: fontColor2,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                   const SizedBox(
                            //                     height: 5,
                            //                   ),
                            //                   const Divider(
                            //                     color: fontColor2,
                            //                   ),
                            //                   const SizedBox(
                            //                     height: 5,
                            //                   ),
                            //                   Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.spaceBetween,
                            //                       children: [
                            //                         const Text(
                            //                           'الباقي',
                            //                           style: TextStyle(
                            //                             fontSize: 18,
                            //                             color: fontColor2,
                            //                           ),
                            //                         ),
                            //                         Text(
                            //                           //'600.000 ل.س',
                            //                           '${DrAidCubit.get(context).reportProviderModel?.data[index].remainingAmount} ل.س ',
                            //                           style: const TextStyle(
                            //                             fontSize: 18,
                            //                             color: blueText,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //       itemCount:
                            //           // 4,
                            //           DrAidCubit.get(context)
                            //                   .reportProviderModel!
                            //                   .data
                            //                   .length +
                            //               1,
                            //     ),
                            //   );
                            // } else {
                            //   return const Column(
                            //     children: [
                            //       SizedBox(
                            //         height: 20,
                            //       ),
                            //       Center(
                            //         child: Text(
                            //           'اختر اسم المزود والتاريخ لعرض حساباته',
                            //           style:
                            //               TextStyle(fontSize: 20, color: Colors.grey),
                            //         ),
                            //       ),
                            //     ],
                            //   );
                            //
                            // }
                          }
                        }),
                      ],
                    ),
                  ),
                );

              }
            else{
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 342,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          if(screenWidth>=1400)
                            Container(
                              height: 35,
                              width: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: borderColor, // Set the border color
                                  width: 1, // Set the border width
                                ),
                              ),
                              margin: const EdgeInsetsDirectional.only(start: 20),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(start: 15),
                                child: AddTreatmentFormField(
                                  // imagePath: 'images/tooth_icon.svg',
                                  //SvgIconData('images/vector.svg',) ,
                                  //SvgIconData('images/vector.svg',),
                                    type: TextInputType.emailAddress,
                                    controller: providerNameController,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter your email address';
                                      }
                                      return null;
                                    },
                                    label: 'Supplier '),
                              ),
                            ),
                          if(screenWidth<1400)
                            Container(
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: borderColor, // Set the border color
                                  width: 1, // Set the border width
                                ),
                              ),
                              margin: const EdgeInsetsDirectional.only(start: 20),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(start: 15),
                                child: AddTreatmentFormField(
                                  // imagePath: 'images/tooth_icon.svg',
                                  //SvgIconData('images/vector.svg',) ,
                                  //SvgIconData('images/vector.svg',),
                                    type: TextInputType.emailAddress,
                                    controller: providerNameController,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter your email address';
                                      }
                                      return null;
                                    },
                                    label: 'Supplier'),
                              ),
                            ),

                          // MyDatePicker(title: 'اختر مزود', initialDate: DateTime.now(),onDateChanged:_onFromDateChanged ,),
                          if(screenWidth>=1400)
                            const SizedBox(width: 20),
                          if(screenWidth<1400)
                            const SizedBox(width: 10),
                          if(screenWidth>=1400)
                            const SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                width: 10,
                                thickness: 1,
                                indent: 10,
                                endIndent: 1,
                                color: Colors.grey,
                              ),
                            ),
                          if(screenWidth>=1400)
                            const SizedBox(width: 20),
                          MyDatePicker(
                            title: 'From',
                            initialDate: DateTime.now(),
                            onDateChanged: _onFromDateChanged,
                          ),
                          if(screenWidth>=1400)
                            const SizedBox(width: 20),
                          if(screenWidth<1400)
                            const SizedBox(width: 10),
                          if(screenWidth>=1400)
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
                          if(screenWidth>=1400)
                            const SizedBox(width: 20),
                          MyDatePicker(
                            title: 'To',
                            initialDate: DateTime.now(),
                            onDateChanged: _onToDateChanged,
                          ),
                          if(screenWidth>=1400)
                            const SizedBox(width: 20),
                          if(screenWidth<1400)
                            const SizedBox(width: 10),
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
                              if (fromDateString != null &&
                                  toDateString != null &&
                                  providerNameController.text != '') {
                                DrAidCubit.get(context).reportProviderFunction(
                                  provider: providerNameController.text,
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
                        height: 10,
                      ),
                      Builder(builder: (context) {
                        if (state is DrAidReportProviderLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }


                        else if(state is DrAidReportProviderSuccessState&&DrAidCubit.get(context).reportProviderModel!.data.isNotEmpty)
                        {
                          return Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      width:
                                      MediaQuery.of(context).size.width * 0.55,
                                      height: 260,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  'Bill id',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: fontColor2,
                                                  ),
                                                ),
                                                Text(
                                                  //'800.000 ل.س',
                                                  '${DrAidCubit.get(context).reportProviderModel?.data[index].billId}    ',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: fontColor2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Divider(
                                            color: fontColor2,
                                          ),
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
                                                  //'800.000 ل.س',
                                                  '${DrAidCubit.get(context).reportProviderModel?.data[index].totalOwed} ل.س ',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: fontColor2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Divider(
                                            color: fontColor2,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
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
                                                  //'200.000 ل.س',
                                                  '${DrAidCubit.get(context).reportProviderModel?.data[index].totalPaid} ل.س ',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: fontColor2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Divider(
                                            color: fontColor2,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
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
                                                  //'600.000 ل.س',
                                                  '${DrAidCubit.get(context).reportProviderModel?.data[index].remainingAmount} ل.س ',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: blueText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                              itemCount:
                              // 4,
                              DrAidCubit.get(context)
                                  .reportProviderModel!
                                  .data
                                  .length +
                                  1,
                            ),
                          );
                        }

                        else {

                          if(state is DrAidReportProviderSuccessState&&DrAidCubit.get(context).reportProviderModel!.data.isEmpty)
                          {
                            return const Center(child: Text(

                              'No data for this supplier',

                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey,
                              ),
                            ),
                            );
                          }



                          else {
                            return const Center(child: Text(

                              'Choose supplier',

                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey,
                              ),
                            ),
                            );
                          }

                        }
                      }),
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
