import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ShowBasicInformation extends StatefulWidget {
  const ShowBasicInformation({super.key});

  @override
  State<ShowBasicInformation> createState() => _ShowBasicInformationState();
}

class _ShowBasicInformationState extends State<ShowBasicInformation> {
  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController habitsController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    genderController.text = 'Male';

    DateTime? selectedDate;

    void addBasicInformation(BuildContext context) {
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
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          if (state.errorText != null)
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 20, top: 5),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
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
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
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
                                          !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(
                                              phoneNumberController.text)) {
                                        return 'رقم الهاتف يجب أن يكون بين 10 و 15 رقماً، ويحتوي على أرقام فقط أو +';
                                      }
                                      return null;
                                    },
                                    builder: (state) {
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          if (state.errorText != null)
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 20, top: 5),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
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
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          if (state.errorText != null)
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 20, top: 5),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
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
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          if (state.errorText != null)
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 20, top: 5),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
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
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          if (state.errorText != null)
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 20, top: 5),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
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
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          if (state.errorText != null)
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 20, top: 5),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12),
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
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          icon: const Icon(Icons.arrow_drop_up),
                                          style:
                                          const TextStyle(color: Colors.black),
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
                                    EasyLoading.showError(
                                        'رجاءً اختر تاريخ الميلاد');
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
              textDirection: TextDirection.rtl,
              child: SimpleDialog(
                title: const Padding(
                  padding: EdgeInsetsDirectional.only(start: 30),
                  child: Text(
                    'Add',
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
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 15),
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
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
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 15),
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
                                        !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(
                                            phoneNumberController.text)) {
                                      return 'Phone number must be between 10 and 15';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
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
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 15),
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
                                      return 'Please enter the right email';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
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
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 15),
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
                                      return 'Please enter the right address at least 5 characters';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
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
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 15),
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
                                      return 'Please enter a valid age';
                                    }
                                    return null;
                                  },
                                  builder: (state) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
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
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 15),
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        if (state.errorText != null)
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 20, top: 5),
                                            child: Text(
                                              state.errorText!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
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
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 15),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        icon: const Icon(Icons.arrow_drop_up),
                                        style:
                                        const TextStyle(color: Colors.black),
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
                                  EasyLoading.showError(
                                      'Please enter birthday');
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

    return BlocConsumer<DrAidCubit, DrAidStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth < 600;
        final isTablet = screenWidth >= 600 && screenWidth < 1200;
        final isDesktop = screenWidth >= 1200;
        print(screenWidth);
        return Builder(
          builder: (context) {
            if(languagee=='arabic')
              {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 175.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 400,
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Builder(
                            builder: (context) {
                              if(screenWidth>=1480)
                                return ListView(
                                  children: [
                                    Column(
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              'اسم المريض',
                                              style: TextStyle(fontSize: 24, color: fontColor),
                                            ),
                                            SizedBox(
                                              width: 335,
                                            ),
                                            Text(
                                              'عمر المريض',
                                              style: TextStyle(fontSize: 24, color: fontColor),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            ItemBasicInformation(
                                              text:
                                              '${DrAidCubit.get(context).getPatientModel?.data.fullName}',
                                            ),
                                            const Spacer(),
                                            ItemBasicInformation(
                                              text:
                                              '${DrAidCubit.get(context).getPatientModel?.data.age}',
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              'عنوان المريض',
                                              style: TextStyle(fontSize: 24, color: fontColor),
                                            ),
                                            SizedBox(
                                              width: 335,
                                            ),
                                            Text(
                                              'رقم الهاتف',
                                              style: TextStyle(fontSize: 24, color: fontColor),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            ItemBasicInformation(
                                              text:
                                              '${DrAidCubit.get(context).getPatientModel?.data.address}',
                                            ),
                                            const Spacer(),
                                            ItemBasicInformation(
                                              text:
                                              '${DrAidCubit.get(context).getPatientModel?.data.phoneNumber}',
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            addBasicInformation(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(40),
                                            child: Container(
                                              height: 45,
                                              width: 230,
                                              decoration: BoxDecoration(
                                                color: buttonColor,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'إضافة مريض جديد',
                                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              else{
                                return ListView(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'اسم المريض',
                                          style: TextStyle(fontSize: 24, color: fontColor),
                                        ),

                                        const SizedBox(
                                          height: 15,
                                        ),
                                        ItemBasicInformation(
                                          text:
                                          '${DrAidCubit.get(context).getPatientModel?.data.fullName}',
                                        ),
                                        SizedBox(height: 15,),
                                        Text(
                                          'عمر المريض',
                                          style: TextStyle(fontSize: 24, color: fontColor),
                                        ),
                                        SizedBox(height: 15,),

                                        ItemBasicInformation(
                                          text:
                                          '${DrAidCubit.get(context).getPatientModel?.data.age}',
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Text(
                                          'عنوان المريض',
                                          style: TextStyle(fontSize: 24, color: fontColor),
                                        ),
                                        SizedBox(height: 15,),
                                        ItemBasicInformation(
                                          text:
                                          '${DrAidCubit.get(context).getPatientModel?.data.address}',
                                        ),
                                        SizedBox(height: 15,),

                                        Text(
                                          'رقم الهاتف',
                                          style: TextStyle(fontSize: 24, color: fontColor),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        ItemBasicInformation(
                                          text:
                                          '${DrAidCubit.get(context).getPatientModel?.data.phoneNumber}',
                                        ),
                                        SizedBox(height: 15,),
                                        if(screenWidth>=700)
                                          InkWell(
                                            onTap: () {
                                              addBasicInformation(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(40),
                                              child: Container(
                                                height: 45,
                                                width: 230,
                                                decoration: BoxDecoration(
                                                  color: buttonColor,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'إضافة مريض جديد',
                                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if(screenWidth<700)
                                          InkWell(
                                            onTap: () {
                                              addBasicInformation(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(40),
                                              child: Container(
                                                height: 45,
                                                width: 230,
                                                decoration: BoxDecoration(
                                                  color: buttonColor,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'إضافة مريض',
                                                    style: TextStyle(fontSize: 14, color: Colors.white),
                                                  ),
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
                  ),
                );
              }
            else{
              return Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 175.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Builder(
                          builder: (context) {
                            if(screenWidth>=1480)
                              return ListView(
                                children: [
                                  Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Text(
                                            'Name',
                                            style: TextStyle(fontSize: 24, color: fontColor),
                                          ),
                                          SizedBox(
                                            width: 335,
                                          ),
                                          Text(
                                            'Age',
                                            style: TextStyle(fontSize: 24, color: fontColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          ItemBasicInformation(
                                            text:
                                            '${DrAidCubit.get(context).getPatientModel?.data.fullName}',
                                          ),
                                          const Spacer(),
                                          ItemBasicInformation(
                                            text:
                                            '${DrAidCubit.get(context).getPatientModel?.data.age}',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            'Address',
                                            style: TextStyle(fontSize: 24, color: fontColor),
                                          ),
                                          SizedBox(
                                            width: 335,
                                          ),
                                          Text(
                                            'Phone number',
                                            style: TextStyle(fontSize: 24, color: fontColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          ItemBasicInformation(
                                            text:
                                            '${DrAidCubit.get(context).getPatientModel?.data.address}',
                                          ),
                                          const Spacer(),
                                          ItemBasicInformation(
                                            text:
                                            '${DrAidCubit.get(context).getPatientModel?.data.phoneNumber}',
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          addBasicInformation(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(40),
                                          child: Container(
                                            height: 45,
                                            width: 230,
                                            decoration: BoxDecoration(
                                              color: buttonColor,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Add patient',
                                                style: TextStyle(fontSize: 18, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            else{
                              return ListView(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Name',
                                        style: TextStyle(fontSize: 24, color: fontColor),
                                      ),

                                      const SizedBox(
                                        height: 15,
                                      ),
                                      ItemBasicInformation(
                                        text:
                                        '${DrAidCubit.get(context).getPatientModel?.data.fullName}',
                                      ),
                                      SizedBox(height: 15,),
                                      Text(
                                        'Age',
                                        style: TextStyle(fontSize: 24, color: fontColor),
                                      ),
                                      SizedBox(height: 15,),

                                      ItemBasicInformation(
                                        text:
                                        '${DrAidCubit.get(context).getPatientModel?.data.age}',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Text(
                                        'Age',
                                        style: TextStyle(fontSize: 24, color: fontColor),
                                      ),
                                      SizedBox(height: 15,),
                                      ItemBasicInformation(
                                        text:
                                        '${DrAidCubit.get(context).getPatientModel?.data.address}',
                                      ),
                                      SizedBox(height: 15,),

                                      Text(
                                        'Phone number',
                                        style: TextStyle(fontSize: 24, color: fontColor),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      ItemBasicInformation(
                                        text:
                                        '${DrAidCubit.get(context).getPatientModel?.data.phoneNumber}',
                                      ),
                                      SizedBox(height: 15,),
                                      if(screenWidth>=700)
                                        InkWell(
                                          onTap: () {
                                            addBasicInformation(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(40),
                                            child: Container(
                                              height: 45,
                                              width: 230,
                                              decoration: BoxDecoration(
                                                color: buttonColor,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Add patient',
                                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if(screenWidth<700)
                                        InkWell(
                                          onTap: () {
                                            addBasicInformation(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(40),
                                            child: Container(
                                              height: 45,
                                              width: 230,
                                              decoration: BoxDecoration(
                                                color: buttonColor,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Add',
                                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                                ),
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
                ),
              );
            }

          }
        );
      },
    );
  }
}
