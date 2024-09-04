// ignore_for_file: must_be_immutable, unrelated_type_equality_checks, prefer_is_empty

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowBillInformation extends StatelessWidget {
  TextEditingController addPaymentForBillController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController providerNameController = TextEditingController();
  double screenWidth1=1000;


  ShowBillInformation({super.key});
  void addNewPaymentForBillDialog(BuildContext context, int index) {
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
                      'إضافة دفعة لفاتورة',
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
                                        controller: addPaymentForBillController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter your email address';
                                          }
                                          return null;
                                        },
                                        label: 'اختر المبلغ '),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          const Spacer(),
                          InkWell(
                            onTap: () {
                              DrAidCubit.get(context).addPayment(
                                billId: index,
                                amount: int.parse(addPaymentForBillController.text),
                              );

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
                                    'إضافة',
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
          else{
            return Directionality(
              textDirection: TextDirection.ltr,
              child: SimpleDialog(
                title: const Padding(
                  padding: EdgeInsetsDirectional.only(start: 30),
                  child: Text(
                    'Add bill\'s payment',
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
                                      controller: addPaymentForBillController,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your email address';
                                        }
                                        return null;
                                      },
                                      label: 'Select amount '),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        const Spacer(),
                        InkWell(
                          onTap: () {
                            DrAidCubit.get(context).addPayment(
                              billId: index,
                              amount: int.parse(addPaymentForBillController.text),
                            );

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
                                  'Add',
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
  void addNewBill(BuildContext context, ) {
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
                        'إضافة فاتورة جديدة',
                        style: TextStyle(
                          fontSize: 18,
                          color: simpleDialogTitleColor,
                        ),
                      ),
                    ),
                    children: <Widget>[

                      Builder(
                          builder: (context) {

                            if(screenWidth1>1200)
                            {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 350,

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
                                                  type: TextInputType.emailAddress,
                                                  controller: typeController,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter your email address';
                                                    }
                                                    return null;
                                                  },
                                                  label: 'اختر النوع '),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
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
                                                  type: TextInputType.emailAddress,
                                                  controller: totalController,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter your email address';
                                                    }
                                                    return null;
                                                  },
                                                  label: 'قيمة الفاتورة '),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
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
                                                  type: TextInputType.emailAddress,
                                                  controller: contentController,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter your email address';
                                                    }
                                                    return null;
                                                  },
                                                  label: 'المحتوى '),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
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


                                        ],
                                      ),
                                    ),

                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        if(typeController.text=='MATERIALS'){

                                          String totalString=totalController.text;
                                          int? totalInt=int.tryParse(totalString);
                                          if(totalInt!=null&&typeController.text!=''&&contentController.text!=''&&providerNameController!='')

                                          {
                                            DrAidCubit.get(context).createBill(
                                                type: typeController.text,
                                                total:totalInt ,
                                                content: contentController.text,
                                                provider: providerNameController.text
                                            );


                                          }

                                        }


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
                                              'إضافة',
                                              style: TextStyle(
                                                  fontSize: 18, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              );
                            }
                            else {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 350,

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
                                                  type: TextInputType.emailAddress,
                                                  controller: typeController,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter your email address';
                                                    }
                                                    return null;
                                                  },
                                                  label: 'اختر النوع '),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
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
                                                  type: TextInputType.emailAddress,
                                                  controller: totalController,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter your email address';
                                                    }
                                                    return null;
                                                  },
                                                  label: 'قيمة الفاتورة '),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
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
                                                  type: TextInputType.emailAddress,
                                                  controller: contentController,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please Enter your email address';
                                                    }
                                                    return null;
                                                  },
                                                  label: 'المحتوى '),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
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


                                        ],
                                      ),
                                    ),

                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        String totalString=totalController.text;
                                        int? totalInt=int.tryParse(totalString);
                                        if(totalInt!=null&&typeController.text!=''&&contentController.text!=''&&providerNameController!='')

                                        {
                                          DrAidCubit.get(context).createBill(
                                              type: typeController.text,
                                              total:totalInt ,
                                              content: contentController.text,
                                              provider: providerNameController.text
                                          );


                                        }

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
                                              'إضافة',
                                              style: TextStyle(
                                                  fontSize: 18, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              );
                            }

                          }
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
                      'Add new bill',
                      style: TextStyle(
                        fontSize: 18,
                        color: simpleDialogTitleColor,
                      ),
                    ),
                  ),
                  children: <Widget>[

                    Builder(
                        builder: (context) {

                          if(screenWidth1>1200)
                          {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 350,

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
                                                type: TextInputType.emailAddress,
                                                controller: typeController,
                                                validate: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please Enter your email address';
                                                  }
                                                  return null;
                                                },
                                                label: 'اChoose type '),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
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
                                                type: TextInputType.emailAddress,
                                                controller: totalController,
                                                validate: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please Enter your email address';
                                                  }
                                                  return null;
                                                },
                                                label: 'Invoice value '),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
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
                                                type: TextInputType.emailAddress,
                                                controller: contentController,
                                                validate: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please Enter your email address';
                                                  }
                                                  return null;
                                                },
                                                label: 'Content '),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
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


                                      ],
                                    ),
                                  ),

                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      if(typeController.text=='MATERIALS'){

                                        String totalString=totalController.text;
                                        int? totalInt=int.tryParse(totalString);
                                        if(totalInt!=null&&typeController.text!=''&&contentController.text!=''&&providerNameController!='')

                                        {
                                          DrAidCubit.get(context).createBill(
                                              type: typeController.text,
                                              total:totalInt ,
                                              content: contentController.text,
                                              provider: providerNameController.text
                                          );


                                        }

                                      }
                                      // String totalString=totalController.text;
                                      // int? totalInt=int.tryParse(totalString);
                                      // if(totalInt!=null&&typeController.text!=''&&contentController.text!=''&&providerNameController!='')
                                      //
                                      // {
                                      //   DrAidCubit.get(context).createBill(
                                      //       type: typeController.text,
                                      //       total:totalInt ,
                                      //       content: contentController.text,
                                      //       provider: providerNameController.text
                                      //   );
                                      //
                                      //
                                      // }

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
                                            'Add',
                                            style: TextStyle(
                                                fontSize: 18, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            );
                          }
                          else {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 350,

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
                                                type: TextInputType.emailAddress,
                                                controller: typeController,
                                                validate: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please Enter your email address';
                                                  }
                                                  return null;
                                                },
                                                label: 'Choose type '),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
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
                                                type: TextInputType.emailAddress,
                                                controller: totalController,
                                                validate: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please Enter your email address';
                                                  }
                                                  return null;
                                                },
                                                label: 'Invoice value '),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
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
                                                type: TextInputType.emailAddress,
                                                controller: contentController,
                                                validate: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please Enter your email address';
                                                  }
                                                  return null;
                                                },
                                                label: 'Content '),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
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


                                      ],
                                    ),
                                  ),

                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      String totalString=totalController.text;
                                      int? totalInt=int.tryParse(totalString);
                                      if(totalInt!=null&&typeController.text!=''&&contentController.text!=''&&providerNameController!='')

                                      {
                                        DrAidCubit.get(context).createBill(
                                            type: typeController.text,
                                            total:totalInt ,
                                            content: contentController.text,
                                            provider: providerNameController.text
                                        );


                                      }

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
                                            'Add',
                                            style: TextStyle(
                                                fontSize: 18, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            );
                          }

                        }
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
    screenWidth1=screenWidth;
    print('Screen width: $screenWidth1'); // This line prints the screen width in the console
    return BlocConsumer<DrAidCubit, DrAidStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Builder(

          builder: (context) {
            if(languagee=='arabic')
              {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(end: 80.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 450,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 130,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: coolGreen1,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: InkWell(
                                    onTap: () {

                                      addNewBill(context);

                                    },
                                    child: const Center(
                                      child: Text(
                                        '  إضافة فاتورة   ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        if(screenWidth>1530)
                          const Padding(
                            padding: EdgeInsetsDirectional.only(start: 30),
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'المعرّف',
                                  style: TextStyle(fontSize: 18, color: fontColor),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  'النوع',
                                  style: TextStyle(fontSize: 18, color: fontColor),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  'المحتوى',
                                  style: TextStyle(fontSize: 18, color: fontColor),
                                ),
                                SizedBox(
                                  width: 65,
                                ),
                                Text(
                                  'الاجمالي',
                                  style: TextStyle(fontSize: 18, color: fontColor),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Text(
                                  'التاريخ',
                                  style: TextStyle(fontSize: 18, color: fontColor),
                                ),
                                SizedBox(
                                  width: 95,
                                ),
                                Text(
                                  'المزود',
                                  style: TextStyle(fontSize: 18, color: fontColor),
                                ),
                                SizedBox(
                                  width: 125,
                                ),
                                Text(
                                  'الدفعة',
                                  style: TextStyle(fontSize: 18, color: fontColor),
                                ),
                                SizedBox(
                                  width: 75,
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




                            //old
                            if (state is DrAidGetBillForClinicSuccessState) {
                              return Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(start: 30),
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            if(screenWidth>1400)
                                              Expanded(
                                                child: Text(
                                                  //'1',
                                                  '${DrAidCubit.get(context).getBillsForClinic?.data[index].id}',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),
                                            if(screenWidth>1400)
                                              Expanded(
                                                child: Text(
                                                  '${DrAidCubit.get(context).getBillsForClinic?.data[index].type}',
                                                  //'${DrAidCubit.get(context).getBillsForClinic?.data[index].type.substring(0, 4)}',
                                                  // 'مواد',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),
                                            if(screenWidth>1200)
                                              Expanded(
                                                child: Text(
                                                  //'جسور وحاصرات',
                                                  '${DrAidCubit.get(context).getBillsForClinic?.data[index].content}',

                                                  //'${DrAidCubit.get(context).getBillsForClinic?.data[index].content.substring(0, 10)}',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),

                                            Expanded(
                                              child: Text(
                                                '${DrAidCubit.get(context).getBillsForClinic?.data[index].total.toString()} ل.س',


                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),
                                            if(screenWidth>1200)
                                              Expanded(
                                                child: Text(

                                                  '${DrAidCubit.get(context).getBillsForClinic?.data[index].createdAt.toString().substring(0, 10)}',


                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),
                                            if(screenWidth>1200)
                                              Expanded(
                                                child: Text(
                                                  '${DrAidCubit.get(context).getBillsForClinic?.data[index].provider}',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),
                                            const SizedBox(
                                              width: 50,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                addNewPaymentForBillDialog(
                                                    context,
                                                    DrAidCubit.get(context)
                                                        .getBillsForClinic!
                                                        .data[index]
                                                        .id);
                                              },
                                              child: const CircleAvatar(
                                                backgroundColor: circulerAvatarColor,
                                                radius: 15,
                                                child: Icon(
                                                  Icons.add,
                                                  color: white,
                                                ),
                                              ),
                                            ),
                                            // const SizedBox(
                                            //   width: 50,
                                            // ),
                                            const SizedBox(
                                              width: 75,
                                            ),
                                            if(screenWidth>1200)
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
                                        .getBillsForClinic!
                                        .data
                                        .length),
                              );
                            }
                            if (DrAidCubit.get(context)
                                .getBillsForClinic
                            !.data.isEmpty) {
                              return const Column(
                                children: [
                                  Center(
                                    child: Text('لا يوجد فواتير بعد',style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.grey,
                                    ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (state is DrAidGetBillForClinicLoadingState) {
                              return const Center(child: CircularProgressIndicator());
                            } else {
                              if (DrAidCubit.get(context)
                                  .getBillsForClinic
                                  ?.data
                                  .length !=
                                  null ||
                                  DrAidCubit.get(context)
                                      .getBillsForClinic
                                      ?.data
                                      .length !=
                                      0||DrAidCubit.get(context)
                                  .getBillsForClinic
                              !.data.isNotEmpty) {
                                return


                                  Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsetsDirectional.only(
                                                start: 30),
                                            child: Row(

                                              children: [
                                                if(screenWidth>1400)
                                                  Expanded(
                                                    child: Text(
                                                      //'1',
                                                      '${DrAidCubit.get(context).getBillsForClinic?.data[index].id}',
                                                      style: const TextStyle(
                                                          fontSize: 16, color: fontColor),
                                                    ),
                                                  ),
                                                if(screenWidth>1400)
                                                  Expanded(
                                                    child: Text(
                                                      '${DrAidCubit.get(context).getBillsForClinic?.data[index].type}',
                                                      style: const TextStyle(
                                                          fontSize: 16, color: fontColor),
                                                    ),
                                                  ),
                                                if(screenWidth>1200)
                                                  Expanded(
                                                    child: Text(
                                                      '${DrAidCubit.get(context).getBillsForClinic?.data[index].content}',
                                                      style: const TextStyle(
                                                          fontSize: 16, color: fontColor),
                                                    ),
                                                  ),

                                                Expanded(
                                                  child: Text(
                                                    '${DrAidCubit.get(context).getBillsForClinic?.data[index].total.toString()} ل.س',
                                                    style: const TextStyle(
                                                        fontSize: 16, color: fontColor),
                                                  ),
                                                ),
                                                if(screenWidth>1200)
                                                  Expanded(
                                                    child: Text(
                                                      '${DrAidCubit.get(context).getBillsForClinic?.data[index].createdAt.toString().substring(0, 10)}',
                                                      style: const TextStyle(
                                                          fontSize: 16, color: fontColor),
                                                    ),
                                                  ),
                                                if(screenWidth>1200)
                                                  Expanded(
                                                    child: Text(
                                                      '${DrAidCubit.get(context).getBillsForClinic?.data[index].provider}',
                                                      style: const TextStyle(
                                                          fontSize: 16, color: fontColor),
                                                    ),
                                                  ),
                                                const SizedBox(
                                                  width: 50,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    addNewPaymentForBillDialog(
                                                        context,
                                                        DrAidCubit.get(context)
                                                            .getBillsForClinic!
                                                            .data[index]
                                                            .id);
                                                  },
                                                  child: const CircleAvatar(
                                                    backgroundColor: circulerAvatarColor,
                                                    radius: 15,
                                                    child: Icon(
                                                      Icons.add,
                                                      color: white,
                                                    ),
                                                  ),
                                                ),
                                                // const SizedBox(
                                                //   width: 50,
                                                // ),
                                                const SizedBox(
                                                  width: 75,
                                                ),
                                                if(screenWidth>1200)
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
                                            .getBillsForClinic!
                                            .data
                                            .length),
                                  );
                              }
                              else {
                                return const Center(
                                  child:
                                  Text('حدث خطأ ما',style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 24,
                                  ),
                                  ),
                                );
                              }

                              //old

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
                padding: const EdgeInsetsDirectional.only(end: 80.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 450,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 130,
                              height: 35,
                              decoration: BoxDecoration(
                                color: coolGreen1,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: InkWell(
                                  onTap: () {

                                    addNewBill(context);

                                  },
                                  child: const Center(
                                    child: Text(
                                      '  Add Bill  ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      if(screenWidth>1530)
                        const Padding(
                          padding: EdgeInsetsDirectional.only(start: 30),
                          child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Id',
                                style: TextStyle(fontSize: 18, color: fontColor),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Text(
                                'Type',
                                style: TextStyle(fontSize: 18, color: fontColor),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Text(
                                'Content',
                                style: TextStyle(fontSize: 18, color: fontColor),
                              ),
                              SizedBox(
                                width: 65,
                              ),
                              Text(
                                'All',
                                style: TextStyle(fontSize: 18, color: fontColor),
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Text(
                                'History',
                                style: TextStyle(fontSize: 18, color: fontColor),
                              ),
                              SizedBox(
                                width: 95,
                              ),
                              Text(
                                'Supplier',
                                style: TextStyle(fontSize: 18, color: fontColor),
                              ),
                              SizedBox(
                                width: 125,
                              ),
                              Text(
                                'Payment',
                                style: TextStyle(fontSize: 18, color: fontColor),
                              ),
                              SizedBox(
                                width: 75,
                              ),
                              Text(
                                'Options',
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




                          //old
                          if (state is DrAidGetBillForClinicSuccessState) {
                            return Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                      const EdgeInsetsDirectional.only(start: 30),
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if(screenWidth>1400)
                                            Expanded(
                                              child: Text(
                                                //'1',
                                                '${DrAidCubit.get(context).getBillsForClinic?.data[index].id}',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),
                                          if(screenWidth>1400)
                                            Expanded(
                                              child: Text(
                                                '${DrAidCubit.get(context).getBillsForClinic?.data[index].type}',
                                                //'${DrAidCubit.get(context).getBillsForClinic?.data[index].type.substring(0, 4)}',
                                                // 'مواد',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),
                                          if(screenWidth>1200)
                                            Expanded(
                                              child: Text(
                                                //'جسور وحاصرات',
                                                '${DrAidCubit.get(context).getBillsForClinic?.data[index].content}',

                                                //'${DrAidCubit.get(context).getBillsForClinic?.data[index].content.substring(0, 10)}',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),

                                          Expanded(
                                            child: Text(
                                              '${DrAidCubit.get(context).getBillsForClinic?.data[index].total.toString()} ل.س',


                                              style: const TextStyle(
                                                  fontSize: 16, color: fontColor),
                                            ),
                                          ),
                                          if(screenWidth>1200)
                                            Expanded(
                                              child: Text(

                                                '${DrAidCubit.get(context).getBillsForClinic?.data[index].createdAt.toString().substring(0, 10)}',


                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),
                                          if(screenWidth>1200)
                                            Expanded(
                                              child: Text(
                                                '${DrAidCubit.get(context).getBillsForClinic?.data[index].provider}',
                                                style: const TextStyle(
                                                    fontSize: 16, color: fontColor),
                                              ),
                                            ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              addNewPaymentForBillDialog(
                                                  context,
                                                  DrAidCubit.get(context)
                                                      .getBillsForClinic!
                                                      .data[index]
                                                      .id);
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor: circulerAvatarColor,
                                              radius: 15,
                                              child: Icon(
                                                Icons.add,
                                                color: white,
                                              ),
                                            ),
                                          ),
                                          // const SizedBox(
                                          //   width: 50,
                                          // ),
                                          const SizedBox(
                                            width: 75,
                                          ),
                                          if(screenWidth>1200)
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
                                      .getBillsForClinic!
                                      .data
                                      .length),
                            );
                          }
                          if (DrAidCubit.get(context)
                              .getBillsForClinic
                          !.data.isEmpty) {
                            return const Column(
                              children: [
                                Center(
                                  child: Text('No Bills yet',style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.grey,
                                  ),
                                  ),
                                ),
                              ],
                            );
                          }
                          if (state is DrAidGetBillForClinicLoadingState) {
                            return const Center(child: CircularProgressIndicator());
                          } else {
                            if (DrAidCubit.get(context)
                                .getBillsForClinic
                                ?.data
                                .length !=
                                null ||
                                DrAidCubit.get(context)
                                    .getBillsForClinic
                                    ?.data
                                    .length !=
                                    0||DrAidCubit.get(context)
                                .getBillsForClinic
                            !.data.isNotEmpty) {
                              return


                                Expanded(
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 30),
                                          child: Row(

                                            children: [
                                              if(screenWidth>1400)
                                                Expanded(
                                                  child: Text(
                                                    //'1',
                                                    '${DrAidCubit.get(context).getBillsForClinic?.data[index].id}',
                                                    style: const TextStyle(
                                                        fontSize: 16, color: fontColor),
                                                  ),
                                                ),
                                              if(screenWidth>1400)
                                                Expanded(
                                                  child: Text(
                                                    '${DrAidCubit.get(context).getBillsForClinic?.data[index].type}',
                                                    style: const TextStyle(
                                                        fontSize: 16, color: fontColor),
                                                  ),
                                                ),
                                              if(screenWidth>1200)
                                                Expanded(
                                                  child: Text(
                                                    '${DrAidCubit.get(context).getBillsForClinic?.data[index].content}',
                                                    style: const TextStyle(
                                                        fontSize: 16, color: fontColor),
                                                  ),
                                                ),

                                              Expanded(
                                                child: Text(
                                                  '${DrAidCubit.get(context).getBillsForClinic?.data[index].total.toString()} ل.س',
                                                  style: const TextStyle(
                                                      fontSize: 16, color: fontColor),
                                                ),
                                              ),
                                              if(screenWidth>1200)
                                                Expanded(
                                                  child: Text(
                                                    '${DrAidCubit.get(context).getBillsForClinic?.data[index].createdAt.toString().substring(0, 10)}',
                                                    style: const TextStyle(
                                                        fontSize: 16, color: fontColor),
                                                  ),
                                                ),
                                              if(screenWidth>1200)
                                                Expanded(
                                                  child: Text(
                                                    '${DrAidCubit.get(context).getBillsForClinic?.data[index].provider}',
                                                    style: const TextStyle(
                                                        fontSize: 16, color: fontColor),
                                                  ),
                                                ),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  addNewPaymentForBillDialog(
                                                      context,
                                                      DrAidCubit.get(context)
                                                          .getBillsForClinic!
                                                          .data[index]
                                                          .id);
                                                },
                                                child: const CircleAvatar(
                                                  backgroundColor: circulerAvatarColor,
                                                  radius: 15,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: white,
                                                  ),
                                                ),
                                              ),
                                              // const SizedBox(
                                              //   width: 50,
                                              // ),
                                              const SizedBox(
                                                width: 75,
                                              ),
                                              if(screenWidth>1200)
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
                                          .getBillsForClinic!
                                          .data
                                          .length),
                                );
                            }
                            else {
                              return const Center(
                                child:
                                Text('Something went wrong',style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 24,
                                ),
                                ),
                              );
                            }

                            //old

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

