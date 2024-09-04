// ignore_for_file: use_build_context_synchronously

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/modules/sidebar/side_bar_screen.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ShowAllTreatments extends StatefulWidget {
  const ShowAllTreatments({super.key});

  @override
  State<ShowAllTreatments> createState() => _ShowAllTreatmentsState();
}

class _ShowAllTreatmentsState extends State<ShowAllTreatments> {
  @override
  void initState() {
    super.initState();
    final cubit = DrAidCubit.get(context);

    cubit.getAllTreatments();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController defaultCostController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  double screenWidthForTreatments=0;

  Color selectedColor = Colors.white;

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (context) {
            if(languagee=='arabic')
              {
                return AlertDialog(
                  title: const Text('اختيار لون'),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      pickerColor: selectedColor,
                      onColorChanged: (Color color) {
                        setState(() {
                          selectedColor = color;
                          colorController.text = colorToHex(color);
                        });
                      },
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text(
                        'اختيار',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
            else{
              return AlertDialog(
                title: const Text('Choose color'),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: selectedColor,
                    onColorChanged: (Color color) {
                      setState(() {
                        selectedColor = color;
                        colorController.text = colorToHex(color);
                      });
                    },
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text(
                      'Choose',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }

          }
        );
      },
    );
  }

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  void addNewTreatment(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          if(languagee=='arabic')
            {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: SimpleDialog(
                  title: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 150),
                    child: Text(
                      'إضافة علاج جديد',
                      style: TextStyle(
                        fontSize: 18,
                        color: simpleDialogTitleColor,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 600,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsetsDirectional.only(start: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'اسم العلاج',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: fontColor,
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
                              child: Column(
                                children: [
                                  if(screenWidthForTreatments>=1470)
                                    Container(
                                      height: 40,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: borderColor,
                                          width: 1,
                                        ),
                                      ),
                                      margin:
                                      const EdgeInsetsDirectional.only(start: 20),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 15),
                                        child: AddTreatmentFormField(
                                            type: TextInputType.emailAddress,
                                            controller: titleController,
                                            label: 'اسم العلاج'),
                                      ),
                                    ),
                                  if(screenWidthForTreatments<1470)
                                    Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: borderColor,
                                          width: 1,
                                        ),
                                      ),
                                      margin:
                                      const EdgeInsetsDirectional.only(start: 20),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 15),
                                        child: AddTreatmentFormField(
                                            type: TextInputType.emailAddress,
                                            controller: titleController,
                                            label: 'الاسم '),
                                      ),
                                    ),
                                  FormField(
                                    validator: (value) {
                                      if (titleController.text.isEmpty) {
                                        return 'رجاءً ادخل اسم العلاج';
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
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsetsDirectional.only(start: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'الاختصاص',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: fontColor,
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
                              child: Column(
                                children: [
                                  if(screenWidthForTreatments>=1470)
                                    Container(
                                      height: 40,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: borderColor,
                                          width: 1,
                                        ),
                                      ),
                                      margin:
                                      const EdgeInsetsDirectional.only(start: 20),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 15),
                                        child: AddTreatmentFormField(
                                            type: TextInputType.emailAddress,
                                            controller: categoryController,
                                            label: 'الاختصاص'),
                                      ),
                                    ),
                                  if(screenWidthForTreatments<1470)
                                    Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: borderColor,
                                          width: 1,
                                        ),
                                      ),
                                      margin:
                                      const EdgeInsetsDirectional.only(start: 20),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 15),
                                        child: AddTreatmentFormField(
                                            type: TextInputType.emailAddress,
                                            controller: categoryController,
                                            label: 'الاختصاص'),
                                      ),
                                    ),
                                  FormField(
                                    validator: (value) {
                                      if (categoryController.text.isEmpty) {
                                        return 'رجاءً ادخل الاختصاص ';
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
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 20),
                              child: Row(
                                children: [
                                  if(screenWidthForTreatments>=1470)
                                    Text(
                                      'الكلفة الافتراضية',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: fontColor,
                                      ),
                                    ),
                                  if(screenWidthForTreatments<1470)
                                    Text(
                                      'الكلفة',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: fontColor,
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
                              child: Column(
                                children: [
                                  if(screenWidthForTreatments>=1470)
                                    Container(
                                      height: 40,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: borderColor,
                                          width: 1,
                                        ),
                                      ),
                                      margin:
                                      const EdgeInsetsDirectional.only(start: 20),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 15),
                                        child: AddTreatmentFormField(
                                            type: TextInputType.emailAddress,
                                            controller: defaultCostController,
                                            label: 'الكلفة الافتراضية'),
                                      ),
                                    ),
                                  if(screenWidthForTreatments<1470)
                                    Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: borderColor,
                                          width: 1,
                                        ),
                                      ),
                                      margin:
                                      const EdgeInsetsDirectional.only(start: 20),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 15),
                                        child: AddTreatmentFormField(
                                            type: TextInputType.emailAddress,
                                            controller: defaultCostController,
                                            label: 'الكلفة'),
                                      ),
                                    ),
                                  FormField(
                                    validator: (value) {
                                      if (defaultCostController.text.isEmpty) {
                                        return 'رجاءً ادخل قيمة الكلفة الافتراضية ';
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
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsetsDirectional.only(start: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'الملاحظات',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: fontColor,
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
                              child: Column(
                                children: [
                                  if(screenWidthForTreatments>=1470)
                                    Container(
                                      height: 40,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: borderColor,
                                          width: 1,
                                        ),
                                      ),
                                      margin:
                                      const EdgeInsetsDirectional.only(start: 20),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 15),
                                        child: AddTreatmentFormField(
                                            type: TextInputType.emailAddress,
                                            controller: descriptionController,
                                            label: 'ملاحظات'),
                                      ),
                                    ),
                                  if(screenWidthForTreatments<1470)
                                    Container(
                                      height: 40,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: borderColor,
                                          width: 1,
                                        ),
                                      ),
                                      margin:
                                      const EdgeInsetsDirectional.only(start: 20),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 15),
                                        child: AddTreatmentFormField(
                                            type: TextInputType.emailAddress,
                                            controller: descriptionController,
                                            label: 'ملاحظات'),
                                      ),
                                    ),
                                  FormField(
                                    validator: (value) {
                                      if (descriptionController.text.isEmpty) {
                                        return 'رجاءً ادخل ملاحظات ';
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
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 20),
                              child: Row(
                                children: [
                                  if(screenWidthForTreatments>=1470)
                                    Text(
                                      'اختيار لون',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: fontColor,
                                      ),
                                    ),
                                  Text(
                                    ' اللون',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: fontColor,
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
                              child: Column(
                                children: [
                                  if(screenWidthForTreatments>=1470)
                                    Container(
                                      height: 40,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                        Border.all(color: Colors.grey, width: 1),
                                      ),
                                      margin:
                                      const EdgeInsetsDirectional.only(start: 20),
                                      child: InkWell(
                                        onTap: () => pickColor(context),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'اختر لون',
                                            style: TextStyle(color: selectedColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if(screenWidthForTreatments<1470)
                                    Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                        Border.all(color: Colors.grey, width: 1),
                                      ),
                                      margin:
                                      const EdgeInsetsDirectional.only(start: 20),
                                      child: InkWell(
                                        onTap: () => pickColor(context),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            ' اللون',
                                            style: TextStyle(color: selectedColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Spacer(),
                            if(screenWidthForTreatments>=1470)
                              InkWell(
                                onTap: () async {
                                  if (formKey.currentState?.validate() ?? false) {
                                    if (colorController.text.isEmpty) {
                                      EasyLoading.showError('يرجى اختيار لون');
                                      return;
                                    }
                                    EasyLoading.show(status: 'يرجى الانتظار...');
                                    try {
                                      await DrAidCubit.get(context).createTreatment(
                                        title: titleController.text,
                                        category: categoryController.text,
                                        description: descriptionController.text,
                                        defaultCost:
                                        int.parse(defaultCostController.text),
                                        color: colorController.text,
                                      );
                                      await DrAidCubit.get(context)
                                          .getAllTreatments();
                                      Navigator.pop(context);
                                    } catch (error) {
                                      EasyLoading.showError(
                                          'حدث خطأ، يرجى المحاولة لاحقاً');
                                    } finally {
                                      EasyLoading.dismiss();
                                    }
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
                            if(screenWidthForTreatments<1470)
                              InkWell(
                                onTap: () async {
                                  if (formKey.currentState?.validate() ?? false) {
                                    if (colorController.text.isEmpty) {
                                      EasyLoading.showError('يرجى اختيار لون');
                                      return;
                                    }
                                    EasyLoading.show(status: 'يرجى الانتظار...');
                                    try {
                                      await DrAidCubit.get(context).createTreatment(
                                        title: titleController.text,
                                        category: categoryController.text,
                                        description: descriptionController.text,
                                        defaultCost:
                                        int.parse(defaultCostController.text),
                                        color: colorController.text,
                                      );
                                      await DrAidCubit.get(context)
                                          .getAllTreatments();
                                      Navigator.pop(context);
                                    } catch (error) {
                                      EasyLoading.showError(
                                          'حدث خطأ، يرجى المحاولة لاحقاً');
                                    } finally {
                                      EasyLoading.dismiss();
                                    }
                                  }
                                },

                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 45,
                                    width: 100,
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
                  padding: EdgeInsetsDirectional.only(start: 150),
                  child: Text(
                    'Add treatment',
                    style: TextStyle(
                      fontSize: 18,
                      color: simpleDialogTitleColor,
                    ),
                  ),
                ),
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 600,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.only(start: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Treatment name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: fontColor,
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
                            child: Column(
                              children: [
                                if(screenWidthForTreatments>=1470)
                                  Container(
                                    height: 40,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1,
                                      ),
                                    ),
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: AddTreatmentFormField(
                                          type: TextInputType.emailAddress,
                                          controller: titleController,
                                          label: 'Treatment name'),
                                    ),
                                  ),
                                if(screenWidthForTreatments<1470)
                                  Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1,
                                      ),
                                    ),
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: AddTreatmentFormField(
                                          type: TextInputType.emailAddress,
                                          controller: titleController,
                                          label: 'Name '),
                                    ),
                                  ),
                                FormField(
                                  validator: (value) {
                                    if (titleController.text.isEmpty) {
                                      return 'Please enter treatment name';
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
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.only(start: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Specialization',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: fontColor,
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
                            child: Column(
                              children: [
                                if(screenWidthForTreatments>=1470)
                                  Container(
                                    height: 40,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1,
                                      ),
                                    ),
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: AddTreatmentFormField(
                                          type: TextInputType.emailAddress,
                                          controller: categoryController,
                                          label: 'Specialization'),
                                    ),
                                  ),
                                if(screenWidthForTreatments<1470)
                                  Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1,
                                      ),
                                    ),
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: AddTreatmentFormField(
                                          type: TextInputType.emailAddress,
                                          controller: categoryController,
                                          label: 'Specialization'),
                                    ),
                                  ),
                                FormField(
                                  validator: (value) {
                                    if (categoryController.text.isEmpty) {
                                      return 'Please enter Specialization ';
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
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 20),
                            child: Row(
                              children: [
                                if(screenWidthForTreatments>=1470)
                                  Text(
                                    'Cost',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: fontColor,
                                    ),
                                  ),
                                if(screenWidthForTreatments<1470)
                                  Text(
                                    'Cost',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: fontColor,
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
                            child: Column(
                              children: [
                                if(screenWidthForTreatments>=1470)
                                  Container(
                                    height: 40,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1,
                                      ),
                                    ),
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: AddTreatmentFormField(
                                          type: TextInputType.emailAddress,
                                          controller: defaultCostController,
                                          label: 'Cost'),
                                    ),
                                  ),
                                if(screenWidthForTreatments<1470)
                                  Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1,
                                      ),
                                    ),
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: AddTreatmentFormField(
                                          type: TextInputType.emailAddress,
                                          controller: defaultCostController,
                                          label: 'Cost'),
                                    ),
                                  ),
                                FormField(
                                  validator: (value) {
                                    if (defaultCostController.text.isEmpty) {
                                      return 'Please enter cost ';
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
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.only(start: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Comments',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: fontColor,
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
                            child: Column(
                              children: [
                                if(screenWidthForTreatments>=1470)
                                  Container(
                                    height: 40,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1,
                                      ),
                                    ),
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: AddTreatmentFormField(
                                          type: TextInputType.emailAddress,
                                          controller: descriptionController,
                                          label: 'Comments'),
                                    ),
                                  ),
                                if(screenWidthForTreatments<1470)
                                  Container(
                                    height: 40,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1,
                                      ),
                                    ),
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 15),
                                      child: AddTreatmentFormField(
                                          type: TextInputType.emailAddress,
                                          controller: descriptionController,
                                          label: 'Comments'),
                                    ),
                                  ),
                                FormField(
                                  validator: (value) {
                                    if (descriptionController.text.isEmpty) {
                                      return 'Please enter comments';
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
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 20),
                            child: Row(
                              children: [
                                if(screenWidthForTreatments>=1470)
                                  Text(
                                    'Choose color',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: fontColor,
                                    ),
                                  ),
                                Text(
                                  ' Color',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: fontColor,
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
                            child: Column(
                              children: [
                                if(screenWidthForTreatments>=1470)
                                  Container(
                                    height: 40,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                      Border.all(color: Colors.grey, width: 1),
                                    ),
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: InkWell(
                                      onTap: () => pickColor(context),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Choose color',
                                          style: TextStyle(color: selectedColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                if(screenWidthForTreatments<1470)
                                  Container(
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                      Border.all(color: Colors.grey, width: 1),
                                    ),
                                    margin:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    child: InkWell(
                                      onTap: () => pickColor(context),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          ' Color',
                                          style: TextStyle(color: selectedColor),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Spacer(),
                          if(screenWidthForTreatments>=1470)
                            InkWell(
                              onTap: () async {
                                if (formKey.currentState?.validate() ?? false) {
                                  if (colorController.text.isEmpty) {
                                    EasyLoading.showError('Please choose color');
                                    return;
                                  }
                                  EasyLoading.show(status: 'Please wait ....');
                                  try {
                                    await DrAidCubit.get(context).createTreatment(
                                      title: titleController.text,
                                      category: categoryController.text,
                                      description: descriptionController.text,
                                      defaultCost:
                                      int.parse(defaultCostController.text),
                                      color: colorController.text,
                                    );
                                    await DrAidCubit.get(context)
                                        .getAllTreatments();
                                    Navigator.pop(context);
                                  } catch (error) {
                                    EasyLoading.showError(
                                        'Something went wrong try againً');
                                  } finally {
                                    EasyLoading.dismiss();
                                  }
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
                          if(screenWidthForTreatments<1470)
                            InkWell(
                              onTap: () async {
                                if (formKey.currentState?.validate() ?? false) {
                                  if (colorController.text.isEmpty) {
                                    EasyLoading.showError('Please enter color');
                                    return;
                                  }
                                  EasyLoading.show(status: 'Please wait ....');
                                  try {
                                    await DrAidCubit.get(context).createTreatment(
                                      title: titleController.text,
                                      category: categoryController.text,
                                      description: descriptionController.text,
                                      defaultCost:
                                      int.parse(defaultCostController.text),
                                      color: colorController.text,
                                    );
                                    await DrAidCubit.get(context)
                                        .getAllTreatments();
                                    Navigator.pop(context);
                                  } catch (error) {
                                    EasyLoading.showError(
                                        'Something went wrong try againً');
                                  } finally {
                                    EasyLoading.dismiss();
                                  }
                                }
                              },

                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 45,
                                  width: 100,
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

        });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    screenWidthForTreatments=screenWidth;
    print(screenWidth);
    return BlocConsumer<DrAidCubit, DrAidStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Builder(
          builder: (context) {
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
                                        if(screenWidth>=1400)
                                          Padding(
                                            padding: const EdgeInsetsDirectional.only(
                                                start: 20, end: 130),
                                            child: Row(
                                              children: [
                                                if(screenWidth>=1300)
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
                                                            child:Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                          );
                                                        }

                                                      }
                                                  ),
                                                if(screenWidth>=1300)
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                if(modee=='light')
                                                  const Text(
                                                    'العلاجات',
                                                    style:
                                                    TextStyle(fontSize: 28, color: blueText),
                                                  ),
                                                if(modee=='dark')
                                                  const Text(
                                                    'العلاجات',
                                                    style:
                                                    TextStyle(fontSize: 28, color: Colors.orange),
                                                  ),
                                                const Spacer(),
                                                if(screenWidth>=1300&&modee=='light')
                                                  Container(
                                                    width: 250,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: blueText,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        addNewTreatment(context);
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
                                                            'إضافة علاج جديد',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth>=1300&&modee=='dark')
                                                  Container(
                                                    width: 250,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orangeAccent,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        addNewTreatment(context);
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
                                                            'إضافة علاج جديد',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth<1300&&modee=='light')
                                                  Container(
                                                    width: 120,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: blueText,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        addNewTreatment(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [

                                                          Text(
                                                            'إضافة علاج',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth<1300&&modee=='dark')
                                                  Container(
                                                    width: 120,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orangeAccent,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        addNewTreatment(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [

                                                          Text(
                                                            'إضافة علاج',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        if(screenWidth<1400)
                                          Padding(
                                            padding: const EdgeInsetsDirectional.only(
                                                start: 20, end: 130),
                                            child: Row(
                                              children: [
                                                if(screenWidth>=1300)
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
                                                            child:Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                          );
                                                        }

                                                      }
                                                  ),
                                                if(screenWidth>=1300)
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                if(modee=='light')
                                                  const Text(
                                                    'العلاجات',
                                                    style:
                                                    TextStyle(fontSize: 28, color: blueText),
                                                  ),
                                                if(modee=='dark')
                                                  const Text(
                                                    'العلاجات',
                                                    style:
                                                    TextStyle(fontSize: 28, color: Colors.orange),
                                                  ),
                                                const Spacer(),
                                                if(screenWidth>=1300&&modee=='light')
                                                  Container(
                                                    width: 250,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: blueText,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        addNewTreatment(context);
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
                                                            'إضافة علاج جديد',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth>=1300&&modee=='dark')
                                                  Container(
                                                    width: 250,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orangeAccent,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        addNewTreatment(context);
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
                                                            'إضافة علاج جديد',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth<1300&&modee=='light')
                                                  Container(
                                                    width: 120,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: blueText,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        addNewTreatment(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [

                                                          Text(
                                                            'إضافة علاج',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                if(screenWidth<1300&&modee=='dark')
                                                  Container(
                                                    width: 120,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orangeAccent,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        addNewTreatment(context);
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsetsDirectional.only(start: 30),
                                                        child: Row(children: [

                                                          Text(
                                                            'إضافة علاج',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(end: 175.0),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.70,
                                            height: 450,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(30)),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 18,
                                                ),
                                                if(screenWidth>=1480)
                                                  const Padding(
                                                    padding:
                                                    EdgeInsetsDirectional.only(start: 30),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 15),
                                                        Text(
                                                          'اسم العلاج',
                                                          style: TextStyle(
                                                              fontSize: 18, color: fontColor),
                                                        ),
                                                        SizedBox(width: 70),
                                                        Text(
                                                          'الاختصاص',
                                                          style: TextStyle(
                                                              fontSize: 18, color: fontColor),
                                                        ),
                                                        SizedBox(width: 70),
                                                        Text(
                                                          'الكلفة الافتراضية',
                                                          style: TextStyle(
                                                              fontSize: 18, color: fontColor),
                                                        ),
                                                        SizedBox(width: 120),
                                                        Text(
                                                          'ملاحظات',
                                                          style: TextStyle(
                                                              fontSize: 18, color: fontColor),
                                                        ),
                                                        SizedBox(width: 150),
                                                        Text(
                                                          'لون العلاج',
                                                          style: TextStyle(
                                                              fontSize: 18, color: fontColor),
                                                        ),
                                                        SizedBox(width: 57),
                                                        Text(
                                                          '',
                                                          style: TextStyle(
                                                              fontSize: 18, color: fontColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                if(screenWidth>=1460)
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
                                                    if (state
                                                    is DrAidGetAllTreatmentsSuccessState) {
                                                      return Expanded(
                                                        child: ListView.separated(
                                                            itemBuilder: (context, index) {
                                                              final treatment =
                                                                  DrAidCubit.get(context)
                                                                      .getAllTreamentsModel;
                                                              final treatmentItem =
                                                              treatment!.data[index];
                                                              final Color avatarColor =
                                                              treatmentItem.color !=
                                                                  null &&
                                                                  treatmentItem.color!
                                                                      .isNotEmpty
                                                                  ? hexToColor(
                                                                  treatmentItem
                                                                      .color!)
                                                                  : Colors.grey;

                                                              if (treatment.data.isNotEmpty) {
                                                                return Padding(
                                                                  padding:
                                                                  const EdgeInsetsDirectional
                                                                      .only(start: 30),
                                                                  child: Row(
                                                                    children: [
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 15),
                                                                      Expanded(
                                                                        child: Text(
                                                                          treatment
                                                                              .data[index]
                                                                              .title,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 70),
                                                                      if(screenWidth<1350)
                                                                        const SizedBox(
                                                                            width: 10),
                                                                      if(screenWidth>=1350)
                                                                        Expanded(
                                                                          child: Text(
                                                                            treatment
                                                                                .data[index]
                                                                                .category,
                                                                            style: const TextStyle(
                                                                                fontSize: 16,
                                                                                color:
                                                                                fontColor),
                                                                          ),
                                                                        ),
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 70),
                                                                      Expanded(
                                                                        child: Text(
                                                                          treatment
                                                                              .data[index]
                                                                              .defaultCost
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 120),
                                                                      if(screenWidth>=1350)
                                                                        Expanded(
                                                                          child: Text(
                                                                            treatment
                                                                                .data[index]
                                                                                .description ??
                                                                                '',
                                                                            style: const TextStyle(
                                                                                fontSize: 16,
                                                                                color:
                                                                                fontColor),
                                                                          ),
                                                                        ),
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 123),
                                                                      if(screenWidth>=650)
                                                                        CircleAvatar(
                                                                          backgroundColor:
                                                                          avatarColor,
                                                                          radius: 15,
                                                                        ),
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 57),
                                                                      if(screenWidth>=1350)
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
                                                              } else {
                                                                return const Center(
                                                                  child: Text(
                                                                      'No treatments available',
                                                                      style: TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor)),
                                                                );
                                                              }
                                                            },
                                                            separatorBuilder:
                                                                (context, index) {
                                                              return const SizedBox(
                                                                height: 10,
                                                              );
                                                            },
                                                            itemCount: DrAidCubit.get(context)
                                                                .getAllTreamentsModel!
                                                                .data
                                                                .length),
                                                      );
                                                    }
                                                    else if(DrAidCubit.get(context).getAllTreamentsModel?.data.length!=0)
                                                    {
                                                      return Expanded(
                                                        child: ListView.separated(
                                                            itemBuilder: (context, index) {
                                                              final treatment =
                                                                  DrAidCubit.get(context)
                                                                      .getAllTreamentsModel;
                                                              final treatmentItem =
                                                              treatment!.data[index];
                                                              final Color avatarColor =
                                                              treatmentItem.color !=
                                                                  null &&
                                                                  treatmentItem.color!
                                                                      .isNotEmpty
                                                                  ? hexToColor(
                                                                  treatmentItem
                                                                      .color!)
                                                                  : Colors.grey;

                                                              if (treatment.data.isNotEmpty) {
                                                                return Padding(
                                                                  padding:
                                                                  const EdgeInsetsDirectional
                                                                      .only(start: 30),
                                                                  child: Row(
                                                                    children: [
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 15),
                                                                      Expanded(
                                                                        child: Text(
                                                                          treatment
                                                                              .data[index]
                                                                              .title,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 70),
                                                                      if(screenWidth<1350)
                                                                        const SizedBox(
                                                                            width: 10),
                                                                      if(screenWidth>=1350)
                                                                        Expanded(
                                                                          child: Text(
                                                                            treatment
                                                                                .data[index]
                                                                                .category,
                                                                            style: const TextStyle(
                                                                                fontSize: 16,
                                                                                color:
                                                                                fontColor),
                                                                          ),
                                                                        ),
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 70),
                                                                      Expanded(
                                                                        child: Text(
                                                                          treatment
                                                                              .data[index]
                                                                              .defaultCost
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 120),
                                                                      if(screenWidth>=1350)
                                                                        Expanded(
                                                                          child: Text(
                                                                            treatment
                                                                                .data[index]
                                                                                .description ??
                                                                                '',
                                                                            style: const TextStyle(
                                                                                fontSize: 16,
                                                                                color:
                                                                                fontColor),
                                                                          ),
                                                                        ),
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 123),
                                                                      if(screenWidth>=650)
                                                                        CircleAvatar(
                                                                          backgroundColor:
                                                                          avatarColor,
                                                                          radius: 15,
                                                                        ),
                                                                      if(screenWidth>=1350)
                                                                        const SizedBox(
                                                                            width: 57),
                                                                      if(screenWidth>=1350)
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
                                                              } else {
                                                                return const Center(
                                                                  child: Text(
                                                                      'No treatments available',
                                                                      style: TextStyle(
                                                                          fontSize: 16,
                                                                          color: fontColor)),
                                                                );
                                                              }
                                                            },
                                                            separatorBuilder:
                                                                (context, index) {
                                                              return const SizedBox(
                                                                height: 10,
                                                              );
                                                            },
                                                            itemCount: DrAidCubit.get(context)
                                                                .getAllTreamentsModel!
                                                                .data
                                                                .length),
                                                      );
                                                    }

                                                    else if (DrAidCubit.get(context)
                                                        .getAllTreamentsModel!
                                                        .data
                                                        .isEmpty) {
                                                      return const Column(
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                              'لا يوجد علاجات بعد',
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
                                                    is DrAidGetAllTreatmentsLoadingState) {
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
                                      if(screenWidth>=1400)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 20, end: 130),
                                          child: Row(
                                            children: [
                                              if(screenWidth>=1300)
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
                                                          child:Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                          },
                                                        );
                                                      }

                                                    }
                                                ),
                                              if(screenWidth>=1300)
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                              if(modee=='light')
                                                const Text(
                                                  'Treatments',
                                                  style:
                                                  TextStyle(fontSize: 28, color: blueText),
                                                ),
                                              if(modee=='dark')
                                                const Text(
                                                  'Treatments',
                                                  style:
                                                  TextStyle(fontSize: 28, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300&&modee=='light')
                                                Container(
                                                  width: 250,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addNewTreatment(context);
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
                                                          'Add treatment',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                Container(
                                                  width: 250,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.orangeAccent,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addNewTreatment(context);
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
                                                          'Add treatment',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                Container(
                                                  width: 120,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addNewTreatment(context);
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
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                Container(
                                                  width: 120,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.orangeAccent,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addNewTreatment(context);
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
                                                ),
                                            ],
                                          ),
                                        ),
                                      if(screenWidth<1400)
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(
                                              start: 20, end: 130),
                                          child: Row(
                                            children: [
                                              if(screenWidth>=1300)
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
                                                          child:Icon(Icons.arrow_back,size: 30,color: Colors.orange,),
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                          },
                                                        );
                                                      }

                                                    }
                                                ),
                                              if(screenWidth>=1300)
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                              if(modee=='light')
                                                const Text(
                                                  'Treatments',
                                                  style:
                                                  TextStyle(fontSize: 28, color: blueText),
                                                ),
                                              if(modee=='dark')
                                                const Text(
                                                  'Treatments',
                                                  style:
                                                  TextStyle(fontSize: 28, color: Colors.orange),
                                                ),
                                              const Spacer(),
                                              if(screenWidth>=1300&&modee=='light')
                                                Container(
                                                  width: 250,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addNewTreatment(context);
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
                                                          'Add',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth>=1300&&modee=='dark')
                                                Container(
                                                  width: 250,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.orangeAccent,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addNewTreatment(context);
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
                                                          'Add',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                              if(screenWidth<1300&&modee=='light')
                                                Container(
                                                  width: 120,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: blueText,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addNewTreatment(context);
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
                                                ),
                                              if(screenWidth<1300&&modee=='dark')
                                                Container(
                                                  width: 120,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.orangeAccent,
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addNewTreatment(context);
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
                                                ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsetsDirectional.only(end: 175.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.70,
                                          height: 450,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(30)),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 18,
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ),
                                              if(screenWidth>=1460)
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
                                                  if (state
                                                  is DrAidGetAllTreatmentsSuccessState) {
                                                    return Expanded(
                                                      child: ListView.separated(
                                                          itemBuilder: (context, index) {
                                                            final treatment =
                                                                DrAidCubit.get(context)
                                                                    .getAllTreamentsModel;
                                                            final treatmentItem =
                                                            treatment!.data[index];
                                                            final Color avatarColor =
                                                            treatmentItem.color !=
                                                                null &&
                                                                treatmentItem.color!
                                                                    .isNotEmpty
                                                                ? hexToColor(
                                                                treatmentItem
                                                                    .color!)
                                                                : Colors.grey;

                                                            if (treatment.data.isNotEmpty) {
                                                              return Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .only(start: 30),
                                                                child: Row(
                                                                  children: [
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 15),
                                                                    Expanded(
                                                                      child: Text(
                                                                        treatment
                                                                            .data[index]
                                                                            .title,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 70),
                                                                    if(screenWidth<1350)
                                                                      const SizedBox(
                                                                          width: 10),
                                                                    if(screenWidth>=1350)
                                                                      Expanded(
                                                                        child: Text(
                                                                          treatment
                                                                              .data[index]
                                                                              .category,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 70),
                                                                    Expanded(
                                                                      child: Text(
                                                                        treatment
                                                                            .data[index]
                                                                            .defaultCost
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 120),
                                                                    if(screenWidth>=1350)
                                                                      Expanded(
                                                                        child: Text(
                                                                          treatment
                                                                              .data[index]
                                                                              .description ??
                                                                              '',
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 123),
                                                                    if(screenWidth>=650)
                                                                      CircleAvatar(
                                                                        backgroundColor:
                                                                        avatarColor,
                                                                        radius: 15,
                                                                      ),
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 57),
                                                                    if(screenWidth>=1350)
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
                                                            } else {
                                                              return const Center(
                                                                child: Text(
                                                                    'No treatments available',
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        color: fontColor)),
                                                              );
                                                            }
                                                          },
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                              height: 10,
                                                            );
                                                          },
                                                          itemCount: DrAidCubit.get(context)
                                                              .getAllTreamentsModel!
                                                              .data
                                                              .length),
                                                    );
                                                  }
                                                  else if(DrAidCubit.get(context).getAllTreamentsModel?.data.length!=0)
                                                  {
                                                    return Expanded(
                                                      child: ListView.separated(
                                                          itemBuilder: (context, index) {
                                                            final treatment =
                                                                DrAidCubit.get(context)
                                                                    .getAllTreamentsModel;
                                                            final treatmentItem =
                                                            treatment!.data[index];
                                                            final Color avatarColor =
                                                            treatmentItem.color !=
                                                                null &&
                                                                treatmentItem.color!
                                                                    .isNotEmpty
                                                                ? hexToColor(
                                                                treatmentItem
                                                                    .color!)
                                                                : Colors.grey;

                                                            if (treatment.data.isNotEmpty) {
                                                              return Padding(
                                                                padding:
                                                                const EdgeInsetsDirectional
                                                                    .only(start: 30),
                                                                child: Row(
                                                                  children: [
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 15),
                                                                    Expanded(
                                                                      child: Text(
                                                                        treatment
                                                                            .data[index]
                                                                            .title,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 70),
                                                                    if(screenWidth<1350)
                                                                      const SizedBox(
                                                                          width: 10),
                                                                    if(screenWidth>=1350)
                                                                      Expanded(
                                                                        child: Text(
                                                                          treatment
                                                                              .data[index]
                                                                              .category,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 70),
                                                                    Expanded(
                                                                      child: Text(
                                                                        treatment
                                                                            .data[index]
                                                                            .defaultCost
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            color:
                                                                            fontColor),
                                                                      ),
                                                                    ),
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 120),
                                                                    if(screenWidth>=1350)
                                                                      Expanded(
                                                                        child: Text(
                                                                          treatment
                                                                              .data[index]
                                                                              .description ??
                                                                              '',
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              color:
                                                                              fontColor),
                                                                        ),
                                                                      ),
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 123),
                                                                    if(screenWidth>=650)
                                                                      CircleAvatar(
                                                                        backgroundColor:
                                                                        avatarColor,
                                                                        radius: 15,
                                                                      ),
                                                                    if(screenWidth>=1350)
                                                                      const SizedBox(
                                                                          width: 57),
                                                                    if(screenWidth>=1350)
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
                                                            } else {
                                                              return const Center(
                                                                child: Text(
                                                                    'No treatments available',
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        color: fontColor)),
                                                              );
                                                            }
                                                          },
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const SizedBox(
                                                              height: 10,
                                                            );
                                                          },
                                                          itemCount: DrAidCubit.get(context)
                                                              .getAllTreamentsModel!
                                                              .data
                                                              .length),
                                                    );
                                                  }

                                                  else if (DrAidCubit.get(context)
                                                      .getAllTreamentsModel!
                                                      .data
                                                      .isEmpty) {
                                                    return const Column(
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            'No treatments yet',
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
                                                  is DrAidGetAllTreatmentsLoadingState) {
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
          }
        );
      },
    );
  }
}
