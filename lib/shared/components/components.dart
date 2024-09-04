// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, no_logic_in_create_state

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginFormField extends StatefulWidget {
  final String hintText;
  final Color color;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validate;

  const LoginFormField({
    super.key,
    required this.hintText,
    required this.color,
    required this.controller,
    this.isPassword = false,
    this.validate,
  });

  @override
  _LoginFormFieldState createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            fillColor: widget.color,
            filled: true,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
          validator: widget.validate,
        ),
      ],
    );
  }
}

class LoginButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButtonWidget({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.buttonColor,
            minimumSize: const Size(300, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            )),
        onPressed: onPressed,
        child: const Text(
          'تسجيل الدخول',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ItemBasicInformation extends StatelessWidget {
  final String text;
  const ItemBasicInformation({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorManager.borderGreyColor, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, color: fontColor),
        ),
      ),
    );
  }
}
class ItemBasicInformationResponsive extends StatelessWidget {
  final String text;
  const ItemBasicInformationResponsive({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorManager.borderGreyColor, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, color: fontColor),
        ),
      ),
    );
  }
}

class ItemCompletedTreatment extends StatelessWidget {
  final String text;
  const ItemCompletedTreatment({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorManager.borderGreyColor, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, color: fontColor),
        ),
      ),
    );
  }
}

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final IconData prefix;
  final ValueChanged<String>? onChange;
  final String? Function(String?)? validate;

  final void Function(String)? onSubmit;
  final bool isPassword;
  final IconData? suffix;
  final VoidCallback? sufficfunction;
  final VoidCallback? ontap;
  final bool isClickable;
  final Color? color;

  const DefaultFormField(
      {super.key,
      required this.prefix,
      required this.type,
      required this.controller,
      required this.validate,
      this.onChange,
      required this.label,
      this.onSubmit,
      this.isPassword = false,
      this.suffix,
      this.sufficfunction,
      this.ontap,
      this.isClickable = true,
      this.color,
      required Color fillColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      onTap: ontap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: sufficfunction, icon: Icon(suffix))
            : null,
        fillColor: color,
      ),
    );
  }
}

class ClinicFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;

  final ValueChanged<String>? onChange;

  final String? Function(String?)? validate;

  final void Function(String)? onSubmit;
  final bool isPassword;
  final IconData? suffix;
  final IconData? prefix;
  final VoidCallback? sufficfunction;
  final VoidCallback? ontap;
  final bool isClickable;
  final bool isreadOnly;
  final String? imagePath;

  const ClinicFormField({
    super.key,
    required this.type,
    required this.controller,
    required this.validate,
    this.onChange,
    required this.label,
    this.onSubmit,
    this.isPassword = false,
    this.suffix,
    this.sufficfunction,
    this.ontap,
    this.isClickable = true,
    this.isreadOnly = false,
    this.prefix,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      onTap: ontap,
      validator: validate,
      decoration: InputDecoration(
        prefixIcon: imagePath != null
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  '$imagePath',
                  semanticsLabel: 'My SVG Image',
                  height: 20,
                  width: 20,
                  color: fontColor2,
                ),
              )
            : null,
        // prefix != null
        //     ? IconButton(onPressed: sufficfunction, icon: Icon(prefix))
        //     : null,

        hintText: label,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: textFieldBorderColor)),
        suffixIcon: suffix != null
            ? IconButton(onPressed: sufficfunction, icon: Icon(suffix))
            : null,
      ),
    );
  }
}

class AddTreatmentFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;

  final ValueChanged<String>? onChange;

  final String? Function(String?)? validate;

  final void Function(String)? onSubmit;
  final bool isPassword;
  final IconData? suffix;
  final IconData? prefix;
  final VoidCallback? sufficfunction;
  final VoidCallback? ontap;
  final bool isClickable;
  final bool isreadOnly;
  final String? imagePath;

  const AddTreatmentFormField({
    super.key,
    required this.type,
    required this.controller,
    this.validate,
    this.onChange,
    required this.label,
    this.onSubmit,
    this.isPassword = false,
    this.suffix,
    this.sufficfunction,
    this.ontap,
    this.isClickable = true,
    this.isreadOnly = false,
    this.prefix,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      onTap: ontap,
      validator: validate,
      decoration: InputDecoration(
        prefixIcon: imagePath != null
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  '$imagePath',
                  semanticsLabel: 'My SVG Image',
                  height: 20,
                  width: 20,
                  color: fontColor2,
                ),
              )
            : null,
        // prefix != null
        //     ? IconButton(onPressed: sufficfunction, icon: Icon(prefix))
        //     : null,

        hintText: label,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        suffixIcon: suffix != null
            ? IconButton(onPressed: sufficfunction, icon: Icon(suffix))
            : null,
      ),
    );
  }
}

