// ignore_for_file: prefer_is_empty, must_be_immutable

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/network/local/cache_helper.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtsPatient extends StatelessWidget {
  //const DebtsPatient({super.key});


  TextEditingController addPaymentController = TextEditingController();
  TextEditingController showPatientController = TextEditingController();

  DebtsPatient({super.key});
  void addNewPaymentDialog(
      BuildContext context, int treatmentPlanId, int patientId, int clinicId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SimpleDialog(
              title: const Padding(
                padding: EdgeInsetsDirectional.only(start: 30),
                child: Text(
                  'إضافة دفعة جديدة',
                  style: TextStyle(
                    fontSize: 18,
                    color: simpleDialogTitleColor,
                  ),
                ),
              ),
              children: <Widget>[
                //if(apiResponse.data.isEmpty)
                //Center(child: Text('No requests right now'),),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: 250,

                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 30),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: borderColor, // Set the border color
                                  width: 1, // Set the border width
                                ),
                              ),
                              margin:
                              const EdgeInsetsDirectional.only(start: 20),
                              child: Padding(
                                padding:
                                const EdgeInsetsDirectional.only(start: 15),
                                child: AddTreatmentFormField(
                                  // imagePath: 'images/tooth_icon.svg',
                                  //SvgIconData('images/vector.svg',) ,
                                  //SvgIconData('images/vector.svg',),
                                    type: TextInputType.emailAddress,
                                    controller: addPaymentController,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter your email address';
                                      }
                                      return null;
                                    },
                                    label: 'ادخل المبلغ المدفوع'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Expanded(
                      //   child: ListView.separated(
                      //     shrinkWrap: true,
                      //     itemBuilder: (context,index)=>Container(height: 50,width: 50,color: Colors.red,),
                      //     separatorBuilder: (context,index)=>Padding(
                      //       padding: const EdgeInsetsDirectional.only(start:30 ),
                      //       child: Container(height: 1,color: Colors.grey,),
                      //     ),
                      //     itemCount: 0,
                      //   ),
                      // ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          DrAidCubit.get(context).addPatientPayment(
                            patientId: patientId,
                            treatmentPlanId: treatmentPlanId,
                            amount: int.parse(addPaymentController.text),
                          );

                          // treatmentPlanDetails(context);
                          // addNewTreatmentPlan(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            // Add your Container here
                            height:
                            45, // Specify the height of the new container
                            width: 200, // Make it take the full width
                            //  color: Colors.blue, // Example color
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'أدخل الدفعة',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ListView.separated(
                  //   shrinkWrap: true,
                  //   itemBuilder: (context,index)=>Container(height: 50,width: 50,color: Colors.red,),
                  //   separatorBuilder: (context,index)=>Padding(
                  //     padding: const EdgeInsetsDirectional.only(start:30 ),
                  //     child: Container(height: 1,color: Colors.grey,),
                  //   ),
                  //   itemCount: 8,
                  // ),
                ),
              ],
            ),
          );
        });
  }

  void showPatientAccount(
      BuildContext context, int treatmentPlanId, int patientId, int clinicId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: SimpleDialog(
                  title: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 30),
                    child: Text(
                      'بيان حساب مريض',
                      style: TextStyle(
                        fontSize: 18,
                        color: simpleDialogTitleColor,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    //if(apiResponse.data.isEmpty)
                    //Center(child: Text('No requests right now'),),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 250,

                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: borderColor, // Set the border color
                                      width: 1, // Set the border width
                                    ),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddTreatmentFormField(
                                      // imagePath: 'images/tooth_icon.svg',
                                      //SvgIconData('images/vector.svg',) ,
                                      //SvgIconData('images/vector.svg',),
                                        type: TextInputType.emailAddress,
                                        controller: showPatientController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter your email address';
                                          }
                                          return null;
                                        },
                                        label: 'اختر الخطة'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: DrAidCubit.get(context).checkBoxValue,
                                  onChanged: (bool? value) {
                                    DrAidCubit.get(context).changeCheckBox();
                                  },
                                  activeColor: Colors.green, // Color when checked
                                  checkColor:
                                  Colors.white, // Color of the checkmark
                                  shape: const RoundedRectangleBorder(
                                    // Adjust the border radius as needed
                                    side: BorderSide(
                                        color:
                                        fontColor2), // Set the border color and width
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Text(
                                  'اختر كامل الحساب',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: fontColor2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Expanded(
                          //   child: ListView.separated(
                          //     shrinkWrap: true,
                          //     itemBuilder: (context,index)=>Container(height: 50,width: 50,color: Colors.red,),
                          //     separatorBuilder: (context,index)=>Padding(
                          //       padding: const EdgeInsetsDirectional.only(start:30 ),
                          //       child: Container(height: 1,color: Colors.grey,),
                          //     ),
                          //     itemCount: 0,
                          //   ),
                          // ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              // DrAidCubit.get(context).addPatientPayment(
                              //     patientId: patientId,
                              //     clinicId: clinicId,
                              //     treatmentPlanId: treatmentPlanId,
                              //     amount: int.parse(addPaymentController.text),
                              //     token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiJhYWFhYdij2K3ZhdivINi02YrYriDYp9mE2LTYqNin2KgiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3MTg5MTQ3ODh9.z6zwzLFfHljjEkR2fvxbZ-vAKWN0YfCRjMHMnvzmaG8'
                              // );
                              int? clinicIdd = CacheHelper.getData(key: 'id');
                              DrAidCubit.get(context).getAccountStatement(
                                id: '$patientId',
                                id2: '$treatmentPlanId',
                              );


                              showPatientFullAccount(
                                context,
                                treatmentPlanId,
                                patientId,
                                clinicIdd!,
                              );

                              // treatmentPlanDetails(context);
                              // addNewTreatmentPlan(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                // Add your Container here
                                height:
                                45, // Specify the height of the new container
                                width: 200, // Make it take the full width
                                //  color: Colors.blue, // Example color
                                decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'طلب الحساب',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ListView.separated(
                      //   shrinkWrap: true,
                      //   itemBuilder: (context,index)=>Container(height: 50,width: 50,color: Colors.red,),
                      //   separatorBuilder: (context,index)=>Padding(
                      //     padding: const EdgeInsetsDirectional.only(start:30 ),
                      //     child: Container(height: 1,color: Colors.grey,),
                      //   ),
                      //   itemCount: 8,
                      // ),
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
                    'Show account',
                    style: TextStyle(
                      fontSize: 18,
                      color: simpleDialogTitleColor,
                    ),
                  ),
                ),
                children: <Widget>[
                  //if(apiResponse.data.isEmpty)
                  //Center(child: Text('No requests right now'),),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: 250,

                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: borderColor, // Set the border color
                                    width: 1, // Set the border width
                                  ),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddTreatmentFormField(
                                    // imagePath: 'images/tooth_icon.svg',
                                    //SvgIconData('images/vector.svg',) ,
                                    //SvgIconData('images/vector.svg',),
                                      type: TextInputType.emailAddress,
                                      controller: showPatientController,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your email address';
                                        }
                                        return null;
                                      },
                                      label: 'choose plan'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: DrAidCubit.get(context).checkBoxValue,
                                onChanged: (bool? value) {
                                  DrAidCubit.get(context).changeCheckBox();
                                },
                                activeColor: Colors.green, // Color when checked
                                checkColor:
                                Colors.white, // Color of the checkmark
                                shape: const RoundedRectangleBorder(
                                  // Adjust the border radius as needed
                                  side: BorderSide(
                                      color:
                                      fontColor2), // Set the border color and width
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const Text(
                                'select all account',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: fontColor2,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),
                        InkWell(
                          onTap: () {

                            int? clinicIdd = CacheHelper.getData(key: 'id');
                            DrAidCubit.get(context).getAccountStatement(
                              id: '$patientId',
                              id2: '$treatmentPlanId',
                            );


                            showPatientFullAccount(
                              context,
                              treatmentPlanId,
                              patientId,
                              clinicIdd!,
                            );

                            // treatmentPlanDetails(context);
                            // addNewTreatmentPlan(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              // Add your Container here
                              height:
                              45, // Specify the height of the new container
                              width: 200, // Make it take the full width
                              //  color: Colors.blue, // Example color
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  'Request account',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
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

  void showPatientFullAccount(
      BuildContext context, int treatmentPlanId, int patientId, int clinicId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: SimpleDialog(
                  title: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 30),
                    child: Text(
                      'بيان حساب مريض',
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
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: 300,

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
                          Builder(
                            builder: (context) {
                              if (DrAidCubit.get(context)
                                  .getAccountStatementModel
                                  ?.data
                                  .remainingAmount !=
                                  null) {
                                return Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: borderColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
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
                                              // '${DrAidCubit.get(context).revenuModel?.data.totalRevenue}ل.س ',
                                              // '800.000 ل.س',
                                              '${DrAidCubit.get(context).getAccountStatementModel?.data.totalCost} ل.س ',
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
                                              // '${DrAidCubit.get(context).revenuModel?.data.totalPaidAmount}ل.س ',
                                              // '200.000 ل.س',
                                              '${DrAidCubit.get(context).getAccountStatementModel?.data.paidAmount} ل.س ',
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
                                              // '${DrAidCubit.get(context).revenuModel?.data.remainingAmount}ل.س ',
                                              //'600.000 ل.س',
                                              '${DrAidCubit.get(context).getAccountStatementModel?.data.remainingAmount} ل.س ',
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
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )
                        ],
                      ),

                      // ListView.separated(
                      //   shrinkWrap: true,
                      //   itemBuilder: (context,index)=>Container(height: 50,width: 50,color: Colors.red,),
                      //   separatorBuilder: (context,index)=>Padding(
                      //     padding: const EdgeInsetsDirectional.only(start:30 ),
                      //     child: Container(height: 1,color: Colors.grey,),
                      //   ),
                      //   itemCount: 8,
                      // ),
                    ),
                  ],
                ),
              );
            }
          else{
            return Directionality(
              textDirection: TextDirection.rtl,
              child: SimpleDialog(
                title: const Padding(
                  padding: EdgeInsetsDirectional.only(start: 30),
                  child: Text(
                    'Show account',
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
                    width: MediaQuery.of(context).size.width * 0.50,
                    height: 300,

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
                        Builder(
                          builder: (context) {
                            if (DrAidCubit.get(context)
                                .getAccountStatementModel
                                ?.data
                                .remainingAmount !=
                                null) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: borderColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Total',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: fontColor2,
                                            ),
                                          ),
                                          Text(
                                            // '${DrAidCubit.get(context).revenuModel?.data.totalRevenue}ل.س ',
                                            // '800.000 ل.س',
                                            '${DrAidCubit.get(context).getAccountStatementModel?.data.totalCost} ل.س ',
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
                                            // '${DrAidCubit.get(context).revenuModel?.data.totalPaidAmount}ل.س ',
                                            // '200.000 ل.س',
                                            '${DrAidCubit.get(context).getAccountStatementModel?.data.paidAmount} ل.س ',
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
                                            // '${DrAidCubit.get(context).revenuModel?.data.remainingAmount}ل.س ',
                                            //'600.000 ل.س',
                                            '${DrAidCubit.get(context).getAccountStatementModel?.data.remainingAmount} ل.س ',
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
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )
                      ],
                    ),

                  ),
                ],
              ),
            );
          }

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
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(end: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          if(screenWidth>1530)
                            const Padding(
                              padding: EdgeInsetsDirectional.only(start: 10),
                              child:Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'اسم المريض',
                                    style: TextStyle(fontSize: 18, color: fontColor),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Text(
                                    'الكلفة',
                                    style: TextStyle(fontSize: 18, color: fontColor),
                                  ),
                                  SizedBox(
                                    width: 180,
                                  ),
                                  Text(
                                    'الباقي',
                                    style: TextStyle(fontSize: 18, color: fontColor),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Text(
                                    'الخطة العلاجية',
                                    style: TextStyle(fontSize: 18, color: fontColor),
                                  ),
                                  SizedBox(
                                    width: 165,
                                  ),
                                  Text(
                                    'بيان حساب',
                                    style: TextStyle(fontSize: 18, color: fontColor),
                                  ),
                                  // SizedBox(
                                  //   width: 70,
                                  // ),
                                  // Text(
                                  //   'الدفعات',
                                  //   style: TextStyle(fontSize: 18, color: fontColor),
                                  // ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                  Text(
                                    'الخيارات',
                                    style: TextStyle(fontSize: 18, color: fontColor),
                                  ),

                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),

                          const Divider(
                            color: dividerColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Builder(
                            builder: (context) {
                              if(state is DrAidGetPatientDebtsErrorState)
                              {
                                return const Center(
                                  child: Text('something went wrong'),
                                );
                              }
                              else if(state is DrAidGetPatientDebtsSuccessState&& DrAidCubit.get(context).getPatientDebtsModel!.data.isEmpty)
                              {
                                return const Center(
                                  child: Text('لا يوجد مرضى لديهم ديون حالياً'),
                                );

                              }
                              else if (state is DrAidGetPatientDebtsLoadingState) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              else if (state is DrAidGetPatientDebtsSuccessState||DrAidCubit.get(context).getPatientDebtsModel?.data.length!=null)
                              {
                                return Expanded(
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(start: 10),
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // const SizedBox(
                                            //   width: 80,
                                            // ),
                                            Expanded(
                                              child: Text(
                                                // 'محمد محمد',
                                                '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].patientName}',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                //  '200,000 ل.س',
                                                ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].totalCost}ل.س ',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),

                                            Expanded(
                                              child: Text(
                                                //  '200,000 ل.س',
                                                ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].remainingAmount}ل.س ',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),

                                            Expanded(
                                              child: Text(
                                                // '1',
                                                '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].treatmentPlanNumber}',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),
                                            if(screenWidth>=1000)
                                              Container(
                                                width: 130,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      showPatientAccount(
                                                          context,
                                                          DrAidCubit.get(context)
                                                              .getPatientDebtsModel!
                                                              .data[index]
                                                              .treatmentPlanNumber,
                                                          DrAidCubit.get(context)
                                                              .getPatientDebtsModel!
                                                              .data[index]
                                                              .id,
                                                          1
                                                      );
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  بيان حساب المريض  ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1000)
                                              Container(
                                                width: 80,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      showPatientAccount(
                                                          context,
                                                          DrAidCubit.get(context)
                                                              .getPatientDebtsModel!
                                                              .data[index]
                                                              .treatmentPlanNumber,
                                                          DrAidCubit.get(context)
                                                              .getPatientDebtsModel!
                                                              .data[index]
                                                              .id,
                                                          1
                                                      );
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'بيان',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            // const SizedBox(
                                            //   width: 35,
                                            // ),
                                            // Container(
                                            //   width: 100,
                                            //   height: 35,
                                            //   decoration: BoxDecoration(
                                            //     color: coolGreen1,
                                            //     borderRadius: BorderRadius.circular(30),
                                            //   ),
                                            //   child: InkWell(
                                            //     onTap: () {
                                            //       addNewPaymentDialog(
                                            //           context,
                                            //           DrAidCubit.get(context)
                                            //               .getPatientDebtsModel!
                                            //               .data[index]
                                            //               .treatmentPlanNumber,
                                            //           DrAidCubit.get(context)
                                            //               .getPatientDebtsModel!
                                            //               .data[index]
                                            //               .id,
                                            //                1
                                            //       );
                                            //     },
                                            //     child: const Center(
                                            //       child: Text(
                                            //         '  إضافة دفعة  ',
                                            //         style: TextStyle(
                                            //           fontSize: 12,
                                            //           color: Colors.white,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            if(screenWidth>=1000)
                                              const SizedBox(width: 20,),
                                            if(screenWidth<1000)
                                              const SizedBox(width: 20,),

                                            if(screenWidth>=1000)
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
                                        .getPatientDebtsModel!
                                        .data
                                        .length,
                                  ),
                                );
                                // return Expanded(
                                //   child: ListView.separated(
                                //     itemBuilder: (context, index) {
                                //       return Padding(
                                //         padding:
                                //         const EdgeInsetsDirectional.only(start: 10),
                                //         child: Row(
                                //           //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //           children: [
                                //             // const SizedBox(
                                //             //   width: 80,
                                //             // ),
                                //             Expanded(
                                //               child: Text(
                                //                 // 'محمد محمد',
                                //                 '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].patientName}',
                                //                 style: const TextStyle(
                                //                     fontSize: 16, color: fontColor),
                                //               ),
                                //             ),
                                //             Expanded(
                                //               child: Text(
                                //                 //  '200,000 ل.س',
                                //                 ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].totalCost}ل.س ',
                                //                 style: const TextStyle(
                                //                     fontSize: 16, color: fontColor),
                                //               ),
                                //             ),
                                //
                                //             Expanded(
                                //               child: Text(
                                //                 //  '200,000 ل.س',
                                //                 ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].remainingAmount}ل.س ',
                                //                 style: const TextStyle(
                                //                     fontSize: 16, color: fontColor),
                                //               ),
                                //             ),
                                //
                                //             Expanded(
                                //               child: Text(
                                //                 // '1',
                                //                 '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].treatmentPlanNumber}',
                                //                 style: const TextStyle(
                                //                     fontSize: 16, color: fontColor),
                                //               ),
                                //             ),
                                //              if(screenWidth>=800)
                                //             Container(
                                //               width: 130,
                                //               height: 35,
                                //               decoration: BoxDecoration(
                                //                 color: blueText,
                                //                 borderRadius: BorderRadius.circular(30),
                                //               ),
                                //               child: InkWell(
                                //                   onTap: () {
                                //                     showPatientAccount(
                                //                       context,
                                //                       DrAidCubit.get(context)
                                //                           .getPatientDebtsModel!
                                //                           .data[index]
                                //                           .treatmentPlanNumber,
                                //                       DrAidCubit.get(context)
                                //                           .getPatientDebtsModel!
                                //                           .data[index]
                                //                           .id,
                                //                            1
                                //                     );
                                //                   },
                                //                   child: const Center(
                                //                     child: Text(
                                //                       '  بيان حساب المريض  ',
                                //                       style: TextStyle(
                                //                         fontSize: 12,
                                //                         color: Colors.white,
                                //                       ),
                                //                     ),
                                //                   )),
                                //             ),
                                //             if(screenWidth<800)
                                //             Container(
                                //               width: 80,
                                //               height: 35,
                                //               decoration: BoxDecoration(
                                //                 color: blueText,
                                //                 borderRadius: BorderRadius.circular(30),
                                //               ),
                                //               child: InkWell(
                                //                   onTap: () {
                                //                     showPatientAccount(
                                //                         context,
                                //                         DrAidCubit.get(context)
                                //                             .getPatientDebtsModel!
                                //                             .data[index]
                                //                             .treatmentPlanNumber,
                                //                         DrAidCubit.get(context)
                                //                             .getPatientDebtsModel!
                                //                             .data[index]
                                //                             .id,
                                //                         1
                                //                     );
                                //                   },
                                //                   child: const Center(
                                //                     child: Text(
                                //                       'بيان',
                                //                       style: TextStyle(
                                //                         fontSize: 12,
                                //                         color: Colors.white,
                                //                       ),
                                //                     ),
                                //                   )),
                                //             ),
                                //             // const SizedBox(
                                //             //   width: 35,
                                //             // ),
                                //             // Container(
                                //             //   width: 100,
                                //             //   height: 35,
                                //             //   decoration: BoxDecoration(
                                //             //     color: coolGreen1,
                                //             //     borderRadius: BorderRadius.circular(30),
                                //             //   ),
                                //             //   child: InkWell(
                                //             //     onTap: () {
                                //             //       addNewPaymentDialog(
                                //             //           context,
                                //             //           DrAidCubit.get(context)
                                //             //               .getPatientDebtsModel!
                                //             //               .data[index]
                                //             //               .treatmentPlanNumber,
                                //             //           DrAidCubit.get(context)
                                //             //               .getPatientDebtsModel!
                                //             //               .data[index]
                                //             //               .id,
                                //             //                1
                                //             //       );
                                //             //     },
                                //             //     child: const Center(
                                //             //       child: Text(
                                //             //         '  إضافة دفعة  ',
                                //             //         style: TextStyle(
                                //             //           fontSize: 12,
                                //             //           color: Colors.white,
                                //             //         ),
                                //             //       ),
                                //             //     ),
                                //             //   ),
                                //             // ),
                                //             if(screenWidth>=800)
                                //             const SizedBox(width: 20,),
                                //             if(screenWidth<800)
                                //             const SizedBox(width: 20,),
                                //
                                //             if(screenWidth>=800)
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
                                //     itemCount: DrAidCubit.get(context)
                                //         .getPatientDebtsModel!
                                //         .data
                                //         .length,
                                //   ),
                                // );
                              }
                              else {
                                if (DrAidCubit.get(context)
                                    .getPatientDebtsModel
                                    ?.data
                                    .length !=
                                    null &&
                                    DrAidCubit.get(context)
                                        .getPatientDebtsModel
                                        ?.data
                                        .length !=
                                        0) {

                                  return Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(start: 10),
                                          child: Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // const SizedBox(
                                              //   width: 80,
                                              // ),
                                              Expanded(
                                                child: Text(
                                                  // 'محمد محمد',
                                                  '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].patientName}',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  //  '200,000 ل.س',
                                                  ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].totalCost}ل.س ',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),

                                              Expanded(
                                                child: Text(
                                                  //  '200,000 ل.س',
                                                  ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].remainingAmount}ل.س ',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),

                                              Expanded(
                                                child: Text(
                                                  // '1',
                                                  '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].treatmentPlanNumber}',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),
                                              if(screenWidth>=1000)
                                                Container(
                                                  width: 130,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        showPatientAccount(
                                                            context,
                                                            DrAidCubit.get(context)
                                                                .getPatientDebtsModel!
                                                                .data[index]
                                                                .treatmentPlanNumber,
                                                            DrAidCubit.get(context)
                                                                .getPatientDebtsModel!
                                                                .data[index]
                                                                .id,
                                                            1
                                                        );
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          '  بيان حساب المريض  ',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              if(screenWidth<1000)
                                                Container(
                                                  width: 80,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        showPatientAccount(
                                                            context,
                                                            DrAidCubit.get(context)
                                                                .getPatientDebtsModel!
                                                                .data[index]
                                                                .treatmentPlanNumber,
                                                            DrAidCubit.get(context)
                                                                .getPatientDebtsModel!
                                                                .data[index]
                                                                .id,
                                                            1
                                                        );
                                                      },
                                                      child: const Center(
                                                        child: Text(
                                                          'بيان',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              // const SizedBox(
                                              //   width: 35,
                                              // ),
                                              // Container(
                                              //   width: 100,
                                              //   height: 35,
                                              //   decoration: BoxDecoration(
                                              //     color: coolGreen1,
                                              //     borderRadius: BorderRadius.circular(30),
                                              //   ),
                                              //   child: InkWell(
                                              //     onTap: () {
                                              //       addNewPaymentDialog(
                                              //           context,
                                              //           DrAidCubit.get(context)
                                              //               .getPatientDebtsModel!
                                              //               .data[index]
                                              //               .treatmentPlanNumber,
                                              //           DrAidCubit.get(context)
                                              //               .getPatientDebtsModel!
                                              //               .data[index]
                                              //               .id,
                                              //                1
                                              //       );
                                              //     },
                                              //     child: const Center(
                                              //       child: Text(
                                              //         '  إضافة دفعة  ',
                                              //         style: TextStyle(
                                              //           fontSize: 12,
                                              //           color: Colors.white,
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                              if(screenWidth>=1000)
                                                const SizedBox(width: 20,),
                                              if(screenWidth<1000)
                                                const SizedBox(width: 20,),

                                              if(screenWidth>=1000)
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
                                          .getPatientDebtsModel!
                                          .data
                                          .length,
                                    ),
                                  );



                                  // return Expanded(
                                  //   child: ListView.separated(
                                  //     itemBuilder: (context, index) {
                                  //       return Padding(
                                  //         padding: const EdgeInsetsDirectional.only(
                                  //             start: 10),
                                  //         child: Row(
                                  //           //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //           children: [
                                  //             // const SizedBox(
                                  //             //   width: 80,
                                  //             // ),
                                  //             Expanded(
                                  //               child: Text(
                                  //                 // 'محمد محمد',
                                  //                 '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].patientName}',
                                  //                 style: const TextStyle(
                                  //                     fontSize: 16, color: fontColor),
                                  //               ),
                                  //             ),
                                  //             Expanded(
                                  //               child: Text(
                                  //                 //  '200,000 ل.س',
                                  //                 ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].totalCost}ل.س ',
                                  //                 style: const TextStyle(
                                  //                     fontSize: 16, color: fontColor),
                                  //               ),
                                  //             ),
                                  //
                                  //             Expanded(
                                  //               child: Text(
                                  //                 //  '200,000 ل.س',
                                  //                 ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].remainingAmount}ل.س ',
                                  //                 style: const TextStyle(
                                  //                     fontSize: 16, color: fontColor),
                                  //               ),
                                  //             ),
                                  //
                                  //             Expanded(
                                  //               child: Text(
                                  //                 // '1',
                                  //                 '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].treatmentPlanNumber}',
                                  //                 style: const TextStyle(
                                  //                     fontSize: 16, color: fontColor),
                                  //               ),
                                  //             ),
                                  //
                                  //             Container(
                                  //               width: 130,
                                  //               height: 35,
                                  //               decoration: BoxDecoration(
                                  //                 color: blueText,
                                  //                 borderRadius:
                                  //                 BorderRadius.circular(30),
                                  //               ),
                                  //               child: InkWell(
                                  //                   onTap: () {
                                  //                     showPatientAccount(
                                  //                         context,
                                  //                         DrAidCubit.get(context)
                                  //                             .getPatientDebtsModel!
                                  //                             .data[index]
                                  //                             .treatmentPlanNumber,
                                  //                         DrAidCubit.get(context)
                                  //                             .getPatientDebtsModel!
                                  //                             .data[index]
                                  //                             .id,
                                  //                         1
                                  //                     );
                                  //                     // showPatientAccount(
                                  //                     //     context,
                                  //                     //     DrAidCubit.get(context)
                                  //                     //         .getPatientPaymentsModel!
                                  //                     //         .data[index]
                                  //                     //         .treatmentPlanId,
                                  //                     //     DrAidCubit.get(context)
                                  //                     //         .getPatientPaymentsModel!
                                  //                     //         .data[index]
                                  //                     //         .patientId,
                                  //                     //     DrAidCubit.get(context)
                                  //                     //         .getPatientPaymentsModel!
                                  //                     //         .data[index]
                                  //                     //         .clinicId);
                                  //                   },
                                  //                   child: const Center(
                                  //                     child: Text(
                                  //                       '  بيان حساب المريض  ',
                                  //                       style: TextStyle(
                                  //                         fontSize: 12,
                                  //                         color: Colors.white,
                                  //                       ),
                                  //                     ),
                                  //                   )),
                                  //             ),
                                  //             // const SizedBox(
                                  //             //   width: 35,
                                  //             // ),
                                  //             // Container(
                                  //             //   width: 100,
                                  //             //   height: 35,
                                  //             //   decoration: BoxDecoration(
                                  //             //     color: coolGreen1,
                                  //             //     borderRadius:
                                  //             //     BorderRadius.circular(30),
                                  //             //   ),
                                  //             //   child: InkWell(
                                  //             //     onTap: () {
                                  //             //
                                  //             //       addNewPaymentDialog(
                                  //             //           context,
                                  //             //           DrAidCubit.get(context)
                                  //             //               .getPatientDebtsModel!
                                  //             //               .data[index]
                                  //             //               .treatmentPlanNumber,
                                  //             //           DrAidCubit.get(context)
                                  //             //               .getPatientDebtsModel!
                                  //             //               .data[index]
                                  //             //               .id,
                                  //             //           1
                                  //             //       );
                                  //             //
                                  //             //       // addNewPaymentDialog(
                                  //             //       //     context,
                                  //             //       //     DrAidCubit.get(context)
                                  //             //       //         .getPatientPaymentsModel!
                                  //             //       //         .data[index]
                                  //             //       //         .treatmentPlanId,
                                  //             //       //     DrAidCubit.get(context)
                                  //             //       //         .getPatientPaymentsModel!
                                  //             //       //         .data[index]
                                  //             //       //         .patientId,
                                  //             //       //     DrAidCubit.get(context)
                                  //             //       //         .getPatientPaymentsModel!
                                  //             //       //         .data[index]
                                  //             //       //         .clinicId);
                                  //             //     },
                                  //             //     child: const Center(
                                  //             //       child: Text(
                                  //             //         '  إضافة دفعة  ',
                                  //             //         style: TextStyle(
                                  //             //           fontSize: 12,
                                  //             //           color: Colors.white,
                                  //             //         ),
                                  //             //       ),
                                  //             //     ),
                                  //             //   ),
                                  //             // ),
                                  //             const SizedBox(width: 20,),
                                  //
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
                                  //     itemCount: DrAidCubit.get(context)
                                  //         .getPatientDebtsModel!
                                  //         .data
                                  //         .length,
                                  //   ),
                                  // );
                                } else {
                                  return const Center(child: Text('حدث خطأ ما أو لا يوجد ديون',style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 24
                                  ),
                                  ),
                                  );

                                  // return Expanded(
                                  //   child: ListView.separated(
                                  //       itemBuilder: (context, index) {
                                  //         return Padding(
                                  //           padding: const EdgeInsetsDirectional.only(
                                  //               start: 10),
                                  //           child: Row(
                                  //             //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //             children: [
                                  //               // const SizedBox(
                                  //               //   width: 80,
                                  //               // ),
                                  //                Text(
                                  //                // 'محمد محمد',
                                  //                 '${DrAidCubit.get(context).getPatientDebtsModel?.data[0].patientName}',
                                  //                 style: TextStyle(
                                  //                     fontSize: 16, color: fontColor),
                                  //               ),
                                  //               const SizedBox(
                                  //                 width: 70,
                                  //               ),
                                  //               const Text(
                                  //                 '200,000 ل.س',
                                  //                 style: TextStyle(
                                  //                     fontSize: 16, color: fontColor),
                                  //               ),
                                  //               const SizedBox(
                                  //                 width: 100,
                                  //               ),
                                  //               const Text(
                                  //                 '1',
                                  //                 style: TextStyle(
                                  //                     fontSize: 16, color: fontColor),
                                  //               ),
                                  //               const SizedBox(
                                  //                 width: 120,
                                  //               ),
                                  //               Container(
                                  //                 width: 130,
                                  //                 height: 35,
                                  //                 decoration: BoxDecoration(
                                  //                   color: blueText,
                                  //                   borderRadius:
                                  //                   BorderRadius.circular(30),
                                  //                 ),
                                  //                 child: InkWell(
                                  //                     onTap: () {},
                                  //                     child: const Center(
                                  //                       child: Text(
                                  //                         '  بيان حساب المريض  ',
                                  //                         style: TextStyle(
                                  //                           fontSize: 12,
                                  //                           color: Colors.white,
                                  //                         ),
                                  //                       ),
                                  //                     )),
                                  //               ),
                                  //               const SizedBox(
                                  //                 width: 65,
                                  //               ),
                                  //               Container(
                                  //                 width: 100,
                                  //                 height: 35,
                                  //                 decoration: BoxDecoration(
                                  //                   color: coolGreen1,
                                  //                   borderRadius:
                                  //                   BorderRadius.circular(30),
                                  //                 ),
                                  //                 child: InkWell(
                                  //                   onTap: () {
                                  //                     // addNewPaymentDialog(context,index);
                                  //                   },
                                  //                   child: const Center(
                                  //                     child: Text(
                                  //                       '  إضافة دفعة  ',
                                  //                       style: TextStyle(
                                  //                         fontSize: 12,
                                  //                         color: Colors.white,
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               const SizedBox(
                                  //                 width: 80,
                                  //               ),
                                  //
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
                                  //       itemCount: 30),
                                  // );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              else{
                return Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        const Divider(
                          color: dividerColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Builder(
                          builder: (context) {
                            if(state is DrAidGetPatientDebtsErrorState)
                            {
                              return const Center(
                                child: Text('something went wrong'),
                              );
                            }
                            else if(state is DrAidGetPatientDebtsSuccessState&& DrAidCubit.get(context).getPatientDebtsModel!.data.isEmpty)
                            {
                              return const Center(
                                child: Text('No patients with debtsً'),
                              );

                            }
                            else if (state is DrAidGetPatientDebtsLoadingState) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            else if (state is DrAidGetPatientDebtsSuccessState||DrAidCubit.get(context).getPatientDebtsModel?.data.length!=null)
                            {
                              return Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                      const EdgeInsetsDirectional.only(start: 10),
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // const SizedBox(
                                          //   width: 80,
                                          // ),
                                          Expanded(
                                            child: Text(
                                              // 'محمد محمد',
                                              '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].patientName}',
                                              style: const TextStyle(
                                                  fontSize: 16, color: fontColor),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              //  '200,000 ل.س',
                                              ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].totalCost}ل.س ',
                                              style: const TextStyle(
                                                  fontSize: 16, color: fontColor),
                                            ),
                                          ),

                                          Expanded(
                                            child: Text(
                                              //  '200,000 ل.س',
                                              ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].remainingAmount}ل.س ',
                                              style: const TextStyle(
                                                  fontSize: 16, color: fontColor),
                                            ),
                                          ),

                                          Expanded(
                                            child: Text(
                                              // '1',
                                              '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].treatmentPlanNumber}',
                                              style: const TextStyle(
                                                  fontSize: 16, color: fontColor),
                                            ),
                                          ),
                                          if(screenWidth>=1000)
                                            Container(
                                              width: 130,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: blueText,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                  onTap: () {
                                                    showPatientAccount(
                                                        context,
                                                        DrAidCubit.get(context)
                                                            .getPatientDebtsModel!
                                                            .data[index]
                                                            .treatmentPlanNumber,
                                                        DrAidCubit.get(context)
                                                            .getPatientDebtsModel!
                                                            .data[index]
                                                            .id,
                                                        1
                                                    );
                                                  },
                                                  child: const Center(
                                                    child: Text(
                                                      '  Show Account  ',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          if(screenWidth<1000)
                                            Container(
                                              width: 80,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: blueText,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                  onTap: () {
                                                    showPatientAccount(
                                                        context,
                                                        DrAidCubit.get(context)
                                                            .getPatientDebtsModel!
                                                            .data[index]
                                                            .treatmentPlanNumber,
                                                        DrAidCubit.get(context)
                                                            .getPatientDebtsModel!
                                                            .data[index]
                                                            .id,
                                                        1
                                                    );
                                                  },
                                                  child: const Center(
                                                    child: Text(
                                                      'Show',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )),
                                            ),

                                          if(screenWidth>=1000)
                                            const SizedBox(width: 20,),
                                          if(screenWidth<1000)
                                            const SizedBox(width: 20,),

                                          if(screenWidth>=1000)
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
                                      .getPatientDebtsModel!
                                      .data
                                      .length,
                                ),
                              );

                            }
                            else {
                              if (DrAidCubit.get(context)
                                  .getPatientDebtsModel
                                  ?.data
                                  .length !=
                                  null &&
                                  DrAidCubit.get(context)
                                      .getPatientDebtsModel
                                      ?.data
                                      .length !=
                                      0) {

                                return Expanded(
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(start: 10),
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // const SizedBox(
                                            //   width: 80,
                                            // ),
                                            Expanded(
                                              child: Text(
                                                // 'محمد محمد',
                                                '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].patientName}',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                //  '200,000 ل.س',
                                                ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].totalCost}ل.س ',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),

                                            Expanded(
                                              child: Text(
                                                //  '200,000 ل.س',
                                                ' ${DrAidCubit.get(context).getPatientDebtsModel?.data[index].remainingAmount}ل.س ',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),

                                            Expanded(
                                              child: Text(
                                                // '1',
                                                '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].treatmentPlanNumber}',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),
                                            if(screenWidth>=1000)
                                              Container(
                                                width: 130,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      showPatientAccount(
                                                          context,
                                                          DrAidCubit.get(context)
                                                              .getPatientDebtsModel!
                                                              .data[index]
                                                              .treatmentPlanNumber,
                                                          DrAidCubit.get(context)
                                                              .getPatientDebtsModel!
                                                              .data[index]
                                                              .id,
                                                          1
                                                      );
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        '  Show Account  ',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            if(screenWidth<1000)
                                              Container(
                                                width: 80,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                    onTap: () {
                                                      showPatientAccount(
                                                          context,
                                                          DrAidCubit.get(context)
                                                              .getPatientDebtsModel!
                                                              .data[index]
                                                              .treatmentPlanNumber,
                                                          DrAidCubit.get(context)
                                                              .getPatientDebtsModel!
                                                              .data[index]
                                                              .id,
                                                          1
                                                      );
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'Show',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )),
                                              ),

                                            if(screenWidth>=1000)
                                              const SizedBox(width: 20,),
                                            if(screenWidth<1000)
                                              const SizedBox(width: 20,),

                                            if(screenWidth>=1000)
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
                                        .getPatientDebtsModel!
                                        .data
                                        .length,
                                  ),
                                );



                              } else {
                                return const Center(child: Text('Something went wrong',style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 24
                                ),
                                ),
                                );


                              }
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
        });







    // return Padding(
    //   padding: const EdgeInsetsDirectional.only(end: 50.0),
    //   child: Container(
    //     width: MediaQuery.of(context).size.width * 0.9,
    //     height: 300,
    //     decoration: BoxDecoration(
    //         color: Colors.white, borderRadius: BorderRadius.circular(30)),
    //     child: Column(
    //       children: [
    //         const SizedBox(
    //           height: 35,
    //         ),
    //         const Padding(
    //           padding: EdgeInsetsDirectional.only(start: 10),
    //           child: Row(
    //             //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Text(
    //                 'المريض',
    //                 style: TextStyle(fontSize: 18, color: fontColor),
    //               ),
    //               SizedBox(
    //                 width: 100,
    //               ),
    //               Text(
    //                 'دفعة',
    //                 style: TextStyle(fontSize: 18, color: fontColor),
    //               ),
    //               SizedBox(
    //                 width: 110,
    //               ),
    //               Text(
    //                 'الخطة العلاجية',
    //                 style: TextStyle(fontSize: 18, color: fontColor),
    //               ),
    //               SizedBox(
    //                 width: 80,
    //               ),
    //               Text(
    //                 'بيان حساب',
    //                 style: TextStyle(fontSize: 18, color: fontColor),
    //               ),
    //               SizedBox(
    //                 width: 100,
    //               ),
    //               Text(
    //                 'الدفعات',
    //                 style: TextStyle(fontSize: 18, color: fontColor),
    //               ),
    //               SizedBox(
    //                 width: 90,
    //               ),
    //               Text(
    //                 'الخيارات',
    //                 style: TextStyle(fontSize: 18, color: fontColor),
    //               ),
    //               SizedBox(
    //                 width: 80,
    //               ),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         const Divider(
    //           color: dividerColor,
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Expanded(
    //           child: ListView.separated(
    //               itemBuilder: (context, index) {
    //                 return Padding(
    //                   padding: const EdgeInsetsDirectional.only(start: 10),
    //                   child: Row(
    //                     //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: [
    //                       // const SizedBox(
    //                       //   width: 80,
    //                       // ),
    //                        Text(
    //                         //'محمد محمد',
    //                         '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].patientName}',
    //                         style: TextStyle(fontSize: 16, color: fontColor),
    //                       ),
    //                       const SizedBox(
    //                         width: 70,
    //                       ),
    //                        Text(
    //                         '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].remainingAmount} ل.س',
    //                         style: TextStyle(fontSize: 16, color: fontColor),
    //                       ),
    //                       const SizedBox(
    //                         width: 100,
    //                       ),
    //                        Text(
    //                         '${DrAidCubit.get(context).getPatientDebtsModel?.data[index].treatmentPlanNumber}',
    //                         style: TextStyle(fontSize: 16, color: fontColor),
    //                       ),
    //                       const SizedBox(
    //                         width: 120,
    //                       ),
    //                       Container(
    //                         width: 130,
    //                         height: 35,
    //                         decoration: BoxDecoration(
    //                           color: blueText,
    //                           borderRadius: BorderRadius.circular(30),
    //                         ),
    //                         child: InkWell(
    //                             onTap: () {},
    //                             child: const Center(
    //                               child: Text(
    //                                 '  بيان حساب المريض  ',
    //                                 style: TextStyle(
    //                                   fontSize: 12,
    //                                   color: Colors.white,
    //                                 ),
    //                               ),
    //                             )),
    //                       ),
    //                       const SizedBox(
    //                         width: 65,
    //                       ),
    //                       Container(
    //                         width: 100,
    //                         height: 35,
    //                         decoration: BoxDecoration(
    //                           color: coolGreen1,
    //                           borderRadius: BorderRadius.circular(30),
    //                         ),
    //                         child: InkWell(
    //                           onTap: () {},
    //                           child: const Center(
    //                             child: Text(
    //                               '  إضافة دفعة  ',
    //                               style: TextStyle(
    //                                 fontSize: 12,
    //                                 color: Colors.white,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         width: 80,
    //                       ),
    //
    //                       Container(
    //                         width: 70,
    //                         height: 40,
    //                         color: Colors.white,
    //                         child: const Center(
    //                           child: Row(
    //                             children: [
    //                               Image(
    //                                 image: AssetImage(
    //                                   'images/edit1.png',
    //                                 ),
    //                                 width: 25,
    //                                 height: 25,
    //                               ),
    //                               SizedBox(
    //                                 width: 10,
    //                               ),
    //                               Image(
    //                                 image: AssetImage(
    //                                   'images/delete.png',
    //                                 ),
    //                                 width: 30,
    //                                 height: 30,
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               },
    //               separatorBuilder: (context, index) {
    //                 return const Divider(
    //                   color: borderColor,
    //                 );
    //               },
    //               itemCount: DrAidCubit.get(context).getPatientDebtsModel!.data.length+1),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
