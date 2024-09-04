// ignore_for_file: avoid_print

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/modules/sidebar/side_bar_screen.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddClinicScreen extends StatefulWidget {
  const AddClinicScreen({super.key});

  @override
  State<AddClinicScreen> createState() => _AddClinicScreenState();
}

class _AddClinicScreenState extends State<AddClinicScreen> {
  int index = 0;

  bool isExpanded = true;
  TextEditingController clinicName = TextEditingController();
  TextEditingController clinicAddress = TextEditingController();
  TextEditingController telephoneNumber = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController whatsAppNumber = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController ownerAddress = TextEditingController();
  TextEditingController ownerPhone = TextEditingController();

  Widget buildAddClinicItem(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    print(screenWidth);

    return Builder(
      builder: (context) {
        if(languagee=='arabic')
          {
            return Padding(
              padding: const EdgeInsetsDirectional.only(end: 175.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 550,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Builder(
                      builder: (context) {
                        if(screenWidth>=1520)
                        {
                          return Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'اسم العيادة',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                  SizedBox(
                                    width: 335,
                                  ),
                                  Text(
                                    'عنوان العيادة',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 400,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.text,
                                        controller: clinicName,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل اسم عيادتك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 50,
                                    width: 400,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.text,
                                        controller: clinicAddress,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل عنوان عيادتك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'اسم الطبيب المالك',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                  SizedBox(
                                    width: 260,
                                  ),
                                  Text(
                                    'عنوان الطبيب المالك',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 400,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.text,
                                        controller: ownerName,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل اسم الطبيب المالك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 50,
                                    width: 400,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.text,
                                        controller: ownerAddress,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل عنوان الطبيب المالك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    'البريد الإلكتروني للطبيب',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                  SizedBox(
                                    width: 215,
                                  ),
                                  Text(
                                    'رقم الطبيب المالك',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 400,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.emailAddress,
                                        controller: userEmail,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل بريداَ إلكترونياَ للطبيب المالك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 50,
                                    width: 400,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.number,
                                        controller: ownerPhone,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل رقم الطبيب المالك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    ' معلومات التواصل بالعيادة',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 250,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.number,
                                        controller: whatsAppNumber,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل رقم Whatsapp لعيادتك';
                                          }
                                          return null;
                                        },
                                        label: 'Whatsapp'),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 250,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.emailAddress,
                                        controller: phoneNumber,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل رقم جوال لعيادتك';
                                          }
                                          return null;
                                        },
                                        label: 'Call'),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 250,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.number,
                                        controller: telephoneNumber,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل رقم ثابت لعيادتك';
                                          }
                                          return null;
                                        },
                                        label: 'Line'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if(modee=='light')
                                InkWell(
                                  onTap: () {
                                    print("create clinic");

                                    DrAidCubit.get(context).createClinic(
                                        name: clinicName.text,
                                        address: clinicAddress.text,
                                        telePhoneNumber: telephoneNumber.text,
                                        phoneNumber: phoneNumber.text,
                                        whatsappNumber: whatsAppNumber.text,
                                        ownerName: ownerName.text,
                                        ownerEmail: userEmail.text,
                                        ownerAddress: ownerAddress.text,
                                        ownerPhone: ownerPhone.text);
                                    print("name: ${clinicName.text}");
                                    print("owner name: ${ownerName.text}");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: buttonColor),
                                    child: const Center(
                                      child: Text(
                                        'إضافة عيادة',
                                        style: TextStyle(fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              if(modee=='dark')
                                InkWell(
                                  onTap: () {
                                    print("create clinic");

                                    DrAidCubit.get(context).createClinic(
                                        name: clinicName.text,
                                        address: clinicAddress.text,
                                        telePhoneNumber: telephoneNumber.text,
                                        phoneNumber: phoneNumber.text,
                                        whatsappNumber: whatsAppNumber.text,
                                        ownerName: ownerName.text,
                                        ownerEmail: userEmail.text,
                                        ownerAddress: ownerAddress.text,
                                        ownerPhone: ownerPhone.text);
                                    print("name: ${clinicName.text}");
                                    print("owner name: ${ownerName.text}");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.orangeAccent),
                                    child: const Center(
                                      child: Text(
                                        'إضافة عيادة',
                                        style: TextStyle(fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )

                            ],
                          );
                        }
                        else{
                          return ListView(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'اسم العيادة',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.text,
                                        controller: clinicName,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل اسم عيادتك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),

                                  Text(
                                    'عنوان العيادة',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.text,
                                        controller: clinicAddress,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل عنوان عيادتك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'اسم الطبيب المالك',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.text,
                                        controller: ownerName,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل اسم الطبيب المالك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),

                                  Text(
                                    'عنوان الطبيب المالك',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.text,
                                        controller: ownerAddress,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل عنوان الطبيب المالك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'البريد الإلكتروني للطبيب',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.emailAddress,
                                        controller: userEmail,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل بريداَ إلكترونياَ للطبيب المالك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),

                                  Text(
                                    'رقم الطبيب المالك',
                                    style: TextStyle(fontSize: 24, color: fontColor),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.number,
                                        controller: ownerPhone,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل رقم الطبيب المالك';
                                          }
                                          return null;
                                        },
                                        label: 'الرجاء تعبئة الحقل'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        ' معلومات التواصل',
                                        style: TextStyle(fontSize: 24, color: fontColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.number,
                                        controller: whatsAppNumber,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل رقم Whatsapp لعيادتك';
                                          }
                                          return null;
                                        },
                                        label: 'Whatsapp'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.emailAddress,
                                        controller: phoneNumber,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل رقم جوال لعيادتك';
                                          }
                                          return null;
                                        },
                                        label: 'Call'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 200,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: ClinicFormField(
                                        type: TextInputType.number,
                                        controller: telephoneNumber,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'رجاءً ادخل رقم ثابت لعيادتك';
                                          }
                                          return null;
                                        },
                                        label: 'Line'),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if(modee=='light')
                                    InkWell(
                                      onTap: () {
                                        print("create clinic");

                                        DrAidCubit.get(context).createClinic(
                                            name: clinicName.text,
                                            address: clinicAddress.text,
                                            telePhoneNumber: telephoneNumber.text,
                                            phoneNumber: phoneNumber.text,
                                            whatsappNumber: whatsAppNumber.text,
                                            ownerName: ownerName.text,
                                            ownerEmail: userEmail.text,
                                            ownerAddress: ownerAddress.text,
                                            ownerPhone: ownerPhone.text);
                                        print("name: ${clinicName.text}");
                                        print("owner name: ${ownerName.text}");
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: buttonColor),
                                        child: const Center(
                                          child: Text(
                                            'إضافة عيادة',
                                            style: TextStyle(fontSize: 20, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if(modee=='dark')
                                    InkWell(
                                      onTap: () {
                                        print("create clinic");

                                        DrAidCubit.get(context).createClinic(
                                            name: clinicName.text,
                                            address: clinicAddress.text,
                                            telePhoneNumber: telephoneNumber.text,
                                            phoneNumber: phoneNumber.text,
                                            whatsappNumber: whatsAppNumber.text,
                                            ownerName: ownerName.text,
                                            ownerEmail: userEmail.text,
                                            ownerAddress: ownerAddress.text,
                                            ownerPhone: ownerPhone.text);
                                        print("name: ${clinicName.text}");
                                        print("owner name: ${ownerName.text}");
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.orangeAccent),
                                        child: const Center(
                                          child: Text(
                                            'إضافة عيادة',
                                            style: TextStyle(fontSize: 20, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          );
                        }

                      }
                  ),
                ),
              ),
            );
          }
        else{
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 175.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 550,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Builder(
                    builder: (context) {
                      if(screenWidth>=1520)
                      {
                        return Column(
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Clinic name',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                                SizedBox(
                                  width: 335,
                                ),
                                Text(
                                  'Clinic address',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 400,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.text,
                                      controller: clinicName,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter clinic name';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),
                                const Spacer(),
                                Container(
                                  height: 50,
                                  width: 400,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.text,
                                      controller: clinicAddress,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter clinic address';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Owner name',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                                SizedBox(
                                  width: 260,
                                ),
                                Text(
                                  'Owner address',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 400,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.text,
                                      controller: ownerName,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter owner name';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),
                                const Spacer(),
                                Container(
                                  height: 50,
                                  width: 400,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.text,
                                      controller: ownerAddress,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter owner address';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Doctor email',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                                SizedBox(
                                  width: 215,
                                ),
                                Text(
                                  'Phone number',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 400,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.emailAddress,
                                      controller: userEmail,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter email for owner';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),
                                const Spacer(),
                                Container(
                                  height: 50,
                                  width: 400,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.number,
                                      controller: ownerPhone,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter owner phone number';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Contact info',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 250,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.number,
                                      controller: whatsAppNumber,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter whatsapp number';
                                        }
                                        return null;
                                      },
                                      label: 'Whatsapp'),
                                ),
                                Container(
                                  height: 50,
                                  width: 250,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.emailAddress,
                                      controller: phoneNumber,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter phone number';
                                        }
                                        return null;
                                      },
                                      label: 'Call'),
                                ),
                                Container(
                                  height: 50,
                                  width: 250,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.number,
                                      controller: telephoneNumber,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter line number';
                                        }
                                        return null;
                                      },
                                      label: 'Line'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if(modee=='light')
                              InkWell(
                                onTap: () {
                                  print("create clinic");

                                  DrAidCubit.get(context).createClinic(
                                      name: clinicName.text,
                                      address: clinicAddress.text,
                                      telePhoneNumber: telephoneNumber.text,
                                      phoneNumber: phoneNumber.text,
                                      whatsappNumber: whatsAppNumber.text,
                                      ownerName: ownerName.text,
                                      ownerEmail: userEmail.text,
                                      ownerAddress: ownerAddress.text,
                                      ownerPhone: ownerPhone.text);
                                  print("name: ${clinicName.text}");
                                  print("owner name: ${ownerName.text}");
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: buttonColor),
                                  child: const Center(
                                    child: Text(
                                      'Add clinic',
                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            if(modee=='dark')
                              InkWell(
                                onTap: () {
                                  print("create clinic");

                                  DrAidCubit.get(context).createClinic(
                                      name: clinicName.text,
                                      address: clinicAddress.text,
                                      telePhoneNumber: telephoneNumber.text,
                                      phoneNumber: phoneNumber.text,
                                      whatsappNumber: whatsAppNumber.text,
                                      ownerName: ownerName.text,
                                      ownerEmail: userEmail.text,
                                      ownerAddress: ownerAddress.text,
                                      ownerPhone: ownerPhone.text);
                                  print("name: ${clinicName.text}");
                                  print("owner name: ${ownerName.text}");
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.orangeAccent),
                                  child: const Center(
                                    child: Text(
                                      'Add clinic',
                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )

                          ],
                        );
                      }
                      else{
                        return ListView(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Clinic name',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.text,
                                      controller: clinicName,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter clinic name';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),

                                Text(
                                  'Clinic address',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.text,
                                      controller: clinicAddress,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter clinic address';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Owner name',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.text,
                                      controller: ownerName,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter owner name';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),

                                Text(
                                  'Owner address',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.text,
                                      controller: ownerAddress,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter owner address';
                                        }
                                        return null;
                                      },
                                      label: 'enter field'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Doctor email',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.emailAddress,
                                      controller: userEmail,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter doctor email';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),

                                Text(
                                  'Owner phone number',
                                  style: TextStyle(fontSize: 24, color: fontColor),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.number,
                                      controller: ownerPhone,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter owner phone number';
                                        }
                                        return null;
                                      },
                                      label: 'Enter field'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      ' Contact info',
                                      style: TextStyle(fontSize: 24, color: fontColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.number,
                                      controller: whatsAppNumber,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter whatsapp number';
                                        }
                                        return null;
                                      },
                                      label: 'Whatsapp'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.emailAddress,
                                      controller: phoneNumber,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter phone number';
                                        }
                                        return null;
                                      },
                                      label: 'Call'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: ClinicFormField(
                                      type: TextInputType.number,
                                      controller: telephoneNumber,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter line number';
                                        }
                                        return null;
                                      },
                                      label: 'Line'),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if(modee=='light')
                                  InkWell(
                                    onTap: () {
                                      print("create clinic");

                                      DrAidCubit.get(context).createClinic(
                                          name: clinicName.text,
                                          address: clinicAddress.text,
                                          telePhoneNumber: telephoneNumber.text,
                                          phoneNumber: phoneNumber.text,
                                          whatsappNumber: whatsAppNumber.text,
                                          ownerName: ownerName.text,
                                          ownerEmail: userEmail.text,
                                          ownerAddress: ownerAddress.text,
                                          ownerPhone: ownerPhone.text);
                                      print("name: ${clinicName.text}");
                                      print("owner name: ${ownerName.text}");
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: buttonColor),
                                      child: const Center(
                                        child: Text(
                                          'Add clinic',
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                if(modee=='dark')
                                  InkWell(
                                    onTap: () {
                                      print("create clinic");

                                      DrAidCubit.get(context).createClinic(
                                          name: clinicName.text,
                                          address: clinicAddress.text,
                                          telePhoneNumber: telephoneNumber.text,
                                          phoneNumber: phoneNumber.text,
                                          whatsappNumber: whatsAppNumber.text,
                                          ownerName: ownerName.text,
                                          ownerEmail: userEmail.text,
                                          ownerAddress: ownerAddress.text,
                                          ownerPhone: ownerPhone.text);
                                      print("name: ${clinicName.text}");
                                      print("owner name: ${ownerName.text}");
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.orangeAccent),
                                      child: const Center(
                                        child: Text(
                                          'Add clinic',
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        );
                      }

                    }
                ),
              ),
            ),
          );
        }

      }
    );
  }

  Widget buildAddClinic(BuildContext context) {
    return Builder(
      builder: (context) {
        if(languagee=='arabic')
          {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 700,
                  color: coolWhite2,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            if(modee=='light')
                              Text(
                                'إضافة عيادة جديدة',
                                style: TextStyle(fontSize: 28, color: blueText),
                              ),
                            if(modee=='dark')
                              Text(
                                'إضافة عيادة جديدة',
                                style: TextStyle(fontSize: 28, color: Colors.orange),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildAddClinicItem(context),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        else{
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 700,
                color: coolWhite2,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20,),
                          if(modee=='light')
                            Text(
                              'Add new clinic',
                              style: TextStyle(fontSize: 28, color: blueText),
                            ),
                          if(modee=='dark')
                            Text(
                              'Add new clinic',
                              style: TextStyle(fontSize: 28, color: Colors.orange),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildAddClinicItem(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

      }
    );
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
                  child: Scaffold(
                    backgroundColor: coolWhite2,
                    appBar: const CustomAppBar(),
                    body: Row(
                      children: [
                        if(screenWidth>1530)
                          const SideBarScreen(),
                        buildAddClinic(context)],
                    ),
                  ),
                );
              }
            else{
              return Directionality(
                textDirection: TextDirection.ltr,
                child: Scaffold(
                  backgroundColor: coolWhite2,
                  appBar: const CustomAppBar(),
                  body: Row(
                    children: [
                      if(screenWidth>1530)
                        const SideBarScreen(),
                      buildAddClinic(context)],
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