class ClinicFormFieldDialog extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;

  final ValueChanged<String>? onChange;

  final String? Function(String?)? validate;

  final void Function(String)? onSubmit;
  final bool isPassword;
  final IconData? suffix;
  final IconData? prefix;
  final VoidCallback? sufficfunction;
  final VoidCallback? ontap;
  final bool isClickable;
  final bool isreadOnly;
  final String? imagePath;

  const ClinicFormFieldDialog({
    super.key,
    required this.type,
    required this.controller,
    required this.validate,
    this.onChange,
    required this.label,
    this.onSubmit,
    this.isPassword = false,
    this.suffix,
    this.sufficfunction,
    this.ontap,
    this.isClickable = true,
    this.isreadOnly = false,
    this.prefix,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      onTap: ontap,
      validator: validate,
      decoration: InputDecoration(
        prefixIcon: imagePath != null
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  '$imagePath',
                  semanticsLabel: 'My SVG Image',
                  height: 20,
                  width: 20,
                  color: fontColor2,
                ),
              )
            : null,
        // prefix != null
        //     ? IconButton(onPressed: sufficfunction, icon: Icon(prefix))
        //     : null,

        hintText: label,
        helperStyle: const TextStyle(
          fontSize: 16,
          color: fontColor2,
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: textFieldBorderColor)),
        suffixIcon: suffix != null
            ? IconButton(onPressed: sufficfunction, icon: Icon(suffix))
            : null,
      ),
    );
  }
}

class AddAttachmentField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;

  final ValueChanged<String>? onChange;

  final String? Function(String?)? validate;

  final void Function(String)? onSubmit;
  final bool isPassword;
  final IconData? suffix;
  final IconData? prefix;
  final VoidCallback? sufficfunction;
  final VoidCallback? ontap;
  final bool isClickable;
  final bool isreadOnly;
  final String? imagePath;
  final String? suffixImagePath;

  const AddAttachmentField({
    super.key,
    required this.type,
    required this.controller,
    this.validate,
    this.onChange,
    required this.label,
    this.onSubmit,
    this.isPassword = false,
    this.suffix,
    this.sufficfunction,
    this.ontap,
    this.isClickable = true,
    this.isreadOnly = false,
    this.prefix,
    this.imagePath,
    this.suffixImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      onTap: ontap,
      validator: validate,
      decoration: InputDecoration(
        prefixIcon: imagePath != null
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  '$imagePath',
                  semanticsLabel: 'My SVG Image',
                  height: 20,
                  width: 20,
                  color: fontColor2,
                ),
              )
            : null,
        // prefix != null
        //     ? IconButton(onPressed: sufficfunction, icon: Icon(prefix))
        //     : null,

        hintText: label,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        suffixIcon: suffixImagePath != null
            ? InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  '$suffixImagePath',
                  semanticsLabel: 'My SVG Image',
                  height: 50,
                  width: 50,
                  // color: fontColor2,
                ),
              )
            : null,
      ),
    );
  }
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

class MyTimePicker extends StatefulWidget {
  final String title;
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeChanged;

