// ignore_for_file: unnecessary_null_comparison, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/layout/patient_layout/patient_information_layout.dart';
import 'package:draid/models/get_all_patients_model.dart';
import 'package:draid/modules/patient/patient_basic_information/basic_info.dart';
import 'package:draid/modules/sidebar/side_bar_screen.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AllPatients extends StatefulWidget {
  const AllPatients({super.key});

  @override
  State<AllPatients> createState() => _AllPatientsState();
}

class _AllPatientsState extends State<AllPatients> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController habitsController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  DateTime? selectedDate;

  // This is the way to start search :
  List<DatumPatient> searchPatient = [];
  //searchPatient=DrAidCubit.get(context).allPatients;
  void addPatientsToSearchList(String searchText) {
    // Very important line of code
    // This is the trick of how we can search like it is real time searching
    if (searchText != '' || searchText != null) {
      searchPatient = DrAidCubit.get(context)
          .allPatients
          .where((DatumPatient) =>
              DatumPatient.fullName.toLowerCase().startsWith(searchText))
          .toList();
      // searchPatient= DrAidCubit.get(context).allPatients.where((GetAllPatientsModel) => )
    }
    //searchPatient=allProducts.where((ProductModel) => ProductModel.name.toLowerCase().startsWith(searchText)).toList();
    //print(searchProducts[0].name);
  }

  void addBasicInformation(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController habitsController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    genderController.text = 'Male';
    DateTime? selectedDate;

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
                    'إضافة مريض',
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
                                      label: 'اسم المريض ',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (fullNameController.text.isEmpty ||
                                        fullNameController.text.length < 5) {
                                      return 'رجاءً ادخل الاسم الكامل للمريض (على الأقل 5 أحرف)';
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
                          const Spacer(),
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
                                      label: 'رقم المريض ',
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
                          const Spacer(),
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
                                      label: 'البريد الإلكتروني للمريض',
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
                          const Spacer(),
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
                                      return 'رجاءً ادخل عنوان المريض (على الأقل 5 أحرف)';
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
                          const Spacer(),
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
                                      controller: ageController,
                                      validate: null,
                                      label: 'العمر',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    int? age = int.tryParse(ageController.text);
                                    if (ageController.text.isEmpty ||
                                        age == null ||
                                        age <= 0 ||
                                        age >= 110) {
                                      return 'رجاءً ادخل عمر صحيح (بين 1 و 109)';
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
                          const Spacer(),
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
                                      controller: habitsController,
                                      validate: null,
                                      label: 'العادات',
                                    ),
                                  ),
                                ),
                                FormField(
                                  validator: (value) {
                                    if (habitsController.text.isEmpty) {
                                      return 'رجاءً ادخل عادات المريض';
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
                          const Spacer(),
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
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: const Icon(Icons.arrow_drop_up),
                                        style: const TextStyle(color: Colors.black),
                                        value: genderController.text.isNotEmpty
                                            ? genderController.text
                                            : 'Male',
                                        items: const [
                                          DropdownMenuItem(
                                            value: 'Male',
                                            child: Text('ذكر'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Female',
                                            child: Text('أنثى'),
                                          ),
                                        ],
                                        onChanged: (String? newValue) {
                                          genderController.text = newValue ?? '';
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 200,
                            child: DatePicker(
                              title: "تاريخ الميلاد",
                              initialDate: DateTime.now(),
                              onDateSelected: (date) {
                                setState(() {
                                  selectedDate = date;
                                });
                              },
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if (selectedDate == null) {
                                  EasyLoading.showError('رجاءً اختر تاريخ الميلاد');
                                  return;
                                }
                                EasyLoading.show(status: 'Creating patient...');
                                DrAidCubit.get(context).createPatient(
                                  fullName: fullNameController.text,
                                  phoneNumber: phoneNumberController.text,
                                  email: emailController.text,
                                  address: addressController.text,
                                  age: int.parse(ageController.text),
                                  habits: habitsController.text,
                                  gender: genderController.text,
                                  birthDate: selectedDate!,
                                );
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
                  'Add patient',
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
                                    label: 'Name ',
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
                        const Spacer(),
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
                                    label: 'Phone number ',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (phoneNumberController.text.isEmpty ||
                                      !RegExp(r'^\+?[0-9]{10,15}$')
                                          .hasMatch(phoneNumberController.text)) {
                                    return 'Phone number should be between 10 and 15';
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
                        const Spacer(),
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
                                    label: 'Email',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (emailController.text.isEmpty ||
                                      !RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(emailController.text)) {
                                    return 'Please enter the correct email';
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
                        const Spacer(),
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
                                    return 'Please enter address at least 5 characters';
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
                        const Spacer(),
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
                                    controller: ageController,
                                    validate: null,
                                    label: 'Age',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  int? age = int.tryParse(ageController.text);
                                  if (ageController.text.isEmpty ||
                                      age == null ||
                                      age <= 0 ||
                                      age >= 110) {
                                    return 'Please enter correct age';
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
                        const Spacer(),
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
                                    controller: habitsController,
                                    validate: null,
                                    label: 'Habits',
                                  ),
                                ),
                              ),
                              FormField(
                                validator: (value) {
                                  if (habitsController.text.isEmpty) {
                                    return 'Please enter habits';
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
                        const Spacer(),
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
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      icon: const Icon(Icons.arrow_drop_up),
                                      style: const TextStyle(color: Colors.black),
                                      value: genderController.text.isNotEmpty
                                          ? genderController.text
                                          : 'Male',
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'Male',
                                          child: Text('Male'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Female',
                                          child: Text('Female'),
                                        ),
                                      ],
                                      onChanged: (String? newValue) {
                                        genderController.text = newValue ?? '';
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 200,
                          child: DatePicker(
                            title: "Birthday",
                            initialDate: DateTime.now(),
                            onDateSelected: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              if (selectedDate == null) {
                                EasyLoading.showError('Please enter birthday');
                                return;
                              }
                              EasyLoading.show(status: 'Creating patient...');
                              DrAidCubit.get(context).createPatient(
                                fullName: fullNameController.text,
                                phoneNumber: phoneNumberController.text,
                                email: emailController.text,
                                address: addressController.text,
                                age: int.parse(ageController.text),
                                habits: habitsController.text,
                                gender: genderController.text,
                                birthDate: selectedDate!,
                              );
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
                ),
              ],
            ),
          );
        }

      },
    );
  }

  @override
  void initState() {
    super.initState();
    final cubit = DrAidCubit.get(context);
    cubit.getAllPatientsData();
  }

  String patientId = '0';
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
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    backgroundColor: coolWhite2,
                    appBar: const CustomAppBar(),
                    body: Row(
                      children: [
                        if(screenWidth>1530)
                          const SideBarScreen(),
                        SingleChildScrollView(
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
                                    if(screenWidth>=800)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 20, end: 130),
                                        child: Row(
                                          children: [
                                            Builder(
                                                builder: (context) {
                                                  if(modee=='light')
                                                  {
                                                    return InkWell(
                                                      child: const Image(
                                                        image: AssetImage('images/arrow.png'),
                                                        width: 30,
                                                        height: 20,
                                                      ),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }
                                                  else{
                                                    return InkWell(
                                                      child: Icon(Icons.arrow_back,color:Colors.orange,size: 30,),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }

                                                }
                                            ),
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1200&&modee=='light')
                                              const Text(
                                                'المرضى',
                                                style:
                                                TextStyle(fontSize: 28, color: blueText),
                                              ),
                                            if(screenWidth>=1200&&modee=='dark')
                                              const Text(
                                                'المرضى',
                                                style:
                                                TextStyle(fontSize: 28, color: Colors.orange),
                                              ),
                                            if(screenWidth<1200&&modee=='light')
                                              const Text(
                                                'مرضى',
                                                style:
                                                TextStyle(fontSize: 14, color: blueText),
                                              ),
                                            if(screenWidth<1200&&modee=='dark')
                                              const Text(
                                                'مرضى',
                                                style:
                                                TextStyle(fontSize: 14, color: Colors.orange),
                                              ),
                                            const Spacer(),
                                            if(screenWidth>=1200)
                                              Flexible(
                                                child: SizedBox(
                                                  width: 200,
                                                  child: CustomSearchField(
                                                    onChanged: (searchText) {
                                                      setState(() {
                                                        if (searchText != null ||
                                                            searchText != '') {
                                                          addPatientsToSearchList(searchText);
                                                        } else {
                                                          searchPatient = [];
                                                        }
                                                      });
                                                    },
                                                    icon: Icons.search,
                                                    hintText: 'بحث عن مريض',
                                                    controller: searchController,
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth<1200)
                                              Flexible(
                                                child: SizedBox(
                                                  width: 100,
                                                  child: CustomSearchField(
                                                    onChanged: (searchText) {
                                                      setState(() {
                                                        if (searchText != null ||
                                                            searchText != '') {
                                                          addPatientsToSearchList(searchText);
                                                        } else {
                                                          searchPatient = [];
                                                        }
                                                      });
                                                    },
                                                    icon: Icons.search,
                                                    hintText: 'بحث',
                                                    controller: searchController,
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth>=1200)
                                              const SizedBox(
                                                width: 20,
                                              ),
                                            if(screenWidth<1200)
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            Builder(
                                                builder: (context) {
                                                  if(roleFromBackend=='secretary'&&screenWidth>=1200)
                                                  {

                                                    return SizedBox(width: 250,);
                                                  }
                                                  else if(roleFromBackend=='secretary'&&screenWidth<1200)
                                                  {
                                                    return SizedBox(width: 20,);
                                                  }
                                                  else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='light')
                                                  {
                                                    return  Container(
                                                      width: 100,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                        color: blueText,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          // addNewTreatment(context);
                                                          addBasicInformation(context);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.only(start: 30),
                                                          child: Row(children: [
                                                            Text(
                                                              'إضافة',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='dark')
                                                  {
                                                    return  Container(
                                                      width: 100,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                        color: Colors.orangeAccent,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          // addNewTreatment(context);
                                                          addBasicInformation(context);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.only(start: 30),
                                                          child: Row(children: [
                                                            Text(
                                                              'إضافة',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  else{
                                                    return Builder(
                                                        builder: (context) {
                                                          if(modee=='light')
                                                          {
                                                            return Container(
                                                              width: 250,
                                                              height: 45,
                                                              decoration: BoxDecoration(
                                                                color: blueText,
                                                                borderRadius: BorderRadius.circular(30),
                                                              ),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  // addNewTreatment(context);
                                                                  addBasicInformation(context);
                                                                },
                                                                child: const Padding(
                                                                  padding:
                                                                  EdgeInsetsDirectional.only(start: 30),
                                                                  child: Row(children: [
                                                                    Icon(
                                                                      Icons.add,
                                                                      size: 30,
                                                                      color: Colors.white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Text(
                                                                      'إضافة مريض جديد',
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                        color: Colors.white,
                                                                      ),
                                                                    )
                                                                  ]),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          else{
                                                            return Container(
                                                              width: 250,
                                                              height: 45,
                                                              decoration: BoxDecoration(
                                                                color: Colors.orangeAccent,
                                                                borderRadius: BorderRadius.circular(30),
                                                              ),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  // addNewTreatment(context);
                                                                  addBasicInformation(context);
                                                                },
                                                                child: const Padding(
                                                                  padding:
                                                                  EdgeInsetsDirectional.only(start: 30),
                                                                  child: Row(children: [
                                                                    Icon(
                                                                      Icons.add,
                                                                      size: 30,
                                                                      color: Colors.white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Text(
                                                                      'إضافة مريض جديد',
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                        color: Colors.white,
                                                                      ),
                                                                    )
                                                                  ]),
                                                                ),
                                                              ),
                                                            );
                                                          }

                                                        }
                                                    );
                                                  }


                                                }
                                            ),
                                          ],
                                        ),
                                      ),
                                    if(screenWidth<800&&screenWidth>=700)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 20, end: 20),
                                        child: Row(
                                          children: [
                                            Builder(
                                                builder: (context) {
                                                  if(modee=='light')
                                                  {
                                                    return InkWell(
                                                      child: const Image(
                                                        image: AssetImage('images/arrow.png'),
                                                        width: 30,
                                                        height: 20,
                                                      ),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }
                                                  else{
                                                    return InkWell(
                                                      child: Icon(Icons.arrow_back,color:Colors.orange,size: 30,),
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }

                                                }
                                            ),
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1200&&modee=='light')
                                              const Text(
                                                'المرضى',
                                                style:
                                                TextStyle(fontSize: 28, color: blueText),
                                              ),
                                            if(screenWidth>=1200&&modee=='dark')
                                              const Text(
                                                'المرضى',
                                                style:
                                                TextStyle(fontSize: 28, color: Colors.orange),
                                              ),
                                            if(screenWidth<1200&&modee=='light')
                                              const Text(
                                                'مرضى',
                                                style:
                                                TextStyle(fontSize: 14, color: blueText),
                                              ),
                                            if(screenWidth<1200&&modee=='dark')
                                              const Text(
                                                'مرضى',
                                                style:
                                                TextStyle(fontSize: 14, color: Colors.orange),
                                              ),
                                            const Spacer(),
                                            if(screenWidth>=1200)
                                              Flexible(
                                                child: SizedBox(
                                                  width: 200,
                                                  child: CustomSearchField(
                                                    onChanged: (searchText) {
                                                      setState(() {
                                                        if (searchText != null ||
                                                            searchText != '') {
                                                          addPatientsToSearchList(searchText);
                                                        } else {
                                                          searchPatient = [];
                                                        }
                                                      });
                                                    },
                                                    icon: Icons.search,
                                                    hintText: 'بحث عن مريض',
                                                    controller: searchController,
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth<1200)
                                              Flexible(
                                                child: SizedBox(
                                                  width: 100,
                                                  child: CustomSearchField(
                                                    onChanged: (searchText) {
                                                      setState(() {
                                                        if (searchText != null ||
                                                            searchText != '') {
                                                          addPatientsToSearchList(searchText);
                                                        } else {
                                                          searchPatient = [];
                                                        }
                                                      });
                                                    },
                                                    icon: Icons.search,
                                                    hintText: 'بحث',
                                                    controller: searchController,
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth>=1200)
                                              const SizedBox(
                                                width: 20,
                                              ),
                                            if(screenWidth<1200)
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            Builder(
                                                builder: (context) {
                                                  if(roleFromBackend=='secretary'&&screenWidth>=1200)
                                                  {

                                                    return SizedBox(width: 250,);
                                                  }
                                                  else if(roleFromBackend=='secretary'&&screenWidth<1200)
                                                  {
                                                    return SizedBox(width: 20,);
                                                  }
                                                  else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='light')
                                                  {
                                                    return  Container(
                                                      width: 100,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                        color: blueText,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          // addNewTreatment(context);
                                                          addBasicInformation(context);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.only(start: 30),
                                                          child: Row(children: [
                                                            Text(
                                                              'إضافة',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='dark')
                                                  {
                                                    return  Container(
                                                      width: 100,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                        color: Colors.orangeAccent,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          // addNewTreatment(context);
                                                          addBasicInformation(context);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.only(start: 30),
                                                          child: Row(children: [
                                                            Text(
                                                              'إضافة',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  else{
                                                    return Container(
                                                      width: 250,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                        color: blueText,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          // addNewTreatment(context);
                                                          addBasicInformation(context);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.only(start: 30),
                                                          child: Row(children: [
                                                            Icon(
                                                              Icons.add,
                                                              size: 30,
                                                              color: Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'إضافة مريض جديد',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                      ),
                                                    );
                                                  }


                                                }
                                            ),
                                          ],
                                        ),
                                      ),
                                    if(screenWidth<700)
                                      Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 5, end: 5),
                                        child: Row(
                                          children: [
                                            if(screenWidth>=1200)
                                              const SizedBox(width: 20),
                                            if(screenWidth<1200)
                                              const SizedBox(width: 10),
                                            if(screenWidth>=1200&&modee=='light')
                                              const Text(
                                                'المرضى',
                                                style:
                                                TextStyle(fontSize: 28, color: blueText),
                                              ),
                                            if(screenWidth>=1200&&modee=='dark')
                                              const Text(
                                                'المرضى',
                                                style:
                                                TextStyle(fontSize: 28, color: Colors.orange),
                                              ),
                                            if(screenWidth<1200&&modee=='light')
                                              const Text(
                                                'مرضى',
                                                style:
                                                TextStyle(fontSize: 14, color: blueText),
                                              ),
                                            if(screenWidth<1200&&modee=='dark')
                                              const Text(
                                                'مرضى',
                                                style:
                                                TextStyle(fontSize: 14, color: Colors.orange),
                                              ),
                                            const Spacer(),
                                            if(screenWidth>=1200)
                                              Flexible(
                                                child: SizedBox(
                                                  width: 200,
                                                  child: CustomSearchField(
                                                    onChanged: (searchText) {
                                                      setState(() {
                                                        if (searchText != null ||
                                                            searchText != '') {
                                                          addPatientsToSearchList(searchText);
                                                        } else {
                                                          searchPatient = [];
                                                        }
                                                      });
                                                    },
                                                    icon: Icons.search,
                                                    hintText: 'بحث عن مريض',
                                                    controller: searchController,
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth<1200)
                                              Flexible(
                                                child: SizedBox(
                                                  width: 100,
                                                  child: CustomSearchField(
                                                    onChanged: (searchText) {
                                                      setState(() {
                                                        if (searchText != null ||
                                                            searchText != '') {
                                                          addPatientsToSearchList(searchText);
                                                        } else {
                                                          searchPatient = [];
                                                        }
                                                      });
                                                    },
                                                    icon: Icons.search,
                                                    hintText: 'بحث',
                                                    controller: searchController,
                                                  ),
                                                ),
                                              ),
                                            if(screenWidth>=1200)
                                              const SizedBox(
                                                width: 20,
                                              ),
                                            if(screenWidth<1200)
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            Builder(
                                                builder: (context) {
                                                  if(roleFromBackend=='secretary'&&screenWidth>=1200)
                                                  {

                                                    return SizedBox(width: 250,);
                                                  }
                                                  else if(roleFromBackend=='secretary'&&screenWidth<1200)
                                                  {
                                                    return SizedBox(width: 20,);
                                                  }
                                                  else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='light')
                                                  {
                                                    return  Container(
                                                      width: 100,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                        color: blueText,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          // addNewTreatment(context);
                                                          addBasicInformation(context);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.only(start: 30),
                                                          child: Row(children: [
                                                            Text(
                                                              'إضافة',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='dark')
                                                  {
                                                    return  Container(
                                                      width: 100,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                        color: Colors.orangeAccent,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          // addNewTreatment(context);
                                                          addBasicInformation(context);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.only(start: 30),
                                                          child: Row(children: [
                                                            Text(
                                                              'إضافة',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  else{
                                                    return Container(
                                                      width: 250,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                        color: blueText,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          // addNewTreatment(context);
                                                          addBasicInformation(context);
                                                        },
                                                        child: const Padding(
                                                          padding:
                                                          EdgeInsetsDirectional.only(start: 30),
                                                          child: Row(children: [
                                                            Icon(
                                                              Icons.add,
                                                              size: 30,
                                                              color: Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'إضافة مريض جديد',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                          ]),
                                                        ),
                                                      ),
                                                    );
                                                  }


                                                }
                                            ),
                                          ],
                                        ),
                                      ),

                                    const SizedBox(height: 60),
                                    Padding(
                                      padding:
                                      const EdgeInsetsDirectional.only(end: 175.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.70,
                                        height: 450,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 18),
                                            if(screenWidth>=1400)
                                              const Padding(
                                                padding:
                                                EdgeInsetsDirectional.only(start: 30),
                                                child:

                                                Row(
                                                  children: [
                                                    SizedBox(width: 30),
                                                    Expanded(
                                                      child: Text(
                                                        "اسم المريض",
                                                        style: TextStyle(
                                                            fontSize: 16, color: fontColor),
                                                      ),
                                                    ),
                                                    SizedBox(width: 85),
                                                    Expanded(
                                                      child: Text(
                                                        'العمر',
                                                        style: TextStyle(
                                                            fontSize: 16, color: fontColor),
                                                      ),
                                                    ),
                                                    SizedBox(width: 50),
                                                    Expanded(
                                                      child: Text(
                                                        "الجنس",
                                                        style: TextStyle(
                                                            fontSize: 16, color: fontColor),
                                                      ),
                                                    ),
                                                    SizedBox(width: 70),
                                                    Expanded(
                                                      child: Text(
                                                        "السكن",
                                                        style: TextStyle(
                                                            fontSize: 16, color: fontColor),
                                                      ),
                                                    ),
                                                    SizedBox(width: 30),
                                                    Expanded(
                                                      child: Text(
                                                        "الملف الشخصي",
                                                        style: TextStyle(
                                                            fontSize: 16, color: fontColor),
                                                      ),
                                                    ),
                                                    SizedBox(width: 60),
                                                    Expanded(
                                                      child: Text(
                                                        "",
                                                        style: TextStyle(
                                                            fontSize: 16, color: fontColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            const SizedBox(height: 10),
                                            if(screenWidth>=1450)
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 900,
                                                    height: 1,
                                                    color: dividerColor,
                                                  ),
                                                ],
                                              ),
                                            const SizedBox(height: 10),
                                            Builder(
                                              builder: (context) {
                                                if(DrAidCubit.get(context).getAllPatientsModel?.data!=null)
                                                {
                                                  if(DrAidCubit.get(context).getAllPatientsModel!.data.isNotEmpty)
                                                  {
                                                    return Expanded(
                                                      child: Builder(builder: (context) {
                                                        if (searchPatient.isNotEmpty ||
                                                            searchPatient == []) {
                                                          return ListView.separated(
                                                              itemBuilder:
                                                                  (context, index) {
                                                                return Padding(
                                                                  padding:
                                                                  const EdgeInsetsDirectional
                                                                      .only(start: 30),
                                                                  child: Row(
                                                                    children: [
                                                                      if(screenWidth>=1450)
                                                                        const SizedBox(
                                                                            width: 30),
                                                                      Expanded(
                                                                        child: Text(
                                                                          searchPatient[
                                                                          index]
                                                                              .fullName,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                      if(screenWidth>=1450)
                                                                        const SizedBox(
                                                                            width: 40),
                                                                      if(screenWidth>=1400)
                                                                        Expanded(
                                                                          child: Text(
                                                                            searchPatient[
                                                                            index]
                                                                                .age
                                                                                .toString(),
                                                                            style: const TextStyle(
                                                                                fontSize: 16,
                                                                                color:
                                                                                fontColor),
                                                                          ),
                                                                        ),
                                                                      const SizedBox(
                                                                          width: 10),
                                                                      if(screenWidth>=1400)
                                                                        Expanded(
                                                                          child: Text(
                                                                            searchPatient[
                                                                            index]
                                                                                .gender,
                                                                            style: const TextStyle(
                                                                                fontSize: 16,
                                                                                color:
                                                                                fontColor),
                                                                          ),
                                                                        ),
                                                                      if(screenWidth>=1400)
                                                                        Expanded(
                                                                          child: Text(
                                                                            searchPatient[
                                                                            index]
                                                                                .address,
                                                                            style: const TextStyle(
                                                                                fontSize: 16,
                                                                                color:
                                                                                fontColor),
                                                                          ),
                                                                        ),
                                                                      if(screenWidth>=1400)
                                                                        Container(
                                                                          width: 130,
                                                                          height: 35,
                                                                          decoration:
                                                                          BoxDecoration(
                                                                            color: coolGreen1,
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                30),
                                                                          ),
                                                                          child: Builder(
                                                                              builder: (context) {
                                                                                if(roleFromBackend=='secretary')
                                                                                {
                                                                                  return InkWell(
                                                                                      onTap: () {
                                                                                        patientId = searchPatient[
                                                                                        index]
                                                                                            .patientClinic
                                                                                            .patientId
                                                                                            .toString();
                                                                                        int patientIdd = searchPatient[
                                                                                        index]
                                                                                            .patientClinic
                                                                                            .patientId;
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .patientId =
                                                                                            patientIdd;
                                                                                        if (patientId !=
                                                                                            '0') {
                                                                                          DrAidCubit.get(
                                                                                              context)
                                                                                              .getPatientData(
                                                                                            patientId:
                                                                                            patientId,
                                                                                          );
                                                                                        }
                                                                                        navigateTo(
                                                                                            context,
                                                                                            const Directionality(
                                                                                                textDirection: TextDirection
                                                                                                    .rtl,
                                                                                                child:
                                                                                                PatientBasicInformationForSecretary()));
                                                                                      },
                                                                                      child:
                                                                                      const Center(
                                                                                        child: Text(
                                                                                          'معلومات أساسية',
                                                                                          style:
                                                                                          TextStyle(
                                                                                            fontSize:
                                                                                            12,
                                                                                            color:
                                                                                            white,
                                                                                          ),
                                                                                        ),
                                                                                      ));
                                                                                }
                                                                                else{
                                                                                  return InkWell(
                                                                                      onTap: () {
                                                                                        patientId = searchPatient[
                                                                                        index]
                                                                                            .patientClinic
                                                                                            .patientId
                                                                                            .toString();
                                                                                        int patientIdd = searchPatient[
                                                                                        index]
                                                                                            .patientClinic
                                                                                            .patientId;
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .patientId =
                                                                                            patientIdd;
                                                                                        if (patientId !=
                                                                                            '0') {
                                                                                          DrAidCubit.get(
                                                                                              context)
                                                                                              .getPatientData(
                                                                                            patientId:
                                                                                            patientId,
                                                                                          );
                                                                                        }
                                                                                        navigateTo(
                                                                                            context,
                                                                                            const Directionality(
                                                                                                textDirection: TextDirection
                                                                                                    .rtl,
                                                                                                child:
                                                                                                PatientInformationLayout()));
                                                                                      },
                                                                                      child:
                                                                                      const Center(
                                                                                        child: Text(
                                                                                          '  عرض الملف الشخصي  ',
                                                                                          style:
                                                                                          TextStyle(
                                                                                            fontSize:
                                                                                            12,
                                                                                            color:
                                                                                            white,
                                                                                          ),
                                                                                        ),
                                                                                      ));
                                                                                }

                                                                              }
                                                                          ),
                                                                        ),
                                                                      if(screenWidth<1400)
                                                                        Container(
                                                                          width: 80,
                                                                          height: 35,
                                                                          decoration:
                                                                          BoxDecoration(
                                                                            color: coolGreen1,
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                30),
                                                                          ),
                                                                          child: Builder(
                                                                              builder: (context) {
                                                                                if(roleFromBackend=='secretary')
                                                                                {
                                                                                  return InkWell(
                                                                                      onTap: () {
                                                                                        patientId = searchPatient[
                                                                                        index]
                                                                                            .patientClinic
                                                                                            .patientId
                                                                                            .toString();
                                                                                        int patientIdd = searchPatient[
                                                                                        index]
                                                                                            .patientClinic
                                                                                            .patientId;
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .patientId =
                                                                                            patientIdd;
                                                                                        if (patientId !=
                                                                                            '0') {
                                                                                          DrAidCubit.get(
                                                                                              context)
                                                                                              .getPatientData(
                                                                                            patientId:
                                                                                            patientId,
                                                                                          );
                                                                                        }
                                                                                        navigateTo(
                                                                                            context,
                                                                                            const Directionality(
                                                                                                textDirection: TextDirection
                                                                                                    .rtl,
                                                                                                child:
                                                                                                PatientBasicInformationForSecretary()));
                                                                                      },
                                                                                      child:
                                                                                      const Center(
                                                                                        child: Text(
                                                                                          'معلومات',
                                                                                          style:
                                                                                          TextStyle(
                                                                                            fontSize:
                                                                                            12,
                                                                                            color:
                                                                                            white,
                                                                                          ),
                                                                                        ),
                                                                                      ));
                                                                                }
                                                                                else{
                                                                                  return InkWell(
                                                                                      onTap: () {
                                                                                        patientId = searchPatient[
                                                                                        index]
                                                                                            .patientClinic
                                                                                            .patientId
                                                                                            .toString();
                                                                                        int patientIdd = searchPatient[
                                                                                        index]
                                                                                            .patientClinic
                                                                                            .patientId;
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .patientId =
                                                                                            patientIdd;
                                                                                        if (patientId !=
                                                                                            '0') {
                                                                                          DrAidCubit.get(
                                                                                              context)
                                                                                              .getPatientData(
                                                                                            patientId:
                                                                                            patientId,
                                                                                          );
                                                                                        }
                                                                                        navigateTo(
                                                                                            context,
                                                                                            const Directionality(
                                                                                                textDirection: TextDirection
                                                                                                    .rtl,
                                                                                                child:
                                                                                                PatientInformationLayout()));
                                                                                      },
                                                                                      child:
                                                                                      const Center(
                                                                                        child: Text(
                                                                                          'الملف',
                                                                                          style:
                                                                                          TextStyle(
                                                                                            fontSize:
                                                                                            12,
                                                                                            color:
                                                                                            white,
                                                                                          ),
                                                                                        ),
                                                                                      ));
                                                                                }

                                                                              }
                                                                          ),
                                                                        ),
                                                                      if(screenWidth>=1400)
                                                                        const SizedBox(
                                                                            width: 75),
                                                                      if(screenWidth<1400)
                                                                        const SizedBox(
                                                                            width: 10),
                                                                      if(screenWidth>=1450)
                                                                        Container(
                                                                          width: 70,
                                                                          height: 40,
                                                                          color: Colors.white,
                                                                          child: const Center(
                                                                            child: Row(
                                                                              children: [
                                                                                Image(
                                                                                  image: AssetImage(
                                                                                      'images/edit1.png'),
                                                                                  width: 25,
                                                                                  height: 25,
                                                                                ),
                                                                                SizedBox(
                                                                                    width:
                                                                                    10),
                                                                                Image(
                                                                                  image: AssetImage(
                                                                                      'images/delete.png'),
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
                                                              separatorBuilder:
                                                                  (context, index) {
                                                                return const SizedBox(
                                                                    height: 10);
                                                              },
                                                              itemCount:
                                                              searchPatient.length);
                                                        } else {
                                                          return ListView.separated(
                                                            itemBuilder: (context, index) {
                                                              final patient =
                                                                  DrAidCubit.get(context)
                                                                      .getAllPatientsModel;
                                                              return Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .only(start: 30),
                                                                child: Row(
                                                                  children: [
                                                                    if(screenWidth>=1450)
                                                                      const SizedBox(
                                                                          width: 30),
                                                                    Expanded(
                                                                      child: Text(
                                                                        patient!.data[index]
                                                                            .fullName,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                    if(screenWidth>=1450)
                                                                      const SizedBox(
                                                                          width: 40),
                                                                    if(screenWidth>=1400)
                                                                      Expanded(
                                                                        child: Text(
                                                                          patient
                                                                              .data[index].age
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    const SizedBox(
                                                                        width: 10),
                                                                    if(screenWidth>=1400)
                                                                      Expanded(
                                                                        child: Text(
                                                                          patient.data[index]
                                                                              .gender,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1350)
                                                                      Expanded(
                                                                        child: Text(
                                                                          patient.data[index]
                                                                              .address,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1400)
                                                                      Container(
                                                                        width: 130,
                                                                        height: 35,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          color: coolGreen1,
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              30),
                                                                        ),
                                                                        child:
                                                                        Builder(
                                                                            builder: (context) {
                                                                              if(roleFromBackend=='secretary')
                                                                              {
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = patient
                                                                                          .data[index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = patient
                                                                                          .data[index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection:
                                                                                              TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientBasicInformationForSecretary()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        'معلومات أساسية',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                );
                                                                              }
                                                                              else{
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = patient
                                                                                          .data[index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = patient
                                                                                          .data[index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection:
                                                                                              TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientInformationLayout()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        '  عرض الملف الشخصي  ',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                );
                                                                              }

                                                                            }
                                                                        ),
                                                                      ),
                                                                    if(screenWidth<1400)
                                                                      Container(
                                                                        width: 80,
                                                                        height: 35,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          color: coolGreen1,
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              30),
                                                                        ),
                                                                        child:
                                                                        Builder(
                                                                            builder: (context) {
                                                                              if(roleFromBackend=='secretary')
                                                                              {
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = patient
                                                                                          .data[index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = patient
                                                                                          .data[index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection:
                                                                                              TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientBasicInformationForSecretary()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        'معلومات',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                );
                                                                              }
                                                                              else{
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = patient
                                                                                          .data[index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = patient
                                                                                          .data[index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection:
                                                                                              TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientInformationLayout()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        'الملف',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                );
                                                                              }

                                                                            }
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1450)
                                                                      const SizedBox(
                                                                          width: 75),
                                                                    if(screenWidth<1450)
                                                                      const SizedBox(
                                                                          width: 10),
                                                                    if(screenWidth>=1450)
                                                                      Container(
                                                                        width: 70,
                                                                        height: 40,
                                                                        color: Colors.white,
                                                                        child: const Center(
                                                                          child: Row(
                                                                            children: [
                                                                              Image(
                                                                                image: AssetImage(
                                                                                    'images/edit1.png'),
                                                                                width: 25,
                                                                                height: 25,
                                                                              ),
                                                                              SizedBox(
                                                                                  width: 10),
                                                                              Image(
                                                                                image: AssetImage(
                                                                                    'images/delete.png'),
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
                                                            separatorBuilder:
                                                                (context, index) {
                                                              return const SizedBox(
                                                                  height: 10);
                                                            },
                                                            itemCount:
                                                            DrAidCubit.get(context)
                                                                .getAllPatientsModel!
                                                                .data
                                                                .length,
                                                          );
                                                        }
                                                      }),
                                                    );
                                                  }
                                                }

                                                if (state
                                                is DrAidGetAllPatientsSuccessState||DrAidCubit.get(context).getAllPatientsModel?.data!=null) {
                                                  return Expanded(
                                                    child: Builder(builder: (context) {
                                                      if (searchPatient.isNotEmpty ||
                                                          searchPatient == []) {
                                                        return ListView.separated(
                                                            itemBuilder:
                                                                (context, index) {
                                                              return Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .only(start: 30),
                                                                child: Row(
                                                                  children: [
                                                                    if(screenWidth>=1450)
                                                                      const SizedBox(
                                                                          width: 30),
                                                                    Expanded(
                                                                      child: Text(
                                                                        searchPatient[
                                                                        index]
                                                                            .fullName,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                    if(screenWidth>=1450)
                                                                      const SizedBox(
                                                                          width: 40),
                                                                    if(screenWidth>=1400)
                                                                      Expanded(
                                                                        child: Text(
                                                                          searchPatient[
                                                                          index]
                                                                              .age
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    const SizedBox(
                                                                        width: 10),
                                                                    if(screenWidth>=1400)
                                                                      Expanded(
                                                                        child: Text(
                                                                          searchPatient[
                                                                          index]
                                                                              .gender,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1400)
                                                                      Expanded(
                                                                        child: Text(
                                                                          searchPatient[
                                                                          index]
                                                                              .address,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1400)
                                                                      Container(
                                                                        width: 130,
                                                                        height: 35,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          color: coolGreen1,
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              30),
                                                                        ),
                                                                        child: Builder(
                                                                            builder: (context) {
                                                                              if(roleFromBackend=='secretary')
                                                                              {
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection: TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientBasicInformationForSecretary()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        'معلومات أساسية',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    ));
                                                                              }
                                                                              else{
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection: TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientInformationLayout()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        '  عرض الملف الشخصي  ',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    ));
                                                                              }

                                                                            }
                                                                        ),
                                                                      ),
                                                                    if(screenWidth<1400)
                                                                      Container(
                                                                        width: 80,
                                                                        height: 35,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          color: coolGreen1,
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              30),
                                                                        ),
                                                                        child: Builder(
                                                                            builder: (context) {
                                                                              if(roleFromBackend=='secretary')
                                                                              {
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection: TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientBasicInformationForSecretary()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        'معلومات',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    ));
                                                                              }
                                                                              else{
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection: TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientInformationLayout()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        'الملف',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    ));
                                                                              }

                                                                            }
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1400)
                                                                      const SizedBox(
                                                                          width: 75),
                                                                    if(screenWidth<1400)
                                                                      const SizedBox(
                                                                          width: 10),
                                                                    if(screenWidth>=1450)
                                                                      Container(
                                                                        width: 70,
                                                                        height: 40,
                                                                        color: Colors.white,
                                                                        child: const Center(
                                                                          child: Row(
                                                                            children: [
                                                                              Image(
                                                                                image: AssetImage(
                                                                                    'images/edit1.png'),
                                                                                width: 25,
                                                                                height: 25,
                                                                              ),
                                                                              SizedBox(
                                                                                  width:
                                                                                  10),
                                                                              Image(
                                                                                image: AssetImage(
                                                                                    'images/delete.png'),
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
                                                            separatorBuilder:
                                                                (context, index) {
                                                              return const SizedBox(
                                                                  height: 10);
                                                            },
                                                            itemCount:
                                                            searchPatient.length);
                                                      } else {
                                                        return ListView.separated(
                                                          itemBuilder: (context, index) {
                                                            final patient =
                                                                DrAidCubit.get(context)
                                                                    .getAllPatientsModel;
                                                            return Padding(
                                                              padding:
                                                              const EdgeInsetsDirectional
                                                                  .only(start: 30),
                                                              child: Row(
                                                                children: [
                                                                  if(screenWidth>=1450)
                                                                    const SizedBox(
                                                                        width: 30),
                                                                  Expanded(
                                                                    child: Text(
                                                                      patient!.data[index]
                                                                          .fullName,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color:
                                                                          fontColor),
                                                                    ),
                                                                  ),
                                                                  if(screenWidth>=1450)
                                                                    const SizedBox(
                                                                        width: 40),
                                                                  if(screenWidth>=1400)
                                                                    Expanded(
                                                                      child: Text(
                                                                        patient
                                                                            .data[index].age
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                  const SizedBox(
                                                                      width: 10),
                                                                  if(screenWidth>=1400)
                                                                    Expanded(
                                                                      child: Text(
                                                                        patient.data[index]
                                                                            .gender,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                  if(screenWidth>=1400)
                                                                    Expanded(
                                                                      child: Text(
                                                                        patient.data[index]
                                                                            .address,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                  if(screenWidth>=1350)
                                                                    Container(
                                                                      width: 130,
                                                                      height: 35,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: coolGreen1,
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            30),
                                                                      ),
                                                                      child:
                                                                      Builder(
                                                                          builder: (context) {
                                                                            if(roleFromBackend=='secretary')
                                                                            {
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection:
                                                                                            TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientBasicInformationForSecretary()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      'معلومات أساسية',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            }
                                                                            else{
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection:
                                                                                            TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientInformationLayout()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      '  عرض الملف الشخصي  ',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            }

                                                                          }
                                                                      ),
                                                                    ),
                                                                  if(screenWidth<1350)
                                                                    Container(
                                                                      width: 80,
                                                                      height: 35,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: coolGreen1,
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            30),
                                                                      ),
                                                                      child:
                                                                      Builder(
                                                                          builder: (context) {
                                                                            if(roleFromBackend=='secretary')
                                                                            {
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection:
                                                                                            TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientBasicInformationForSecretary()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      'معلومات',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            }
                                                                            else{
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection:
                                                                                            TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientInformationLayout()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      'الملف',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            }

                                                                          }
                                                                      ),
                                                                    ),
                                                                  if(screenWidth>=1000)
                                                                    const SizedBox(
                                                                        width: 75),
                                                                  if(screenWidth<1000)
                                                                    const SizedBox(
                                                                        width: 10),
                                                                  if(screenWidth>=1400)
                                                                    Container(
                                                                      width: 70,
                                                                      height: 40,
                                                                      color: Colors.white,
                                                                      child: const Center(
                                                                        child: Row(
                                                                          children: [
                                                                            Image(
                                                                              image: AssetImage(
                                                                                  'images/edit1.png'),
                                                                              width: 25,
                                                                              height: 25,
                                                                            ),
                                                                            SizedBox(
                                                                                width: 10),
                                                                            Image(
                                                                              image: AssetImage(
                                                                                  'images/delete.png'),
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
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                                height: 10);
                                                          },
                                                          itemCount:
                                                          DrAidCubit.get(context)
                                                              .getAllPatientsModel!
                                                              .data
                                                              .length,
                                                        );
                                                      }
                                                    }),
                                                  );

                                                  //   Expanded(
                                                  //   child: Builder(builder: (context) {
                                                  //     if (searchPatient.isNotEmpty ||
                                                  //         searchPatient == []) {
                                                  //       return ListView.separated(
                                                  //           itemBuilder:
                                                  //               (context, index) {
                                                  //             return Padding(
                                                  //               padding:
                                                  //                   const EdgeInsetsDirectional
                                                  //                       .only(start: 30),
                                                  //               child: Row(
                                                  //                 children: [
                                                  //                   const SizedBox(
                                                  //                       width: 30),
                                                  //                   Expanded(
                                                  //                     child: Text(
                                                  //                       searchPatient[
                                                  //                               index]
                                                  //                           .fullName,
                                                  //                       style: const TextStyle(
                                                  //                           fontSize: 16,
                                                  //                           color:
                                                  //                               fontColor),
                                                  //                     ),
                                                  //                   ),
                                                  //                   const SizedBox(
                                                  //                       width: 40),
                                                  //                   Expanded(
                                                  //                     child: Text(
                                                  //                       searchPatient[
                                                  //                               index]
                                                  //                           .age
                                                  //                           .toString(),
                                                  //                       style: const TextStyle(
                                                  //                           fontSize: 16,
                                                  //                           color:
                                                  //                               fontColor),
                                                  //                     ),
                                                  //                   ),
                                                  //                   const SizedBox(
                                                  //                       width: 10),
                                                  //                   Expanded(
                                                  //                     child: Text(
                                                  //                       searchPatient[
                                                  //                               index]
                                                  //                           .gender,
                                                  //                       style: const TextStyle(
                                                  //                           fontSize: 16,
                                                  //                           color:
                                                  //                               fontColor),
                                                  //                     ),
                                                  //                   ),
                                                  //                   Expanded(
                                                  //                     child: Text(
                                                  //                       searchPatient[
                                                  //                               index]
                                                  //                           .address,
                                                  //                       style: const TextStyle(
                                                  //                           fontSize: 16,
                                                  //                           color:
                                                  //                               fontColor),
                                                  //                     ),
                                                  //                   ),
                                                  //                   Container(
                                                  //                     width: 130,
                                                  //                     height: 35,
                                                  //                     decoration:
                                                  //                         BoxDecoration(
                                                  //                       color: coolGreen1,
                                                  //                       borderRadius:
                                                  //                           BorderRadius
                                                  //                               .circular(
                                                  //                                   30),
                                                  //                     ),
                                                  //                     child:
                                                  //
                                                  //                     Builder(
                                                  //                       builder: (context) {
                                                  //                         if(roleFromBackend=='secretary')
                                                  //                           {
                                                  //                             return InkWell(
                                                  //                                 onTap: () {
                                                  //                                   patientId = searchPatient[
                                                  //                                   index]
                                                  //                                       .patientClinic
                                                  //                                       .patientId
                                                  //                                       .toString();
                                                  //                                   int patientIdd = searchPatient[
                                                  //                                   index]
                                                  //                                       .patientClinic
                                                  //                                       .patientId;
                                                  //                                   DrAidCubit.get(
                                                  //                                       context)
                                                  //                                       .patientId =
                                                  //                                       patientIdd;
                                                  //                                   if (patientId !=
                                                  //                                       '0') {
                                                  //                                     DrAidCubit.get(
                                                  //                                         context)
                                                  //                                         .getPatientData(
                                                  //                                       patientId:
                                                  //                                       patientId,
                                                  //                                     );
                                                  //                                   }
                                                  //                                   navigateTo(
                                                  //                                       context,
                                                  //                                       const Directionality(
                                                  //                                           textDirection: TextDirection
                                                  //                                               .rtl,
                                                  //                                           child:
                                                  //                                           PatientBasicInformationForSecretary()));
                                                  //                                 },
                                                  //                                 child:
                                                  //                                 const Center(
                                                  //                                   child: Text(
                                                  //                                     'مغلومات أساسية',
                                                  //                                     style:
                                                  //                                     TextStyle(
                                                  //                                       fontSize:
                                                  //                                       12,
                                                  //                                       color:
                                                  //                                       white,
                                                  //                                     ),
                                                  //                                   ),
                                                  //                                 ));
                                                  //                           }
                                                  //                         else{
                                                  //                           return InkWell(
                                                  //                               onTap: () {
                                                  //                                 patientId = searchPatient[
                                                  //                                 index]
                                                  //                                     .patientClinic
                                                  //                                     .patientId
                                                  //                                     .toString();
                                                  //                                 int patientIdd = searchPatient[
                                                  //                                 index]
                                                  //                                     .patientClinic
                                                  //                                     .patientId;
                                                  //                                 DrAidCubit.get(
                                                  //                                     context)
                                                  //                                     .patientId =
                                                  //                                     patientIdd;
                                                  //                                 if (patientId !=
                                                  //                                     '0') {
                                                  //                                   DrAidCubit.get(
                                                  //                                       context)
                                                  //                                       .getPatientData(
                                                  //                                     patientId:
                                                  //                                     patientId,
                                                  //                                   );
                                                  //                                 }
                                                  //                                 navigateTo(
                                                  //                                     context,
                                                  //                                     const Directionality(
                                                  //                                         textDirection: TextDirection
                                                  //                                             .rtl,
                                                  //                                         child:
                                                  //                                         PatientInformationLayout()));
                                                  //                               },
                                                  //                               child:
                                                  //                               const Center(
                                                  //                                 child: Text(
                                                  //                                   '  عرض الملف الشخصي  ',
                                                  //                                   style:
                                                  //                                   TextStyle(
                                                  //                                     fontSize:
                                                  //                                     12,
                                                  //                                     color:
                                                  //                                     white,
                                                  //                                   ),
                                                  //                                 ),
                                                  //                               ));
                                                  //                         }
                                                  //
                                                  //                       }
                                                  //                     ),
                                                  //                   ),
                                                  //                   const SizedBox(
                                                  //                       width: 75),
                                                  //                   Container(
                                                  //                     width: 70,
                                                  //                     height: 40,
                                                  //                     color: Colors.white,
                                                  //                     child: const Center(
                                                  //                       child: Row(
                                                  //                         children: [
                                                  //                           Image(
                                                  //                             image: AssetImage(
                                                  //                                 'images/edit1.png'),
                                                  //                             width: 25,
                                                  //                             height: 25,
                                                  //                           ),
                                                  //                           SizedBox(
                                                  //                               width:
                                                  //                                   10),
                                                  //                           Image(
                                                  //                             image: AssetImage(
                                                  //                                 'images/delete.png'),
                                                  //                             width: 30,
                                                  //                             height: 30,
                                                  //                           ),
                                                  //                         ],
                                                  //                       ),
                                                  //                     ),
                                                  //                   ),
                                                  //                 ],
                                                  //               ),
                                                  //             );
                                                  //           },
                                                  //           separatorBuilder:
                                                  //               (context, index) {
                                                  //             return const SizedBox(
                                                  //                 height: 10);
                                                  //           },
                                                  //           itemCount:
                                                  //               searchPatient.length);
                                                  //     } else {
                                                  //       return ListView.separated(
                                                  //         itemBuilder: (context, index) {
                                                  //           final patient =
                                                  //               DrAidCubit.get(context)
                                                  //                   .getAllPatientsModel;
                                                  //           return Padding(
                                                  //             padding:
                                                  //                 const EdgeInsetsDirectional
                                                  //                     .only(start: 30),
                                                  //             child: Row(
                                                  //               children: [
                                                  //                 const SizedBox(
                                                  //                     width: 30),
                                                  //                 Expanded(
                                                  //                   child: Text(
                                                  //                     patient!.data[index]
                                                  //                         .fullName,
                                                  //                     style: const TextStyle(
                                                  //                         fontSize: 16,
                                                  //                         color:
                                                  //                             fontColor),
                                                  //                   ),
                                                  //                 ),
                                                  //                 const SizedBox(
                                                  //                     width: 40),
                                                  //                 Expanded(
                                                  //                   child: Text(
                                                  //                     patient
                                                  //                         .data[index].age
                                                  //                         .toString(),
                                                  //                     style: const TextStyle(
                                                  //                         fontSize: 16,
                                                  //                         color:
                                                  //                             fontColor),
                                                  //                   ),
                                                  //                 ),
                                                  //                 const SizedBox(
                                                  //                     width: 10),
                                                  //                 Expanded(
                                                  //                   child: Text(
                                                  //                     patient.data[index]
                                                  //                         .gender,
                                                  //                     style: const TextStyle(
                                                  //                         fontSize: 16,
                                                  //                         color:
                                                  //                             fontColor),
                                                  //                   ),
                                                  //                 ),
                                                  //                 Expanded(
                                                  //                   child: Text(
                                                  //                     patient.data[index]
                                                  //                         .address,
                                                  //                     style: const TextStyle(
                                                  //                         fontSize: 16,
                                                  //                         color:
                                                  //                             fontColor),
                                                  //                   ),
                                                  //                 ),
                                                  //                 Container(
                                                  //                   width: 130,
                                                  //                   height: 35,
                                                  //                   decoration:
                                                  //                       BoxDecoration(
                                                  //                     color: coolGreen1,
                                                  //                     borderRadius:
                                                  //                         BorderRadius
                                                  //                             .circular(
                                                  //                                 30),
                                                  //                   ),
                                                  //                   child:
                                                  //                   Builder(
                                                  //                     builder: (context) {
                                                  //                       if(roleFromBackend=='secretary')
                                                  //                         {
                                                  //                           return InkWell(
                                                  //                               onTap: () {
                                                  //                                 patientId = patient
                                                  //                                     .data[index]
                                                  //                                     .patientClinic
                                                  //                                     .patientId
                                                  //                                     .toString();
                                                  //                                 int patientIdd = patient
                                                  //                                     .data[index]
                                                  //                                     .patientClinic
                                                  //                                     .patientId;
                                                  //                                 DrAidCubit.get(
                                                  //                                     context)
                                                  //                                     .patientId =
                                                  //                                     patientIdd;
                                                  //                                 if (patientId !=
                                                  //                                     '0') {
                                                  //                                   DrAidCubit.get(
                                                  //                                       context)
                                                  //                                       .getPatientData(
                                                  //                                     patientId:
                                                  //                                     patientId,
                                                  //                                   );
                                                  //                                 }
                                                  //                                 navigateTo(
                                                  //                                     context,
                                                  //                                     const Directionality(
                                                  //                                         textDirection:
                                                  //                                         TextDirection
                                                  //                                             .rtl,
                                                  //                                         child:
                                                  //                                         PatientBasicInformationForSecretary()));
                                                  //                               },
                                                  //                               child:
                                                  //                               const Center(
                                                  //                                 child: Text(
                                                  //                                   'معلومات أساسية',
                                                  //                                   style:
                                                  //                                   TextStyle(
                                                  //                                     fontSize:
                                                  //                                     12,
                                                  //                                     color:
                                                  //                                     white,
                                                  //                                   ),
                                                  //                                 ),
                                                  //                               )
                                                  //                           );
                                                  //                         }
                                                  //                       else{
                                                  //                         return InkWell(
                                                  //                             onTap: () {
                                                  //                               patientId = patient
                                                  //                                   .data[index]
                                                  //                                   .patientClinic
                                                  //                                   .patientId
                                                  //                                   .toString();
                                                  //                               int patientIdd = patient
                                                  //                                   .data[index]
                                                  //                                   .patientClinic
                                                  //                                   .patientId;
                                                  //                               DrAidCubit.get(
                                                  //                                   context)
                                                  //                                   .patientId =
                                                  //                                   patientIdd;
                                                  //                               if (patientId !=
                                                  //                                   '0') {
                                                  //                                 DrAidCubit.get(
                                                  //                                     context)
                                                  //                                     .getPatientData(
                                                  //                                   patientId:
                                                  //                                   patientId,
                                                  //                                 );
                                                  //                               }
                                                  //                               navigateTo(
                                                  //                                   context,
                                                  //                                   const Directionality(
                                                  //                                       textDirection:
                                                  //                                       TextDirection
                                                  //                                           .rtl,
                                                  //                                       child:
                                                  //                                       PatientInformationLayout()));
                                                  //                             },
                                                  //                             child:
                                                  //                             const Center(
                                                  //                               child: Text(
                                                  //                                 '  عرض الملف الشخصي  ',
                                                  //                                 style:
                                                  //                                 TextStyle(
                                                  //                                   fontSize:
                                                  //                                   12,
                                                  //                                   color:
                                                  //                                   white,
                                                  //                                 ),
                                                  //                               ),
                                                  //                             )
                                                  //                         );
                                                  //                       }
                                                  //
                                                  //                     }
                                                  //                   ),
                                                  //                 ),
                                                  //                 const SizedBox(
                                                  //                     width: 75),
                                                  //                 Container(
                                                  //                   width: 70,
                                                  //                   height: 40,
                                                  //                   color: Colors.white,
                                                  //                   child: const Center(
                                                  //                     child: Row(
                                                  //                       children: [
                                                  //                         Image(
                                                  //                           image: AssetImage(
                                                  //                               'images/edit1.png'),
                                                  //                           width: 25,
                                                  //                           height: 25,
                                                  //                         ),
                                                  //                         SizedBox(
                                                  //                             width: 10),
                                                  //                         Image(
                                                  //                           image: AssetImage(
                                                  //                               'images/delete.png'),
                                                  //                           width: 30,
                                                  //                           height: 30,
                                                  //                         ),
                                                  //                       ],
                                                  //                     ),
                                                  //                   ),
                                                  //                 ),
                                                  //               ],
                                                  //             ),
                                                  //           );
                                                  //         },
                                                  //         separatorBuilder:
                                                  //             (context, index) {
                                                  //           return const SizedBox(
                                                  //               height: 10);
                                                  //         },
                                                  //         itemCount:
                                                  //             DrAidCubit.get(context)
                                                  //                 .getAllPatientsModel!
                                                  //                 .data
                                                  //                 .length,
                                                  //       );
                                                  //     }
                                                  //   }),
                                                  // );
                                                }
                                                if (DrAidCubit.get(context)
                                                    .getAllPatientsModel!
                                                    .data
                                                    .isEmpty) {
                                                  return const Column(
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'لا يوجد مرضى بعد',
                                                          style: TextStyle(
                                                            fontSize: 24,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                                if (state
                                                is DrAidGetAllPatientsLoadingState) {
                                                  return const Center(
                                                      child: CircularProgressIndicator());
                                                } else {
                                                  return const Center(
                                                    child: Text(
                                                      'حدث خطأ ما',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 24,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                  backgroundColor: coolWhite2,
                  appBar: const CustomAppBar(),
                  body: Row(
                    children: [
                      if(screenWidth>1530)
                        const SideBarScreen(),
                      SingleChildScrollView(
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
                                  if(screenWidth>=800)
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 20, end: 130),
                                      child: Row(
                                        children: [
                                          Builder(
                                              builder: (context) {
                                                if(modee=='light')
                                                {
                                                  return InkWell(
                                                    child: const Image(
                                                      image: AssetImage('images/arrow.png'),
                                                      width: 30,
                                                      height: 20,
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                }
                                                else{
                                                  return InkWell(
                                                    child: Icon(Icons.arrow_back,color:Colors.orange,size: 30,),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                }

                                              }
                                          ),
                                          if(screenWidth>=1200)
                                            const SizedBox(width: 20),
                                          if(screenWidth<1200)
                                            const SizedBox(width: 10),
                                          if(screenWidth>=1200&&modee=='light')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 28, color: blueText),
                                            ),
                                          if(screenWidth>=1200&&modee=='dark')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 28, color: Colors.orange),
                                            ),
                                          if(screenWidth<1200&&modee=='light')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 14, color: blueText),
                                            ),
                                          if(screenWidth<1200&&modee=='dark')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 14, color: Colors.orange),
                                            ),
                                          const Spacer(),
                                          if(screenWidth>=1200)
                                            Flexible(
                                              child: SizedBox(
                                                width: 200,
                                                child: CustomSearchField(
                                                  onChanged: (searchText) {
                                                    setState(() {
                                                      if (searchText != null ||
                                                          searchText != '') {
                                                        addPatientsToSearchList(searchText);
                                                      } else {
                                                        searchPatient = [];
                                                      }
                                                    });
                                                  },
                                                  icon: Icons.search,
                                                  hintText: 'Search',
                                                  controller: searchController,
                                                ),
                                              ),
                                            ),
                                          if(screenWidth<1200)
                                            Flexible(
                                              child: SizedBox(
                                                width: 100,
                                                child: CustomSearchField(
                                                  onChanged: (searchText) {
                                                    setState(() {
                                                      if (searchText != null ||
                                                          searchText != '') {
                                                        addPatientsToSearchList(searchText);
                                                      } else {
                                                        searchPatient = [];
                                                      }
                                                    });
                                                  },
                                                  icon: Icons.search,
                                                  hintText: 'Search',
                                                  controller: searchController,
                                                ),
                                              ),
                                            ),
                                          if(screenWidth>=1200)
                                            const SizedBox(
                                              width: 20,
                                            ),
                                          if(screenWidth<1200)
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          Builder(
                                              builder: (context) {
                                                if(roleFromBackend=='secretary'&&screenWidth>=1200)
                                                {

                                                  return SizedBox(width: 250,);
                                                }
                                                else if(roleFromBackend=='secretary'&&screenWidth<1200)
                                                {
                                                  return SizedBox(width: 20,);
                                                }
                                                else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='light')
                                                {
                                                  return  Container(
                                                    width: 100,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: blueText,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // addNewTreatment(context);
                                                        addBasicInformation(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [
                                                          Text(
                                                            'Add',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='dark')
                                                {
                                                  return  Container(
                                                    width: 100,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orangeAccent,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // addNewTreatment(context);
                                                        addBasicInformation(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [
                                                          Text(
                                                            'Add',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  );
                                                }

                                                else{
                                                  return Builder(
                                                      builder: (context) {
                                                        if(modee=='light')
                                                        {
                                                          return Container(
                                                            width: 250,
                                                            height: 45,
                                                            decoration: BoxDecoration(
                                                              color: blueText,
                                                              borderRadius: BorderRadius.circular(30),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () {
                                                                // addNewTreatment(context);
                                                                addBasicInformation(context);
                                                              },
                                                              child: const Padding(
                                                                padding:
                                                                EdgeInsetsDirectional.only(start: 30),
                                                                child: Row(children: [
                                                                  Icon(
                                                                    Icons.add,
                                                                    size: 30,
                                                                    color: Colors.white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(
                                                                    'Add patient',
                                                                    style: TextStyle(
                                                                      fontSize: 18,
                                                                      color: Colors.white,
                                                                    ),
                                                                  )
                                                                ]),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        else{
                                                          return Container(
                                                            width: 250,
                                                            height: 45,
                                                            decoration: BoxDecoration(
                                                              color: Colors.orangeAccent,
                                                              borderRadius: BorderRadius.circular(30),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () {
                                                                // addNewTreatment(context);
                                                                addBasicInformation(context);
                                                              },
                                                              child: const Padding(
                                                                padding:
                                                                EdgeInsetsDirectional.only(start: 30),
                                                                child: Row(children: [
                                                                  Icon(
                                                                    Icons.add,
                                                                    size: 30,
                                                                    color: Colors.white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(
                                                                    'Add patient',
                                                                    style: TextStyle(
                                                                      fontSize: 18,
                                                                      color: Colors.white,
                                                                    ),
                                                                  )
                                                                ]),
                                                              ),
                                                            ),
                                                          );
                                                        }

                                                      }
                                                  );
                                                }


                                              }
                                          ),
                                        ],
                                      ),
                                    ),
                                  if(screenWidth<800&&screenWidth>=700)
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 20, end: 20),
                                      child: Row(
                                        children: [
                                          Builder(
                                              builder: (context) {
                                                if(modee=='light')
                                                {
                                                  return InkWell(
                                                    child: const Image(
                                                      image: AssetImage('images/arrow.png'),
                                                      width: 30,
                                                      height: 20,
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                }
                                                else{
                                                  return InkWell(
                                                    child: Icon(Icons.arrow_back,color:Colors.orange,size: 30,),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                }

                                              }
                                          ),
                                          if(screenWidth>=1200)
                                            const SizedBox(width: 20),
                                          if(screenWidth<1200)
                                            const SizedBox(width: 10),
                                          if(screenWidth>=1200&&modee=='light')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 28, color: blueText),
                                            ),
                                          if(screenWidth>=1200&&modee=='dark')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 28, color: Colors.orange),
                                            ),
                                          if(screenWidth<1200&&modee=='light')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 14, color: blueText),
                                            ),
                                          if(screenWidth<1200&&modee=='dark')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 14, color: Colors.orange),
                                            ),
                                          const Spacer(),
                                          if(screenWidth>=1200)
                                            Flexible(
                                              child: SizedBox(
                                                width: 200,
                                                child: CustomSearchField(
                                                  onChanged: (searchText) {
                                                    setState(() {
                                                      if (searchText != null ||
                                                          searchText != '') {
                                                        addPatientsToSearchList(searchText);
                                                      } else {
                                                        searchPatient = [];
                                                      }
                                                    });
                                                  },
                                                  icon: Icons.search,
                                                  hintText: 'Search',
                                                  controller: searchController,
                                                ),
                                              ),
                                            ),
                                          if(screenWidth<1200)
                                            Flexible(
                                              child: SizedBox(
                                                width: 100,
                                                child: CustomSearchField(
                                                  onChanged: (searchText) {
                                                    setState(() {
                                                      if (searchText != null ||
                                                          searchText != '') {
                                                        addPatientsToSearchList(searchText);
                                                      } else {
                                                        searchPatient = [];
                                                      }
                                                    });
                                                  },
                                                  icon: Icons.search,
                                                  hintText: 'Search',
                                                  controller: searchController,
                                                ),
                                              ),
                                            ),
                                          if(screenWidth>=1200)
                                            const SizedBox(
                                              width: 20,
                                            ),
                                          if(screenWidth<1200)
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          Builder(
                                              builder: (context) {
                                                if(roleFromBackend=='secretary'&&screenWidth>=1200)
                                                {

                                                  return SizedBox(width: 250,);
                                                }
                                                else if(roleFromBackend=='secretary'&&screenWidth<1200)
                                                {
                                                  return SizedBox(width: 20,);
                                                }
                                                else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='light')
                                                {
                                                  return  Container(
                                                    width: 100,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: blueText,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // addNewTreatment(context);
                                                        addBasicInformation(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [
                                                          Text(
                                                            'Add',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='dark')
                                                {
                                                  return  Container(
                                                    width: 100,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orangeAccent,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // addNewTreatment(context);
                                                        addBasicInformation(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [
                                                          Text(
                                                            'Add',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  );
                                                }

                                                else{
                                                  return Container(
                                                    width: 250,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: blueText,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // addNewTreatment(context);
                                                        addBasicInformation(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [
                                                          Icon(
                                                            Icons.add,
                                                            size: 30,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            'Add patient',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  );
                                                }


                                              }
                                          ),
                                        ],
                                      ),
                                    ),
                                  if(screenWidth<700)
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 5, end: 5),
                                      child: Row(
                                        children: [
                                          if(screenWidth>=1200)
                                            const SizedBox(width: 20),
                                          if(screenWidth<1200)
                                            const SizedBox(width: 10),
                                          if(screenWidth>=1200&&modee=='light')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 28, color: blueText),
                                            ),
                                          if(screenWidth>=1200&&modee=='dark')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 28, color: Colors.orange),
                                            ),
                                          if(screenWidth<1200&&modee=='light')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 14, color: blueText),
                                            ),
                                          if(screenWidth<1200&&modee=='dark')
                                            const Text(
                                              'Patients',
                                              style:
                                              TextStyle(fontSize: 14, color: Colors.orange),
                                            ),
                                          const Spacer(),
                                          if(screenWidth>=1200)
                                            Flexible(
                                              child: SizedBox(
                                                width: 200,
                                                child: CustomSearchField(
                                                  onChanged: (searchText) {
                                                    setState(() {
                                                      if (searchText != null ||
                                                          searchText != '') {
                                                        addPatientsToSearchList(searchText);
                                                      } else {
                                                        searchPatient = [];
                                                      }
                                                    });
                                                  },
                                                  icon: Icons.search,
                                                  hintText: 'Search',
                                                  controller: searchController,
                                                ),
                                              ),
                                            ),
                                          if(screenWidth<1200)
                                            Flexible(
                                              child: SizedBox(
                                                width: 100,
                                                child: CustomSearchField(
                                                  onChanged: (searchText) {
                                                    setState(() {
                                                      if (searchText != null ||
                                                          searchText != '') {
                                                        addPatientsToSearchList(searchText);
                                                      } else {
                                                        searchPatient = [];
                                                      }
                                                    });
                                                  },
                                                  icon: Icons.search,
                                                  hintText: 'Search',
                                                  controller: searchController,
                                                ),
                                              ),
                                            ),
                                          if(screenWidth>=1200)
                                            const SizedBox(
                                              width: 20,
                                            ),
                                          if(screenWidth<1200)
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          Builder(
                                              builder: (context) {
                                                if(roleFromBackend=='secretary'&&screenWidth>=1200)
                                                {

                                                  return SizedBox(width: 250,);
                                                }
                                                else if(roleFromBackend=='secretary'&&screenWidth<1200)
                                                {
                                                  return SizedBox(width: 20,);
                                                }
                                                else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='light')
                                                {
                                                  return  Container(
                                                    width: 100,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: blueText,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // addNewTreatment(context);
                                                        addBasicInformation(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [
                                                          Text(
                                                            'Add',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                else if(roleFromBackend!='secretary'&&screenWidth<1200&&modee=='dark')
                                                {
                                                  return  Container(
                                                    width: 100,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orangeAccent,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // addNewTreatment(context);
                                                        addBasicInformation(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [
                                                          Text(
                                                            'Add',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  );
                                                }

                                                else{
                                                  return Container(
                                                    width: 250,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: blueText,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // addNewTreatment(context);
                                                        addBasicInformation(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [
                                                          Icon(
                                                            Icons.add,
                                                            size: 30,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            'Add patient',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  );
                                                }


                                              }
                                          ),
                                        ],
                                      ),
                                    ),

                                  const SizedBox(height: 60),
                                  Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(end: 175.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.70,
                                      height: 450,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 18),
                                          const SizedBox(height: 10),
                                          if(screenWidth>=1450)
                                            Row(
                                              children: [
                                                Container(
                                                  width: 900,
                                                  height: 1,
                                                  color: dividerColor,
                                                ),
                                              ],
                                            ),
                                          const SizedBox(height: 10),
                                          Builder(
                                            builder: (context) {
                                              if(DrAidCubit.get(context).getAllPatientsModel?.data!=null)
                                              {
                                                if(DrAidCubit.get(context).getAllPatientsModel!.data.isNotEmpty)
                                                {
                                                  return Expanded(
                                                    child: Builder(builder: (context) {
                                                      if (searchPatient.isNotEmpty ||
                                                          searchPatient == []) {
                                                        return ListView.separated(
                                                            itemBuilder:
                                                                (context, index) {
                                                              return Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .only(start: 30),
                                                                child: Row(
                                                                  children: [
                                                                    if(screenWidth>=1450)
                                                                      const SizedBox(
                                                                          width: 30),
                                                                    Expanded(
                                                                      child: Text(
                                                                        searchPatient[
                                                                        index]
                                                                            .fullName,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                    if(screenWidth>=1450)
                                                                      const SizedBox(
                                                                          width: 40),
                                                                    if(screenWidth>=1400)
                                                                      Expanded(
                                                                        child: Text(
                                                                          searchPatient[
                                                                          index]
                                                                              .age
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    const SizedBox(
                                                                        width: 10),
                                                                    if(screenWidth>=1400)
                                                                      Expanded(
                                                                        child: Text(
                                                                          searchPatient[
                                                                          index]
                                                                              .gender,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1400)
                                                                      Expanded(
                                                                        child: Text(
                                                                          searchPatient[
                                                                          index]
                                                                              .address,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1400)
                                                                      Container(
                                                                        width: 130,
                                                                        height: 35,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          color: coolGreen1,
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              30),
                                                                        ),
                                                                        child: Builder(
                                                                            builder: (context) {
                                                                              if(roleFromBackend=='secretary')
                                                                              {
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection: TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientBasicInformationForSecretary()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        'Basics',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    ));
                                                                              }
                                                                              else{
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection: TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientInformationLayout()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        '  File  ',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    ));
                                                                              }

                                                                            }
                                                                        ),
                                                                      ),
                                                                    if(screenWidth<1400)
                                                                      Container(
                                                                        width: 80,
                                                                        height: 35,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          color: coolGreen1,
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              30),
                                                                        ),
                                                                        child: Builder(
                                                                            builder: (context) {
                                                                              if(roleFromBackend=='secretary')
                                                                              {
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection: TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientBasicInformationForSecretary()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        'Info',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    ));
                                                                              }
                                                                              else{
                                                                                return InkWell(
                                                                                    onTap: () {
                                                                                      patientId = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId
                                                                                          .toString();
                                                                                      int patientIdd = searchPatient[
                                                                                      index]
                                                                                          .patientClinic
                                                                                          .patientId;
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .patientId =
                                                                                          patientIdd;
                                                                                      if (patientId !=
                                                                                          '0') {
                                                                                        DrAidCubit.get(
                                                                                            context)
                                                                                            .getPatientData(
                                                                                          patientId:
                                                                                          patientId,
                                                                                        );
                                                                                      }
                                                                                      navigateTo(
                                                                                          context,
                                                                                          const Directionality(
                                                                                              textDirection: TextDirection
                                                                                                  .rtl,
                                                                                              child:
                                                                                              PatientInformationLayout()));
                                                                                    },
                                                                                    child:
                                                                                    const Center(
                                                                                      child: Text(
                                                                                        'File',
                                                                                        style:
                                                                                        TextStyle(
                                                                                          fontSize:
                                                                                          12,
                                                                                          color:
                                                                                          white,
                                                                                        ),
                                                                                      ),
                                                                                    ));
                                                                              }

                                                                            }
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1400)
                                                                      const SizedBox(
                                                                          width: 75),
                                                                    if(screenWidth<1400)
                                                                      const SizedBox(
                                                                          width: 10),
                                                                    if(screenWidth>=1450)
                                                                      Container(
                                                                        width: 70,
                                                                        height: 40,
                                                                        color: Colors.white,
                                                                        child: const Center(
                                                                          child: Row(
                                                                            children: [
                                                                              Image(
                                                                                image: AssetImage(
                                                                                    'images/edit1.png'),
                                                                                width: 25,
                                                                                height: 25,
                                                                              ),
                                                                              SizedBox(
                                                                                  width:
                                                                                  10),
                                                                              Image(
                                                                                image: AssetImage(
                                                                                    'images/delete.png'),
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
                                                            separatorBuilder:
                                                                (context, index) {
                                                              return const SizedBox(
                                                                  height: 10);
                                                            },
                                                            itemCount:
                                                            searchPatient.length);
                                                      } else {
                                                        return ListView.separated(
                                                          itemBuilder: (context, index) {
                                                            final patient =
                                                                DrAidCubit.get(context)
                                                                    .getAllPatientsModel;
                                                            return Padding(
                                                              padding:
                                                              const EdgeInsetsDirectional
                                                                  .only(start: 30),
                                                              child: Row(
                                                                children: [
                                                                  if(screenWidth>=1450)
                                                                    const SizedBox(
                                                                        width: 30),
                                                                  Expanded(
                                                                    child: Text(
                                                                      patient!.data[index]
                                                                          .fullName,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color:
                                                                          fontColor),
                                                                    ),
                                                                  ),
                                                                  if(screenWidth>=1450)
                                                                    const SizedBox(
                                                                        width: 40),
                                                                  if(screenWidth>=1400)
                                                                    Expanded(
                                                                      child: Text(
                                                                        patient
                                                                            .data[index].age
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                  const SizedBox(
                                                                      width: 10),
                                                                  if(screenWidth>=1400)
                                                                    Expanded(
                                                                      child: Text(
                                                                        patient.data[index]
                                                                            .gender,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                  if(screenWidth>=1350)
                                                                    Expanded(
                                                                      child: Text(
                                                                        patient.data[index]
                                                                            .address,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                  if(screenWidth>=1400)
                                                                    Container(
                                                                      width: 130,
                                                                      height: 35,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: coolGreen1,
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            30),
                                                                      ),
                                                                      child:
                                                                      Builder(
                                                                          builder: (context) {
                                                                            if(roleFromBackend=='secretary')
                                                                            {
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection:
                                                                                            TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientBasicInformationForSecretary()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      'Basics',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            }
                                                                            else{
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection:
                                                                                            TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientInformationLayout()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      '  File  ',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            }

                                                                          }
                                                                      ),
                                                                    ),
                                                                  if(screenWidth<1400)
                                                                    Container(
                                                                      width: 80,
                                                                      height: 35,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: coolGreen1,
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            30),
                                                                      ),
                                                                      child:
                                                                      Builder(
                                                                          builder: (context) {
                                                                            if(roleFromBackend=='secretary')
                                                                            {
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection:
                                                                                            TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientBasicInformationForSecretary()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      'Info',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            }
                                                                            else{
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = patient
                                                                                        .data[index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection:
                                                                                            TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientInformationLayout()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      'File',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                              );
                                                                            }

                                                                          }
                                                                      ),
                                                                    ),
                                                                  if(screenWidth>=1450)
                                                                    const SizedBox(
                                                                        width: 75),
                                                                  if(screenWidth<1450)
                                                                    const SizedBox(
                                                                        width: 10),
                                                                  if(screenWidth>=1450)
                                                                    Container(
                                                                      width: 70,
                                                                      height: 40,
                                                                      color: Colors.white,
                                                                      child: const Center(
                                                                        child: Row(
                                                                          children: [
                                                                            Image(
                                                                              image: AssetImage(
                                                                                  'images/edit1.png'),
                                                                              width: 25,
                                                                              height: 25,
                                                                            ),
                                                                            SizedBox(
                                                                                width: 10),
                                                                            Image(
                                                                              image: AssetImage(
                                                                                  'images/delete.png'),
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
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                                height: 10);
                                                          },
                                                          itemCount:
                                                          DrAidCubit.get(context)
                                                              .getAllPatientsModel!
                                                              .data
                                                              .length,
                                                        );
                                                      }
                                                    }),
                                                  );
                                                }
                                              }

                                              if (state
                                              is DrAidGetAllPatientsSuccessState||DrAidCubit.get(context).getAllPatientsModel?.data!=null) {
                                                return Expanded(
                                                  child: Builder(builder: (context) {
                                                    if (searchPatient.isNotEmpty ||
                                                        searchPatient == []) {
                                                      return ListView.separated(
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                              const EdgeInsetsDirectional
                                                                  .only(start: 30),
                                                              child: Row(
                                                                children: [
                                                                  if(screenWidth>=1450)
                                                                    const SizedBox(
                                                                        width: 30),
                                                                  Expanded(
                                                                    child: Text(
                                                                      searchPatient[
                                                                      index]
                                                                          .fullName,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color:
                                                                          fontColor),
                                                                    ),
                                                                  ),
                                                                  if(screenWidth>=1450)
                                                                    const SizedBox(
                                                                        width: 40),
                                                                  if(screenWidth>=1400)
                                                                    Expanded(
                                                                      child: Text(
                                                                        searchPatient[
                                                                        index]
                                                                            .age
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                  const SizedBox(
                                                                      width: 10),
                                                                  if(screenWidth>=1400)
                                                                    Expanded(
                                                                      child: Text(
                                                                        searchPatient[
                                                                        index]
                                                                            .gender,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                  if(screenWidth>=1400)
                                                                    Expanded(
                                                                      child: Text(
                                                                        searchPatient[
                                                                        index]
                                                                            .address,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                  if(screenWidth>=1400)
                                                                    Container(
                                                                      width: 130,
                                                                      height: 35,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: coolGreen1,
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            30),
                                                                      ),
                                                                      child: Builder(
                                                                          builder: (context) {
                                                                            if(roleFromBackend=='secretary')
                                                                            {
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = searchPatient[
                                                                                    index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = searchPatient[
                                                                                    index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection: TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientBasicInformationForSecretary()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      'Basics',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  ));
                                                                            }
                                                                            else{
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = searchPatient[
                                                                                    index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = searchPatient[
                                                                                    index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection: TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientInformationLayout()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      '  File  ',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  ));
                                                                            }

                                                                          }
                                                                      ),
                                                                    ),
                                                                  if(screenWidth<1400)
                                                                    Container(
                                                                      width: 80,
                                                                      height: 35,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: coolGreen1,
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            30),
                                                                      ),
                                                                      child: Builder(
                                                                          builder: (context) {
                                                                            if(roleFromBackend=='secretary')
                                                                            {
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = searchPatient[
                                                                                    index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = searchPatient[
                                                                                    index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection: TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientBasicInformationForSecretary()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      'Info',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  ));
                                                                            }
                                                                            else{
                                                                              return InkWell(
                                                                                  onTap: () {
                                                                                    patientId = searchPatient[
                                                                                    index]
                                                                                        .patientClinic
                                                                                        .patientId
                                                                                        .toString();
                                                                                    int patientIdd = searchPatient[
                                                                                    index]
                                                                                        .patientClinic
                                                                                        .patientId;
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .patientId =
                                                                                        patientIdd;
                                                                                    if (patientId !=
                                                                                        '0') {
                                                                                      DrAidCubit.get(
                                                                                          context)
                                                                                          .getPatientData(
                                                                                        patientId:
                                                                                        patientId,
                                                                                      );
                                                                                    }
                                                                                    navigateTo(
                                                                                        context,
                                                                                        const Directionality(
                                                                                            textDirection: TextDirection
                                                                                                .rtl,
                                                                                            child:
                                                                                            PatientInformationLayout()));
                                                                                  },
                                                                                  child:
                                                                                  const Center(
                                                                                    child: Text(
                                                                                      'File',
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize:
                                                                                        12,
                                                                                        color:
                                                                                        white,
                                                                                      ),
                                                                                    ),
                                                                                  ));
                                                                            }

                                                                          }
                                                                      ),
                                                                    ),
                                                                  if(screenWidth>=1400)
                                                                    const SizedBox(
                                                                        width: 75),
                                                                  if(screenWidth<1400)
                                                                    const SizedBox(
                                                                        width: 10),
                                                                  if(screenWidth>=1450)
                                                                    Container(
                                                                      width: 70,
                                                                      height: 40,
                                                                      color: Colors.white,
                                                                      child: const Center(
                                                                        child: Row(
                                                                          children: [
                                                                            Image(
                                                                              image: AssetImage(
                                                                                  'images/edit1.png'),
                                                                              width: 25,
                                                                              height: 25,
                                                                            ),
                                                                            SizedBox(
                                                                                width:
                                                                                10),
                                                                            Image(
                                                                              image: AssetImage(
                                                                                  'images/delete.png'),
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
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                                height: 10);
                                                          },
                                                          itemCount:
                                                          searchPatient.length);
                                                    } else {
                                                      return ListView.separated(
                                                        itemBuilder: (context, index) {
                                                          final patient =
                                                              DrAidCubit.get(context)
                                                                  .getAllPatientsModel;
                                                          return Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .only(start: 30),
                                                            child: Row(
                                                              children: [
                                                                if(screenWidth>=1450)
                                                                  const SizedBox(
                                                                      width: 30),
                                                                Expanded(
                                                                  child: Text(
                                                                    patient!.data[index]
                                                                        .fullName,
                                                                    style: const TextStyle(
                                                                        fontSize: 16,
                                                                        color:
                                                                        fontColor),
                                                                  ),
                                                                ),
                                                                if(screenWidth>=1450)
                                                                  const SizedBox(
                                                                      width: 40),
                                                                if(screenWidth>=1400)
                                                                  Expanded(
                                                                    child: Text(
                                                                      patient
                                                                          .data[index].age
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color:
                                                                          fontColor),
                                                                    ),
                                                                  ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                if(screenWidth>=1400)
                                                                  Expanded(
                                                                    child: Text(
                                                                      patient.data[index]
                                                                          .gender,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color:
                                                                          fontColor),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=1400)
                                                                  Expanded(
                                                                    child: Text(
                                                                      patient.data[index]
                                                                          .address,
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          color:
                                                                          fontColor),
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=1350)
                                                                  Container(
                                                                    width: 130,
                                                                    height: 35,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: coolGreen1,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          30),
                                                                    ),
                                                                    child:
                                                                    Builder(
                                                                        builder: (context) {
                                                                          if(roleFromBackend=='secretary')
                                                                          {
                                                                            return InkWell(
                                                                                onTap: () {
                                                                                  patientId = patient
                                                                                      .data[index]
                                                                                      .patientClinic
                                                                                      .patientId
                                                                                      .toString();
                                                                                  int patientIdd = patient
                                                                                      .data[index]
                                                                                      .patientClinic
                                                                                      .patientId;
                                                                                  DrAidCubit.get(
                                                                                      context)
                                                                                      .patientId =
                                                                                      patientIdd;
                                                                                  if (patientId !=
                                                                                      '0') {
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .getPatientData(
                                                                                      patientId:
                                                                                      patientId,
                                                                                    );
                                                                                  }
                                                                                  navigateTo(
                                                                                      context,
                                                                                      const Directionality(
                                                                                          textDirection:
                                                                                          TextDirection
                                                                                              .rtl,
                                                                                          child:
                                                                                          PatientBasicInformationForSecretary()));
                                                                                },
                                                                                child:
                                                                                const Center(
                                                                                  child: Text(
                                                                                    'Basics',
                                                                                    style:
                                                                                    TextStyle(
                                                                                      fontSize:
                                                                                      12,
                                                                                      color:
                                                                                      white,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                            );
                                                                          }
                                                                          else{
                                                                            return InkWell(
                                                                                onTap: () {
                                                                                  patientId = patient
                                                                                      .data[index]
                                                                                      .patientClinic
                                                                                      .patientId
                                                                                      .toString();
                                                                                  int patientIdd = patient
                                                                                      .data[index]
                                                                                      .patientClinic
                                                                                      .patientId;
                                                                                  DrAidCubit.get(
                                                                                      context)
                                                                                      .patientId =
                                                                                      patientIdd;
                                                                                  if (patientId !=
                                                                                      '0') {
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .getPatientData(
                                                                                      patientId:
                                                                                      patientId,
                                                                                    );
                                                                                  }
                                                                                  navigateTo(
                                                                                      context,
                                                                                      const Directionality(
                                                                                          textDirection:
                                                                                          TextDirection
                                                                                              .rtl,
                                                                                          child:
                                                                                          PatientInformationLayout()));
                                                                                },
                                                                                child:
                                                                                const Center(
                                                                                  child: Text(
                                                                                    '  File  ',
                                                                                    style:
                                                                                    TextStyle(
                                                                                      fontSize:
                                                                                      12,
                                                                                      color:
                                                                                      white,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                            );
                                                                          }

                                                                        }
                                                                    ),
                                                                  ),
                                                                if(screenWidth<1350)
                                                                  Container(
                                                                    width: 80,
                                                                    height: 35,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: coolGreen1,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          30),
                                                                    ),
                                                                    child:
                                                                    Builder(
                                                                        builder: (context) {
                                                                          if(roleFromBackend=='secretary')
                                                                          {
                                                                            return InkWell(
                                                                                onTap: () {
                                                                                  patientId = patient
                                                                                      .data[index]
                                                                                      .patientClinic
                                                                                      .patientId
                                                                                      .toString();
                                                                                  int patientIdd = patient
                                                                                      .data[index]
                                                                                      .patientClinic
                                                                                      .patientId;
                                                                                  DrAidCubit.get(
                                                                                      context)
                                                                                      .patientId =
                                                                                      patientIdd;
                                                                                  if (patientId !=
                                                                                      '0') {
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .getPatientData(
                                                                                      patientId:
                                                                                      patientId,
                                                                                    );
                                                                                  }
                                                                                  navigateTo(
                                                                                      context,
                                                                                      const Directionality(
                                                                                          textDirection:
                                                                                          TextDirection
                                                                                              .rtl,
                                                                                          child:
                                                                                          PatientBasicInformationForSecretary()));
                                                                                },
                                                                                child:
                                                                                const Center(
                                                                                  child: Text(
                                                                                    'Info',
                                                                                    style:
                                                                                    TextStyle(
                                                                                      fontSize:
                                                                                      12,
                                                                                      color:
                                                                                      white,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                            );
                                                                          }
                                                                          else{
                                                                            return InkWell(
                                                                                onTap: () {
                                                                                  patientId = patient
                                                                                      .data[index]
                                                                                      .patientClinic
                                                                                      .patientId
                                                                                      .toString();
                                                                                  int patientIdd = patient
                                                                                      .data[index]
                                                                                      .patientClinic
                                                                                      .patientId;
                                                                                  DrAidCubit.get(
                                                                                      context)
                                                                                      .patientId =
                                                                                      patientIdd;
                                                                                  if (patientId !=
                                                                                      '0') {
                                                                                    DrAidCubit.get(
                                                                                        context)
                                                                                        .getPatientData(
                                                                                      patientId:
                                                                                      patientId,
                                                                                    );
                                                                                  }
                                                                                  navigateTo(
                                                                                      context,
                                                                                      const Directionality(
                                                                                          textDirection:
                                                                                          TextDirection
                                                                                              .rtl,
                                                                                          child:
                                                                                          PatientInformationLayout()));
                                                                                },
                                                                                child:
                                                                                const Center(
                                                                                  child: Text(
                                                                                    'File',
                                                                                    style:
                                                                                    TextStyle(
                                                                                      fontSize:
                                                                                      12,
                                                                                      color:
                                                                                      white,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                            );
                                                                          }

                                                                        }
                                                                    ),
                                                                  ),
                                                                if(screenWidth>=1000)
                                                                  const SizedBox(
                                                                      width: 75),
                                                                if(screenWidth<1000)
                                                                  const SizedBox(
                                                                      width: 10),
                                                                if(screenWidth>=1400)
                                                                  Container(
                                                                    width: 70,
                                                                    height: 40,
                                                                    color: Colors.white,
                                                                    child: const Center(
                                                                      child: Row(
                                                                        children: [
                                                                          Image(
                                                                            image: AssetImage(
                                                                                'images/edit1.png'),
                                                                            width: 25,
                                                                            height: 25,
                                                                          ),
                                                                          SizedBox(
                                                                              width: 10),
                                                                          Image(
                                                                            image: AssetImage(
                                                                                'images/delete.png'),
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
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return const SizedBox(
                                                              height: 10);
                                                        },
                                                        itemCount:
                                                        DrAidCubit.get(context)
                                                            .getAllPatientsModel!
                                                            .data
                                                            .length,
                                                      );
                                                    }
                                                  }),
                                                );
                                              }
                                              if (DrAidCubit.get(context)
                                                  .getAllPatientsModel!
                                                  .data
                                                  .isEmpty) {
                                                return const Column(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'No patients yet',
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                              if (state
                                              is DrAidGetAllPatientsLoadingState) {
                                                return const Center(
                                                    child: CircularProgressIndicator());
                                              } else {
                                                return const Center(
                                                  child: Text(
                                                    'Something went wrong',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
