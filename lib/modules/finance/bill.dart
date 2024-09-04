// ignore_for_file: deprecated_member_use
import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/modules/finance/finance_middle_bar.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bill extends StatefulWidget {
  const Bill({super.key});

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
  // const Bill({super.key});
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

  void showPatientFullAccount(BuildContext context, int clinicId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocConsumer<DrAidCubit, DrAidStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if(languagee=='arabic')
                {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: SimpleDialog(
                      title: const Padding(
                        padding: EdgeInsetsDirectional.only(start: 30),
                        child: Text(
                          'تقرير حساب الأرباح',
                          style: TextStyle(
                            fontSize: 24,
                            color: simpleDialogTitleColor,
                          ),
                        ),
                      ),
                      children: <Widget>[
                        //if(apiResponse.data.isEmpty)
                        //Center(child: Text('No requests right now'),),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 500,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(start: 50),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.arrow_forward),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'العودة',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: fontColor2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(height: 20),
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
                                            backgroundColor:
                                            ColorManager.buttonColor,
                                          ),
                                          onPressed: () {
                                            if (fromDate != null &&
                                                toDate != null) {
                                              fromDateString =
                                                  fromDate!.toIso8601String();
                                              toDateString =
                                                  toDate!.toIso8601String();
                                              print(
                                                  'From: $fromDateString, To: $toDateString');
                                              // Add your logic to use the date strings
                                            } else {
                                              print('Please select both dates.');
                                            }
                                            if (fromDateString != null &&
                                                toDateString != null) {
                                              DrAidCubit.get(context)
                                                  .clinicNetProfitFunction(
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
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width *
                                              0.55,
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
                                              if (state
                                              is DrAidClinicNetProfitLoadingState) {
                                                return const Center(
                                                  child:
                                                  CircularProgressIndicator(),
                                                );
                                              }
                                              else if (
                                              state is DrAidClinicNetProfitSuccessState&&
                                                  DrAidCubit.get(context).clinicNetProfitModel?.data.totalPaidAmount==0&&
                                                  DrAidCubit.get(context).clinicNetProfitModel?.data.netProfit==0&&
                                                  DrAidCubit.get(context).clinicNetProfitModel?.data.totalCosts==0
                                              )

                                              {
                                                return  const Center(
                                                  child: Text(
                                                    'لا يوجد أرباح ضمن التاريخ الذي أدخلته',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                );
                                              }


                                              else if (state
                                              is DrAidClinicNetProfitSuccessState) {
                                                return Column(
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'المبالغ المدفوعة',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: fontColor2,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${DrAidCubit.get(context).clinicNetProfitModel?.data.totalPaidAmount} ل.س ',
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
                                                    const Divider(
                                                        color: fontColor2),
                                                    const SizedBox(height: 5),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'اجمالي التكاليف',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: fontColor2,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${DrAidCubit.get(context).clinicNetProfitModel?.data.totalCosts} ل.س  ',
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
                                                    const Divider(
                                                        color: fontColor2),
                                                    const SizedBox(height: 5),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'مجمل الأرباح',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: fontColor2,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${DrAidCubit.get(context).clinicNetProfitModel?.data.netProfit} ل.س ',
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
                                                    'أدخل التاريخ لمعرفة صافي الأرباح',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                );


                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
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
                      padding: EdgeInsetsDirectional.only(start: 30),
                      child: Text(
                        'Profits Report',
                        style: TextStyle(
                          fontSize: 24,
                          color: simpleDialogTitleColor,
                        ),
                      ),
                    ),
                    children: <Widget>[


                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 500,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 50),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.arrow_forward),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Back',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: fontColor2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  const SizedBox(height: 20),
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
                                          backgroundColor:
                                          ColorManager.buttonColor,
                                        ),
                                        onPressed: () {
                                          if (fromDate != null &&
                                              toDate != null) {
                                            fromDateString =
                                                fromDate!.toIso8601String();
                                            toDateString =
                                                toDate!.toIso8601String();
                                            print(
                                                'From: $fromDateString, To: $toDateString');
                                            // Add your logic to use the date strings
                                          } else {
                                            print('Please select both dates.');
                                          }
                                          if (fromDateString != null &&
                                              toDateString != null) {
                                            DrAidCubit.get(context)
                                                .clinicNetProfitFunction(
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
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.55,
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
                                            if (state
                                            is DrAidClinicNetProfitLoadingState) {
                                              return const Center(
                                                child:
                                                CircularProgressIndicator(),
                                              );
                                            }
                                            else if (
                                            state is DrAidClinicNetProfitSuccessState&&
                                                DrAidCubit.get(context).clinicNetProfitModel?.data.totalPaidAmount==0&&
                                                DrAidCubit.get(context).clinicNetProfitModel?.data.netProfit==0&&
                                                DrAidCubit.get(context).clinicNetProfitModel?.data.totalCosts==0
                                            )

                                            {
                                              return  const Center(
                                                child: Text(
                                                  'No Profits in this date',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              );
                                            }


                                            else if (state
                                            is DrAidClinicNetProfitSuccessState) {
                                              return Column(
                                                children: [
                                                  const SizedBox(height: 10),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Amounts paid',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: fontColor2,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${DrAidCubit.get(context).clinicNetProfitModel?.data.totalPaidAmount} ل.س ',
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
                                                  const Divider(
                                                      color: fontColor2),
                                                  const SizedBox(height: 5),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Total costs',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: fontColor2,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${DrAidCubit.get(context).clinicNetProfitModel?.data.totalCosts} ل.س  ',
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
                                                  const Divider(
                                                      color: fontColor2),
                                                  const SizedBox(height: 5),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'Total Profit',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: fontColor2,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${DrAidCubit.get(context).clinicNetProfitModel?.data.netProfit} ل.س ',
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
                                                  'Enter date to know profit',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              );


                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
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
        });
  }

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
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: 700,
                        color: coolWhite2,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Builder(
                                  builder: (context) {
                                    if(screenWidth<800)
                                    {
                                      return Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(start: 20, end: 20),
                                        child: Row(
                                          children: [

                                            if(screenWidth>1000&&modee=='light')
                                              InkWell(
                                                child: const Image(
                                                  image: AssetImage('images/arrow.png'),
                                                  width: 30,
                                                  height: 20,
                                                ),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            if(modee=='light')
                                              const Text(
                                                'المالية',
                                                style: TextStyle(fontSize: 28, color:
                                                blueText
                                                )
                                                ,
                                              ),
                                            if(modee=='dark')
                                              const Text(
                                                'المالية',
                                                style: TextStyle(fontSize: 28, color:
                                                Colors.orange
                                                )
                                                ,
                                              ),
                                            const Spacer(),
                                            Container(
                                              width: 175,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: coolGreen1,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  print(5);


                                                  showPatientFullAccount(context, 1);
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(start: 30),
                                                  child: Row(children: [
                                                    // SvgPicture.asset(
                                                    //   'images/report.svg',
                                                    //   // '$imagePath',
                                                    //   //   semanticsLabel: 'My SVG Image',
                                                    //   height: 30,
                                                    //   width: 30,
                                                    //   color: Colors.white,
                                                    // ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    const Text(
                                                      'الأرباح',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    else{
                                      return Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(start: 20, end: 130),
                                        child: Row(
                                          children: [

                                            if(screenWidth>1000&&modee=='light')
                                              InkWell(
                                                child: const Image(
                                                  image: AssetImage('images/arrow.png'),
                                                  width: 30,
                                                  height: 20,
                                                ),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            if(modee=='light')
                                              const Text(
                                                'المالية',
                                                style: TextStyle(fontSize: 28, color: blueText),
                                              ),
                                            if(modee=='dark')
                                              const Text(
                                                'المالية',
                                                style: TextStyle(fontSize: 28, color: Colors.orange),
                                              ),

                                            const Spacer(),
                                            Container(
                                              width: 250,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: coolGreen1,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  print(5);


                                                  showPatientFullAccount(context, 1);
                                                },
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsetsDirectional.only(start: 30),
                                                  child: Row(children: [
                                                    SvgPicture.asset(
                                                      'images/report.svg',
                                                      // '$imagePath',
                                                      //   semanticsLabel: 'My SVG Image',
                                                      height: 30,
                                                      width: 30,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    const Text(
                                                      'تقرير صافي الأرباح',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                  }
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const FinanceMiddleBar(
                                texts: ['الفواتير ', 'حساب المرضى ', 'دفعات الفواتير '],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DrAidCubit.get(context).bottomFinancescreens[
                              DrAidCubit.get(context).financescreenindex],
                            ],
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      height: 700,
                      color: coolWhite2,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Builder(
                                builder: (context) {
                                  if(screenWidth<800)
                                  {
                                    return Padding(
                                      padding:
                                      const EdgeInsetsDirectional.only(start: 20, end: 20),
                                      child: Row(
                                        children: [

                                          if(screenWidth>1000&&modee=='light')
                                            InkWell(
                                              child: Icon(Icons.arrow_back,size: 30,color: blueText,),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          if(modee=='light')
                                            const Text(
                                              'Finance',
                                              style: TextStyle(fontSize: 28, color:
                                              blueText
                                              )
                                              ,
                                            ),
                                          if(modee=='dark')
                                            const Text(
                                              'Finance',
                                              style: TextStyle(fontSize: 28, color:
                                              Colors.orange
                                              )
                                              ,
                                            ),
                                          const Spacer(),
                                          Container(
                                            width: 175,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: coolGreen1,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                print(5);


                                                showPatientFullAccount(context, 1);
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsetsDirectional.only(start: 30),
                                                child: Row(children: [
                                                  // SvgPicture.asset(
                                                  //   'images/report.svg',
                                                  //   // '$imagePath',
                                                  //   //   semanticsLabel: 'My SVG Image',
                                                  //   height: 30,
                                                  //   width: 30,
                                                  //   color: Colors.white,
                                                  // ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const Text(
                                                    'Profits',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  else{
                                    return Padding(
                                      padding:
                                      const EdgeInsetsDirectional.only(start: 20, end: 130),
                                      child: Row(
                                        children: [

                                          if(screenWidth>1000&&modee=='light')
                                            InkWell(
                                              child: const Image(
                                                image: AssetImage('images/arrow.png'),
                                                width: 30,
                                                height: 20,
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          if(modee=='light')
                                            const Text(
                                              'Finance',
                                              style: TextStyle(fontSize: 28, color: blueText),
                                            ),
                                          if(modee=='dark')
                                            const Text(
                                              'Finance',
                                              style: TextStyle(fontSize: 28, color: Colors.orange),
                                            ),

                                          const Spacer(),
                                          Container(
                                            width: 250,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: coolGreen1,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                print(5);


                                                showPatientFullAccount(context, 1);
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsetsDirectional.only(start: 30),
                                                child: Row(children: [
                                                  SvgPicture.asset(
                                                    'images/report.svg',
                                                    // '$imagePath',
                                                    //   semanticsLabel: 'My SVG Image',
                                                    height: 30,
                                                    width: 30,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const Text(
                                                    'Profits report',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                }
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Builder(
                              builder: (context) {
                                if(languagee=='arabic')
                                  {
                                    return const FinanceMiddleBar(
                                      texts: ['الفواتير ', 'حساب المرضى ', 'دفعات الفواتير '],
                                    );
                                  }
                                else{
                                  return const FinanceMiddleBar(
                                    texts: ['Bills', ' Patient Account', 'Bills Payments'],
                                  );
                                }

                              }
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DrAidCubit.get(context).bottomFinancescreens[
                            DrAidCubit.get(context).financescreenindex],
                          ],
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
}
