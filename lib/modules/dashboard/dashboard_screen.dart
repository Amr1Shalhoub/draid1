import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/modules/addclinic/add_clinic.dart';
import 'package:draid/layout/finance_layout/finance_layout.dart';
import 'package:draid/modules/all_patients/all_patients.dart';
import 'package:draid/modules/appointments/all_appointments.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:draid/modules/alltreatments/show_treatments.dart';
import 'package:draid/modules/dashboard/item_container.dart';
import 'package:draid/modules/sidebar/side_bar_screen.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 0;
  @override
  void addAssistant(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    'إضافة طبيب مساعد',
                    style: TextStyle(
                      fontSize: 18,
                      color: simpleDialogTitleColor,
                    ),
                  ),
                ),
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: 550,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddAttachmentField(
                                      type: TextInputType.text,
                                      controller: fullNameController,
                                      validate: null,
                                      label: 'اسم الطبيب المساعد ',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (fullNameController.text.isEmpty ||
                                        fullNameController.text.length < 5) {
                                      return 'رجاءً ادخل الاسم الكامل للطبيب المساعد (على الأقل 5 أحرف)';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddAttachmentField(
                                      type: TextInputType.number,
                                      controller: phoneNumberController,
                                      validate: null,
                                      label: 'رقم الطبيب المساعد ',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (phoneNumberController.text.isEmpty ||
                                        !RegExp(r'^\+?[0-9]{10,15}$')
                                            .hasMatch(phoneNumberController.text)) {
                                      return 'رقم الهاتف يجب أن يكون بين 10 و 15 رقماً، ويحتوي على أرقام فقط أو +';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddTreatmentFormField(
                                      type: TextInputType.emailAddress,
                                      controller: emailController,
                                      validate: null,
                                      label: 'البريد الإلكتروني للطبيب المساعد',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (emailController.text.isEmpty ||
                                        !RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                            .hasMatch(emailController.text)) {
                                      return 'رجاءً ادخل البريد الإلكتروني الصحيح';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddTreatmentFormField(
                                      type: TextInputType.text,
                                      controller: addressController,
                                      validate: null,
                                      label: 'العنوان',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (addressController.text.isEmpty ||
                                        addressController.text.length < 5) {
                                      return 'رجاءً ادخل عنوان الطبيب (على الأقل 5 أحرف)';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddTreatmentFormField(
                                      type: TextInputType.number,
                                      controller: passwordController,
                                      validate: null,
                                      label: 'كلمة المرور',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    String? password = passwordController.text;
                                    if (passwordController.text.isEmpty) {
                                      return 'رجاءً ادخل كلمة مرور صحيحة';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40,),

                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if(fullNameController.text!=''&&phoneNumberController.text!=''&&

                                    passwordController.text!=''&&addressController.text!=''
                                    &&emailController.text!=''
                                )
                                {
                                  EasyLoading.show(status: 'Creating Assistant...');
                                  DrAidCubit.get(context).createAssistant(
                                      fullName: fullNameController.text,
                                      phoneNumber: phoneNumberController.text,
                                      email: emailController.text,
                                      address: addressController.text,
                                      password: passwordController.text
                                  );

                                }


                                // DrAidCubit.get(context).createPatient(
                                //   fullName: fullNameController.text,
                                //   phoneNumber: phoneNumberController.text,
                                //   email: emailController.text,
                                //   address: addressController.text,
                                //   age: int.parse(ageController.text),
                                //   habits: habitsController.text,
                                //   gender: genderController.text,
                                //   birthDate: selectedDate!,
                                // );
                                Navigator.pop(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 45,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'تأكيد الإضافة',
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
                  'Add assistant',
                  style: TextStyle(
                    fontSize: 18,
                    color: simpleDialogTitleColor,
                  ),
                ),
              ),
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: 550,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: borderColor, width: 1),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddAttachmentField(
                                    type: TextInputType.text,
                                    controller: fullNameController,
                                    validate: null,
                                    label: 'Assistant name ',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (fullNameController.text.isEmpty ||
                                      fullNameController.text.length < 5) {
                                    return 'Please enter full name at least 5 characters';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (state.errorText != null)
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20, top: 5),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: borderColor, width: 1),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddAttachmentField(
                                    type: TextInputType.number,
                                    controller: phoneNumberController,
                                    validate: null,
                                    label: 'Phone number',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (phoneNumberController.text.isEmpty ||
                                      !RegExp(r'^\+?[0-9]{10,15}$')
                                          .hasMatch(phoneNumberController.text)) {
                                    return 'Phone number must be between 10 and 15 +';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (state.errorText != null)
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20, top: 5),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: borderColor, width: 1),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddTreatmentFormField(
                                    type: TextInputType.emailAddress,
                                    controller: emailController,
                                    validate: null,
                                    label: 'Assistant email',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (emailController.text.isEmpty ||
                                      !RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(emailController.text)) {
                                    return 'Please enter correct email';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (state.errorText != null)
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20, top: 5),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: borderColor, width: 1),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddTreatmentFormField(
                                    type: TextInputType.text,
                                    controller: addressController,
                                    validate: null,
                                    label: 'Address',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (addressController.text.isEmpty ||
                                      addressController.text.length < 5) {
                                    return 'Address should be at least 5 characters';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (state.errorText != null)
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20, top: 5),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: borderColor, width: 1),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddTreatmentFormField(
                                    type: TextInputType.number,
                                    controller: passwordController,
                                    validate: null,
                                    label: 'Password',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  String? password = passwordController.text;
                                  if (passwordController.text.isEmpty) {
                                    return 'Please enter correct password';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (state.errorText != null)
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20, top: 5),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40,),

                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              if(fullNameController.text!=''&&phoneNumberController.text!=''&&

                                  passwordController.text!=''&&addressController.text!=''
                                  &&emailController.text!=''
                              )
                              {
                                EasyLoading.show(status: 'Creating Assistant...');
                                DrAidCubit.get(context).createAssistant(
                                    fullName: fullNameController.text,
                                    phoneNumber: phoneNumberController.text,
                                    email: emailController.text,
                                    address: addressController.text,
                                    password: passwordController.text
                                );

                              }

                              Navigator.pop(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 45,
                              width: 200,
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  'Add assistant',
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
                ),
              ],
            ),
          );
        }

      },
    );
  }

  void addSecretary(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    'إضافة سكرتيرة',
                    style: TextStyle(
                      fontSize: 18,
                      color: simpleDialogTitleColor,
                    ),
                  ),
                ),
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: 550,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddAttachmentField(
                                      type: TextInputType.text,
                                      controller: fullNameController,
                                      validate: null,
                                      label: 'اسم السكرتيرة',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (fullNameController.text.isEmpty ||
                                        fullNameController.text.length < 5) {
                                      return 'رجاءً ادخل الاسم الكامل للسكرتيرة (على الأقل 5 أحرف)';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddAttachmentField(
                                      type: TextInputType.number,
                                      controller: phoneNumberController,
                                      validate: null,
                                      label: 'رقم السكرتيرة',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (phoneNumberController.text.isEmpty ||
                                        !RegExp(r'^\+?[0-9]{10,15}$')
                                            .hasMatch(phoneNumberController.text)) {
                                      return 'رقم الهاتف يجب أن يكون بين 10 و 15 رقماً، ويحتوي على أرقام فقط أو +';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddTreatmentFormField(
                                      type: TextInputType.emailAddress,
                                      controller: emailController,
                                      validate: null,
                                      label: 'البريد الإلكتروني للسكرتيرة',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (emailController.text.isEmpty ||
                                        !RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                            .hasMatch(emailController.text)) {
                                      return 'رجاءً ادخل البريد الإلكتروني الصحيح';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddTreatmentFormField(
                                      type: TextInputType.text,
                                      controller: addressController,
                                      validate: null,
                                      label: 'العنوان',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (addressController.text.isEmpty ||
                                        addressController.text.length < 5) {
                                      return 'رجاءً ادخل عنوان الطبيب (على الأقل 5 أحرف)';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: borderColor, width: 1),
                                  ),
                                  margin:
                                  const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddTreatmentFormField(
                                      type: TextInputType.number,
                                      controller: passwordController,
                                      validate: null,
                                      label: 'كلمة المرور',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    String? password = passwordController.text;
                                    if (passwordController.text.isEmpty) {
                                      return 'رجاءً ادخل كلمة مرور صحيحة';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red, fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40,),

                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if(fullNameController.text!=''&&phoneNumberController.text!=''&&

                                    passwordController.text!=''&&addressController.text!=''
                                    &&emailController.text!=''
                                )
                                {
                                  EasyLoading.show(status: 'Creating Secretary...');
                                  DrAidCubit.get(context).createSecretary(
                                      fullName: fullNameController.text,
                                      phoneNumber: phoneNumberController.text,
                                      email: emailController.text,
                                      address: addressController.text,
                                      password: passwordController.text
                                  );

                                }



                                Navigator.pop(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 45,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'تأكيد الإضافة',
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
                  'Add secretary',
                  style: TextStyle(
                    fontSize: 18,
                    color: simpleDialogTitleColor,
                  ),
                ),
              ),
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: 550,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: borderColor, width: 1),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddAttachmentField(
                                    type: TextInputType.text,
                                    controller: fullNameController,
                                    validate: null,
                                    label: 'Secretary name',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (fullNameController.text.isEmpty ||
                                      fullNameController.text.length < 5) {
                                    return 'Enter secretary name 5 characters at least';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (state.errorText != null)
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20, top: 5),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: borderColor, width: 1),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddAttachmentField(
                                    type: TextInputType.number,
                                    controller: phoneNumberController,
                                    validate: null,
                                    label: 'Phone number',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (phoneNumberController.text.isEmpty ||
                                      !RegExp(r'^\+?[0-9]{10,15}$')
                                          .hasMatch(phoneNumberController.text)) {
                                    return 'Phone number must be between 10 and 15 can have numbers or +';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (state.errorText != null)
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20, top: 5),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: borderColor, width: 1),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddTreatmentFormField(
                                    type: TextInputType.emailAddress,
                                    controller: emailController,
                                    validate: null,
                                    label: 'Secretary email',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (emailController.text.isEmpty ||
                                      !RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(emailController.text)) {
                                    return 'Please enter correct email';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (state.errorText != null)
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20, top: 5),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: borderColor, width: 1),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddTreatmentFormField(
                                    type: TextInputType.text,
                                    controller: addressController,
                                    validate: null,
                                    label: 'Address',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (addressController.text.isEmpty ||
                                      addressController.text.length < 5) {
                                    return 'Please enter correct address at least 5 characters';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (state.errorText != null)
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20, top: 5),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: borderColor, width: 1),
                                ),
                                margin:
                                const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddTreatmentFormField(
                                    type: TextInputType.number,
                                    controller: passwordController,
                                    validate: null,
                                    label: 'Password',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  String? password = passwordController.text;
                                  if (passwordController.text.isEmpty) {
                                    return 'Please enter correct password';
                                  }
                                  return null;
                                },
                                builder: (state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (state.errorText != null)
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(
                                              start: 20, top: 5),
                                          child: Text(
                                            state.errorText!,
                                            style: const TextStyle(
                                                color: Colors.red, fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40,),

                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              if(fullNameController.text!=''&&phoneNumberController.text!=''&&

                                  passwordController.text!=''&&addressController.text!=''
                                  &&emailController.text!=''
                              )
                              {
                                EasyLoading.show(status: 'Creating Secretary...');
                                DrAidCubit.get(context).createSecretary(
                                    fullName: fullNameController.text,
                                    phoneNumber: phoneNumberController.text,
                                    email: emailController.text,
                                    address: addressController.text,
                                    password: passwordController.text
                                );

                              }



                              Navigator.pop(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 45,
                              width: 200,
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Center(
                                child: Text(
                                  'Add secretary',
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
                ),
              ],
            ),
          );
        }

      },
    );
  }


  Widget build(BuildContext context) {
    // Determine the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    // Define the number of items per row based on screen size
    int itemsPerRow = isMobile ? 1 : (isTablet ? 2 : 3);

    // Define the spacing between items
    double spacing = isMobile ? 10 : 20;

    // Define padding for items
    EdgeInsetsGeometry itemPadding = isMobile
        ? EdgeInsets.symmetric(horizontal: 8.0)
        : EdgeInsets.symmetric(horizontal: 16.0);

    // Define container width based on screen size
    double containerWidth = isMobile ? double.infinity : 250.0;

    // Define container height
    double containerHeight = 45.0;

    if (roleFromBackend == 'assistant') {
      return BlocConsumer<DrAidCubit,DrAidStates>(
         listener: (context,state){},
          builder: (context,state){
            return Builder(
              builder: (context) {
                if(languagee=='arabic')
                  {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: Scaffold(
                        backgroundColor: ColorManager.backgroundColor,
                        appBar: const CustomAppBar(),
                        body: Row(
                          children: [
                            if (!isMobile) const SideBarScreen(), // Hide Sidebar on mobile
                            Expanded(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    Wrap(
                                      spacing: spacing,
                                      runSpacing: spacing,
                                      children: [
                                        InkWell(
                                          child: Item(
                                            widget: Image.asset(
                                              'images/dentistry.gif',
                                              scale: 7,
                                            ),
                                            num: 200,
                                            text: 'سجلات المرضى',
                                          ),
                                          onTap: () {
                                            navigateTo(
                                              context,
                                              const Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: AllPatients(),
                                              ),
                                            );
                                          },
                                        ),
                                        // InkWell(
                                        //   child: Item(
                                        //     widget: Image.asset(
                                        //       'images/dental-clinic.gif',
                                        //       scale: 8,
                                        //     ),
                                        //     num: 4,
                                        //     text: 'العيادات',
                                        //   ),
                                        //   onTap: () {
                                        //     navigateTo(
                                        //       context,
                                        //       const Directionality(
                                        //         textDirection: TextDirection.rtl,
                                        //         child: AddClinicScreen(),
                                        //       ),
                                        //     );
                                        //   },
                                        // ),
                                        // Item(
                                        //   widget: Image.asset(
                                        //     'images/finance.gif',
                                        //     scale: 8,
                                        //   ),
                                        //   num: 1140,
                                        //   text: 'الفواتير',
                                        // ),
                                        InkWell(
                                          child: Item(
                                            widget: Image.asset(
                                              'images/tooth-drill.gif',
                                              scale: 8,
                                            ),
                                            num: 4,
                                            text: 'العلاجات',
                                          ),
                                          onTap: () {
                                            navigateTo(
                                              context,
                                              const Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: ShowAllTreatments(),
                                              ),
                                            );
                                          },
                                        ),
                                        InkWell(
                                          onTap: () {
                                            navigateTo(
                                              context,
                                              const Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: AllAppointments(),
                                              ),
                                            );
                                          },
                                          child: Item(
                                            widget: Image.asset(
                                              'images/Appointments.gif',
                                              scale: 8,
                                            ),
                                            num: 50,
                                            text: 'المواعيد',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                else{
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: Scaffold(
                      backgroundColor: ColorManager.backgroundColor,
                      appBar: const CustomAppBar(),
                      body: Row(
                        children: [
                          if (!isMobile) const SideBarScreen(), // Hide Sidebar on mobile
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Wrap(
                                    spacing: spacing,
                                    runSpacing: spacing,
                                    children: [
                                      InkWell(
                                        child: Item(
                                          widget: Image.asset(
                                            'images/dentistry.gif',
                                            scale: 7,
                                          ),
                                          num: 200,
                                          text: 'Patient records',
                                        ),
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: AllPatients(),
                                            ),
                                          );
                                        },
                                      ),
                                      // InkWell(
                                      //   child: Item(
                                      //     widget: Image.asset(
                                      //       'images/dental-clinic.gif',
                                      //       scale: 8,
                                      //     ),
                                      //     num: 4,
                                      //     text: 'Clinics',
                                      //   ),
                                      //   onTap: () {
                                      //     navigateTo(
                                      //       context,
                                      //       const Directionality(
                                      //         textDirection: TextDirection.ltr,
                                      //         child: AddClinicScreen(),
                                      //       ),
                                      //     );
                                      //   },
                                      // ),
                                      // Item(
                                      //   widget: Image.asset(
                                      //     'images/finance.gif',
                                      //     scale: 8,
                                      //   ),
                                      //   num: 1140,
                                      //   text: 'Bills',
                                      // ),
                                      InkWell(
                                        child: Item(
                                          widget: Image.asset(
                                            'images/tooth-drill.gif',
                                            scale: 8,
                                          ),
                                          num: 4,
                                          text: 'Treatments',
                                        ),
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: ShowAllTreatments(),
                                            ),
                                          );
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: AllAppointments(),
                                            ),
                                          );
                                        },
                                        child: Item(
                                          widget: Image.asset(
                                            'images/Appointments.gif',
                                            scale: 8,
                                          ),
                                          num: 50,
                                          text: 'Appointments',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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



    } else if (roleFromBackend == 'secretary') {
      return BlocConsumer<DrAidCubit,DrAidStates>(
        listener: (context,state){},
        builder: (context,state){
          return Builder(
            builder: (context) {
              if(languagee=='arabic')
                {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      backgroundColor: ColorManager.backgroundColor,
                      appBar: const CustomAppBar(),
                      body: Row(
                        children: [
                          if (!isMobile) const SideBarScreen(), // Hide Sidebar on mobile
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Wrap(
                                    spacing: spacing,
                                    runSpacing: spacing,
                                    children: [
                                      InkWell(
                                        child: Item(
                                          widget: Image.asset(
                                            'images/dentistry.gif',
                                            scale: 7,
                                          ),
                                          num: 200,
                                          text: 'سجلات المرضى',
                                        ),
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: AllPatients(),
                                            ),
                                          );
                                        },
                                      ),
                                      // Item(
                                      //   widget: Image.asset(
                                      //     'images/finance.gif',
                                      //     scale: 8,
                                      //   ),
                                      //   num: 1140,
                                      //   text: 'الفواتير',
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: AllAppointments(),
                                            ),
                                          );
                                        },
                                        child: Item(
                                          widget: Image.asset(
                                            'images/Appointments.gif',
                                            scale: 8,
                                          ),
                                          num: 50,
                                          text: 'المواعيد',
                                        ),
                                      ),
                                      InkWell(
                                        child: Item(
                                          widget: Image.asset(
                                            'images/money.gif',
                                            scale: 8,
                                          ),
                                          num: 18,
                                          text: 'المالية',
                                        ),
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: FinanceLayout(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              else{
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: Scaffold(
                    backgroundColor: ColorManager.backgroundColor,
                    appBar: const CustomAppBar(),
                    body: Row(
                      children: [
                        if (!isMobile) const SideBarScreen(), // Hide Sidebar on mobile
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Wrap(
                                  spacing: spacing,
                                  runSpacing: spacing,
                                  children: [
                                    InkWell(
                                      child: Item(
                                        widget: Image.asset(
                                          'images/dentistry.gif',
                                          scale: 7,
                                        ),
                                        num: 200,
                                        text: 'Patient records',
                                      ),
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          const Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: AllPatients(),
                                          ),
                                        );
                                      },
                                    ),
                                    // Item(
                                    //   widget: Image.asset(
                                    //     'images/finance.gif',
                                    //     scale: 8,
                                    //   ),
                                    //   num: 1140,
                                    //   text: 'Bills',
                                    // ),
                                    InkWell(
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          const Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: AllAppointments(),
                                          ),
                                        );
                                      },
                                      child: Item(
                                        widget: Image.asset(
                                          'images/Appointments.gif',
                                          scale: 8,
                                        ),
                                        num: 50,
                                        text: 'Appointments',
                                      ),
                                    ),
                                    InkWell(
                                      child: Item(
                                        widget: Image.asset(
                                          'images/money.gif',
                                          scale: 8,
                                        ),
                                        num: 18,
                                        text: 'Finance',
                                      ),
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          const Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: FinanceLayout(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
    else {

      return BlocConsumer<DrAidCubit,DrAidStates>(
        listener: (context,state){},
        builder: (context,state){


          return Builder(
            builder: (context) {
              if(languagee=='arabic')
                {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                      backgroundColor: ColorManager.backgroundColor,
                      appBar: const CustomAppBar(),
                      body: Row(
                        children: [
                          if (!isMobile&&!isTablet) const SideBarScreen(), // Hide Sidebar on mobile
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Builder(
                                      builder: (context) {
                                        if(isTablet)
                                        {
                                          return  Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              if(!isDesktop)
                                              Container(
                                                width: 130,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAssistant(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 10),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10),

                                                        Text(
                                                          'إضافة مساعد',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if(!isDesktop)
                                              Container(
                                                width: 130,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addSecretary(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 10),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'إضافة سكرتيرة',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        else if (isMobile)
                                        {
                                          return  Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              if(!isDesktop)
                                              Container(
                                                width: 130,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAssistant(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 10),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10),

                                                        Text(
                                                          'إضافة مساعد',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if(!isDesktop)
                                              Container(
                                                width: 130,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addSecretary(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 10),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'إضافة سكرتيرة',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }

                                        else {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              if(!isDesktop)
                                              Container(
                                                width: containerWidth,
                                                height: containerHeight,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addAssistant(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 30),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(width: 20),

                                                        Text(
                                                          'إضافة طبيب مساعد',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if(!isDesktop)
                                              Container(
                                                width: containerWidth,
                                                height: containerHeight,
                                                decoration: BoxDecoration(
                                                  color: blueText,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    addSecretary(context);
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsetsDirectional.only(start: 30),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 30,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(width: 20),
                                                        Text(
                                                          'إضافة سكرتيرة',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }

                                      }
                                  ),
                                  SizedBox(height: 20),
                                  Wrap(
                                    spacing: spacing,
                                    runSpacing: spacing,
                                    children: [
                                      InkWell(
                                        child: Item(
                                          widget: Image.asset(
                                            'images/dentistry.gif',
                                            scale: 7,
                                          ),
                                          num: 200,
                                          text: 'سجلات المرضى',
                                        ),
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: AllPatients(),
                                            ),
                                          );
                                        },
                                      ),
                                      if(roleFromBackend=='admin')
                                      InkWell(
                                        child: Item(
                                          widget: Image.asset(
                                            'images/dental-clinic.gif',
                                            scale: 8,
                                          ),
                                          num: 4,
                                          text: 'العيادات',
                                        ),
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: AddClinicScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      // Item(
                                      //   widget: Image.asset(
                                      //     'images/finance.gif',
                                      //     scale: 8,
                                      //   ),
                                      //   num: 1140,
                                      //   text: 'الفواتير',
                                      // ),
                                      InkWell(
                                        child: Item(
                                          widget: Image.asset(
                                            'images/tooth-drill.gif',
                                            scale: 8,
                                          ),
                                          num: 4,
                                          text: 'العلاجات',
                                        ),
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: ShowAllTreatments(),
                                            ),
                                          );
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: AllAppointments(),
                                            ),
                                          );
                                        },
                                        child: Item(
                                          widget: Image.asset(
                                            'images/Appointments.gif',
                                            scale: 8,
                                          ),
                                          num: 50,
                                          text: 'المواعيد',
                                        ),
                                      ),
                                      InkWell(
                                        child: Item(
                                          widget: Image.asset(
                                            'images/money.gif',
                                            scale: 8,
                                          ),
                                          num: 18,
                                          text: 'المالية',
                                        ),
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            const Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: FinanceLayout(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              else{
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: Scaffold(
                    backgroundColor: ColorManager.backgroundColor,
                    appBar: const CustomAppBar(),
                    body: Row(
                      children: [
                        if (!isMobile&&!isTablet) const SideBarScreen(), // Hide Sidebar on mobile
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Builder(
                                    builder: (context) {
                                      if(isTablet)
                                      {
                                        return  Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            if(!isDesktop)
                                            Container(
                                              width: 130,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: blueText,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  addAssistant(context);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsetsDirectional.only(start: 10),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 10),

                                                      Text(
                                                        'Add assistant',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if(!isDesktop)
                                            Container(
                                              width: 130,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: blueText,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  addSecretary(context);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsetsDirectional.only(start: 10),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'Add secretary',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                      else if (isMobile)
                                      {
                                        return  Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            if(!isDesktop)
                                            Container(
                                              width: 130,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: blueText,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  addAssistant(context);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsetsDirectional.only(start: 10),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 10),

                                                      Text(
                                                        'Add assistant',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if(!isDesktop)
                                            Container(
                                              width: 130,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: blueText,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  addSecretary(context);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsetsDirectional.only(start: 10),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'Add secretary',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }

                                      else {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            if(!isDesktop)
                                            Container(
                                              width: containerWidth,
                                              height: containerHeight,
                                              decoration: BoxDecoration(
                                                color: blueText,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  addAssistant(context);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsetsDirectional.only(start: 30),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 20),

                                                      Text(
                                                        'Add assistant',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if(!isDesktop)
                                            Container(
                                              width: containerWidth,
                                              height: containerHeight,
                                              decoration: BoxDecoration(
                                                color: blueText,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  addSecretary(context);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsetsDirectional.only(start: 30),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 30,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 20),
                                                      Text(
                                                        'Add secretary',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }

                                    }
                                ),
                                SizedBox(height: 20),
                                Wrap(
                                  spacing: spacing,
                                  runSpacing: spacing,
                                  children: [
                                    InkWell(
                                      child: Item(
                                        widget: Image.asset(
                                          'images/dentistry.gif',
                                          scale: 7,
                                        ),
                                        num: 200,
                                        text: 'Patient records',
                                      ),
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          const Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: AllPatients(),
                                          ),
                                        );
                                      },
                                    ),
                                    if(roleFromBackend=='admin')
                                    InkWell(
                                      child: Item(
                                        widget: Image.asset(
                                          'images/dental-clinic.gif',
                                          scale: 8,
                                        ),
                                        num: 4,
                                        text: 'Clinics',
                                      ),
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          const Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: AddClinicScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                    // Item(
                                    //   widget: Image.asset(
                                    //     'images/finance.gif',
                                    //     scale: 8,
                                    //   ),
                                    //   num: 1140,
                                    //   text: 'Bills',
                                    // ),
                                    InkWell(
                                      child: Item(
                                        widget: Image.asset(
                                          'images/tooth-drill.gif',
                                          scale: 8,
                                        ),
                                        num: 4,
                                        text: 'Treatments',
                                      ),
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          const Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: ShowAllTreatments(),
                                          ),
                                        );
                                      },
                                    ),
                                    InkWell(
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          const Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: AllAppointments(),
                                          ),
                                        );
                                      },
                                      child: Item(
                                        widget: Image.asset(
                                          'images/Appointments.gif',
                                          scale: 8,
                                        ),
                                        num: 50,
                                        text: 'Appointments',
                                      ),
                                    ),
                                    InkWell(
                                      child: Item(
                                        widget: Image.asset(
                                          'images/money.gif',
                                          scale: 8,
                                        ),
                                        num: 18,
                                        text: 'Finance',
                                      ),
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          const Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: FinanceLayout(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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



}