  const MyTimePicker({
    super.key,
    required this.title,
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  _MyTimePickerState createState() => _MyTimePickerState(initialTime);
}

class _MyTimePickerState extends State<MyTimePicker> {
  late TimeOfDay _selectedTime;
  _MyTimePickerState(this._selectedTime);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      widget.onTimeChanged(picked); // Call the callback function
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () => _selectTime(context),
          child: Row(
            children: [
              const Icon(
                Icons.access_time,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // You can uncomment the following line if you want to display the selected time
        // Text('Selected Time: ${_selectedTime.format(context)}'),
      ],
    );
  }
}

class MyDatePicker extends StatefulWidget {
  final String title;
  final DateTime initialDate;
  final Function(DateTime) onDateChanged;

  const MyDatePicker({
    super.key,
    required this.title,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  _MyDatePickerState createState() => _MyDatePickerState(initialDate);
}

class _MyDatePickerState extends State<MyDatePicker> {
  late DateTime _selectedDate;
  _MyDatePickerState(this._selectedDate);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateChanged(picked); // Call the callback function
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(datePickerColor),
          ),
          onPressed: () => _selectDate(context),
          child: Row(
            children: [
              const Icon(
                Icons.date_range_outlined,
                color: blueText,
              ),
              const SizedBox(width: 20),
              Text(
                widget.title,
                style: const TextStyle(color: blueText),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Text('Selected Date: ${_selectedDate.toIso8601String()}'),
      ],
    );
  }
}

class DatePicker extends StatefulWidget {
  final String title;
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const DatePicker(
      {super.key,
      required this.title,
      required this.initialDate,
      required this.onDateSelected});

  @override
  _DatePickerState createState() => _DatePickerState(initialDate);
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _selectedDate;
  _DatePickerState(this._selectedDate);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateSelected(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(datePickerColor),
          ),
          onPressed: () => _selectDate(context),
          child: Row(
            children: [
              const Icon(
                Icons.date_range_outlined,
                color: blueText,
              ),
              const SizedBox(width: 20),
              Text(
                widget.title,
                style: const TextStyle(color: blueText),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Text('Selected Date: ${_selectedDate.toIso8601String()}'),
      ],
    );
  }
}

class CustomSearchField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CustomSearchField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: blueText,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: blueText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: datePickerColor,
        contentPadding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
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
void addEmployee(BuildContext context, ) {
  showDialog(

      context: context,
      builder: (BuildContext context) {

        return Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleDialog(
            title: const Padding(
              padding: EdgeInsetsDirectional.only(start: 30),
              child: Text(
                'Add Employee',
                style: TextStyle(
                  fontSize: 18,
                  color: simpleDialogTitleColor,
                ),
              ),
            ),
            children: <Widget>[

              Builder(
                  builder: (context) {

                    {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 350,

                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 30),
                              child:Column(
                                children: [
                                  TextButton(
                                    onPressed: (){
                                      //ChangeMode(context);
                                      addSecretary(context);
                                      //  DrAidCubit.get(context).changeDarkOrLightMode('light');

                                    },
                                    child: Text('Secretary',style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                    ),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  TextButton(
                                    onPressed: (){
                                      addAssistant(context);
                                     // ChangeLanguage(context);
                                      // DrAidCubit.get(context).changeDarkOrLightMode('dark');
                                    },
                                    child: Text('Assistant',style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                    ),
                                    ),
                                  ),

                                ],
                              ) ,
                            )
                          ],
                        ),

                      );
                    }

                  }
              ),
            ],
          ),
        );
      });
}
void changeSettings(BuildContext context, ) {
  showDialog(

      context: context,
      builder: (BuildContext context) {

        return Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleDialog(
            title: const Padding(
              padding: EdgeInsetsDirectional.only(start: 30),
              child: Text(
                'Change Settings',
                style: TextStyle(
                  fontSize: 18,
                  color: simpleDialogTitleColor,
                ),
              ),
            ),
            children: <Widget>[

              Builder(
                  builder: (context) {

                    {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 350,

                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 30),
                              child:Column(
                                children: [
                                  TextButton(
                                    onPressed: (){
                                      ChangeMode(context);
                                    //  DrAidCubit.get(context).changeDarkOrLightMode('light');

                                    },
                                    child: Text('Mode',style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                    ),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  TextButton(
                                    onPressed: (){
                                      ChangeLanguage(context);
                                     // DrAidCubit.get(context).changeDarkOrLightMode('dark');
                                    },
                                    child: Text('Language',style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                    ),
                                    ),
                                  ),

                                ],
                              ) ,
                            )
                          ],
                        ),

                      );
                    }

                  }
              ),
            ],
          ),
        );
      });
}
void ChangeMode(BuildContext context, ) {
  showDialog(

      context: context,
      builder: (BuildContext context) {

        return Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleDialog(
            title: const Padding(
              padding: EdgeInsetsDirectional.only(start: 30),
              child: Text(
                'choose mode',
                style: TextStyle(
                  fontSize: 18,
                  color: simpleDialogTitleColor,
                ),
              ),
            ),
            children: <Widget>[

              Builder(
                  builder: (context) {

                    {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 350,

                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 30),
                             child:Column(
                                 children: [
                                   TextButton(
                                       onPressed: (){
                                        DrAidCubit.get(context).changeDarkOrLightMode('light');

                                       },
                                       child: Text('Light',style: TextStyle(
                                         color: Colors.grey,
                                         fontSize: 16
                                       ),
                                       ),
                                   ),
                                   SizedBox(height: 15,),
                                   TextButton(
                                     onPressed: (){
                                       DrAidCubit.get(context).changeDarkOrLightMode('dark');
                                     },
                                     child: Text('Dark',style: TextStyle(
                                         color: Colors.grey,
                                         fontSize: 16
                                     ),
                                     ),
                                   ),

                                 ],
                             ) ,
                            )
                          ],
                        ),

                      );
                    }

                  }
              ),
            ],
          ),
        );
      });
}
void ChangeLanguage(BuildContext context, ) {
  showDialog(

      context: context,
      builder: (BuildContext context) {

        return Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleDialog(
            title: const Padding(
              padding: EdgeInsetsDirectional.only(start: 30),
              child: Text(
                'choose Language',
                style: TextStyle(
                  fontSize: 18,
                  color: simpleDialogTitleColor,
                ),
              ),
            ),
            children: <Widget>[

              Builder(
                  builder: (context) {

                    {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 350,

                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 30),
                              child:Column(
                                children: [
                                  TextButton(
                                    onPressed: (){
                                      DrAidCubit.get(context).changeArabicOrEnglish('arabic');

                                    },
                                    child: Text('Arabic',style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                    ),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  TextButton(
                                    onPressed: (){
                                      DrAidCubit.get(context).changeArabicOrEnglish('english');
                                    },
                                    child: Text('English',style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                    ),
                                    ),
                                  ),

                                ],
                              ) ,
                            )
                          ],
                        ),

                      );
                    }

                  }
              ),
            ],
          ),
        );
      });
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          children: [
            Image.asset(
              'images/dental_logo1.png',
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Doctor Aid',
              style: TextStyle(
                color: Colors.blue.shade400,
                fontSize: 26,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            TextButton(
                onPressed: (){
                  ChangeMode(context);

                  // DrAidCubit.get(context).createClinic(
                  //     name: 'عيادة جرمانا 4',
                  //     address: 'دمشق-جرمانا',
                  //     telePhoneNumber: '0116635649',
                  //     phoneNumber: '+963957447523',
                  //     whatsappNumber: '+963957447523',
                  //     ownerName:' doctor 4',
                  //     ownerEmail: 'doctor@gmail.com',
                  //     ownerAddress: 'مزة شيخ سعد خلف جامع المزة الكبير',
                  //     ownerPhone: '0962255186');


                },
                child: Text('Mode',style:
                TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                ),
                ),

            ),
            SizedBox(width: 20,),
            TextButton(
              onPressed: (){
                ChangeLanguage(context);
              },
              child: Text('Language',style:
              TextStyle(
                  color: Colors.grey,
                  fontSize: 16
              ),
              ),

            )
          ],
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 20, top: 5),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgXMB05f5uqY5HFXRymjfYv7eevihHiipha3H8-4IQQxpAu9QQ8JCr770qcU29C9zECDs&usqp=CAU'),
            radius: 20,
          ),
        ),
      ],
      automaticallyImplyLeading:
          false, // This hides the default back button on the AppBar
    );
  }
}

class CustomAppBarPage extends StatelessWidget {
  const CustomAppBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Returning false prevents the back action
        return false;
      },
      child: const Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: Text('Content goes here'),
        ),
      ),
    );
  }
}
