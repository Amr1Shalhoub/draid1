// ignore_for_file: unused_local_variable, unused_element, deprecated_member_use, avoid_web_libraries_in_flutter, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/network/local/cache_helper.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import 'dart:js' as js;

class AttachmentsScreen extends StatefulWidget {
  const AttachmentsScreen({super.key});

  @override
  State<AttachmentsScreen> createState() => _AttachmentsScreenState();
}

class _AttachmentsScreenState extends State<AttachmentsScreen> {
  TextEditingController filename = TextEditingController();
  File? _selectedFile;
  Uint8List? _selectedFileBytes; // For web
  double screenWidthForAttachment=0;

  Future<void> _openFileUrl(String url) async {
    final Uri fileUri = Uri.file(url);
    if (await canLaunch(fileUri.toString())) {
      await launch(fileUri.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.bytes != null) {
        // If file bytes are available, create a Blob from bytes and open it
        final blob = html.Blob([file.bytes!]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        js.context.callMethod('open', [url]);
      } else if (file.path != null) {
        // If file path is available, read the file as data URL and display it
        final reader = html.FileReader();
        reader.readAsDataUrl(html.File([file.bytes!], file.name));
        reader.onLoadEnd.listen((e) {
          final url = reader.result as String?;
          if (url != null) {
            // Display the data URL in a new window or tab
            html.window.open(url, '_blank');
          } else {
            print('Failed to read file as data URL.');
          }
        });
      }
    } else {
      print("No file selected");
    }
  }

  void _openFile1() {
    // Replace with the actual URL where the file is hosted or accessible
    String filePath =
        'D:\\backend for final project\\uploads//1719402906684-ØªØ­ÙÙÙ 11';

    // Open the file in a new tab or window
    html.window.open(filePath, '_blank');
  }

  // Future<void> _openFilePicker() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'png', 'pdf'],
  //   );
  //
  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //
  //     if (file.bytes != null) {
  //       // If file bytes are available, create a Blob from bytes and open it
  //       final blob = html.Blob([file.bytes!]);
  //       final url = html.Url.createObjectUrlFromBlob(blob);
  //       js.context.callMethod('open', [url]);
  //     } else if (file.path != null) {
  //       // If file path is available, read the file as data URL and open it
  //       html.FileReader reader = html.FileReader();
  //       reader.onLoadEnd.listen((e) {
  //         final blob = html.Blob([reader.result!]);
  //         final url = html.Url.createObjectUrlFromBlob(blob);
  //         js.context.callMethod('open', [url]);
  //       });
  //       reader.readAsDataUrl(html.File([], file.name));
  //     }
  //   } else {
  //     print("No file selected");
  //   }
  // }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'pdf'],
      );

      if (result != null) {
        if (kIsWeb) {
          // For web
          _selectedFileBytes = result.files.first.bytes;
          print("Selected file bytes: ${_selectedFileBytes?.length}");
        } else {
          // For other platforms
          _selectedFile = File(result.files.single.path!);
          print("Selected file path: ${_selectedFile!.path}");
        }
      } else {
        print("File picker canceled or no file picked.");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  void _selectFile() async {
    await pickFile();
    setState(() {});
  }

  void addNewAttachment(BuildContext context) {
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
                    'إضافة مرفق جديد',
                    style: TextStyle(
                      fontSize: 18,
                      color: simpleDialogTitleColor,
                    ),
                  ),
                ),
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: 250,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        if(screenWidthForAttachment>=1500)
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
                                  margin: const EdgeInsetsDirectional.only(start: 20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddAttachmentField(
                                      type: TextInputType.emailAddress,
                                      suffixImagePath: 'images/pdf_image.svg',
                                      controller: filename,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your email address';
                                        }
                                        return null;
                                      },
                                      label: 'اسم المرفق',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if(screenWidthForAttachment<1500)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 30),
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
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
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 15),
                                    child: AddAttachmentField(
                                      type: TextInputType.emailAddress,
                                      suffixImagePath: 'images/pdf_image.svg',
                                      controller: filename,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter your email address';
                                        }
                                        return null;
                                      },
                                      label: 'اسم المرفق',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            _selectFile();
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
                                  'إضافة ملف',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            // DrAidCubit.get(context).createAppointment(
                            //     PatientId: 1
                            //     , date: '2024-5-10',
                            //     startTime: '17:30:00',
                            //     endTime: '18:00:00',
                            //     complaint: 'حشو سن'
                            // );

                            // DrAidCubit.get(context).createWaitingList(
                            //     PatientId: 1,
                            //     date: '2024-6-27'
                            // );

                            if (_selectedFile != null ||
                                _selectedFileBytes != null) {
                              if(filename.text!='')
                                DrAidCubit.get(context).createAttachments(
                                  patientId: DrAidCubit.get(context).patientId,
                                  title: filename.text,
                                  file: _selectedFile,
                                  fileBytes: _selectedFileBytes,
                                  token: CacheHelper.getData(key: 'token'),
                                  //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiJhYWFhYdij2K3ZhdivINi02YrYriDYp9mE2LTYqNin2KgiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3MTg5MTQ3ODh9.z6zwzLFfHljjEkR2fvxbZ-vAKWN0YfCRjMHMnvzmaG8'
                                );

                              // createAttachments(
                              //   patientId: 1,
                              //   title: filename.text,
                              //   file: _selectedFile,
                              //   fileBytes: _selectedFileBytes,
                              //   token: 'your_token_here', // Replace with your actual token
                              // );
                            } else {
                              print("No file selected");
                            }

                            // if (_selectedFile != null) {
                            //   print("Final selected file path: ${_selectedFile!.path}");
                            //   DrAidCubit.get(context).createAttachments(
                            //     patientId: 1,
                            //     title: filename.text,
                            //     file: _selectedFile!,
                            //     token: 'your_token_here', // Replace with your actual token
                            //   );
                            // } else {
                            //   print("No file selected");
                            // }
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
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
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
                  'Add attachment',
                  style: TextStyle(
                    fontSize: 18,
                    color: simpleDialogTitleColor,
                  ),
                ),
              ),
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: 250,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      if(screenWidthForAttachment>=1500)
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
                                margin: const EdgeInsetsDirectional.only(start: 20),
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddAttachmentField(
                                    type: TextInputType.emailAddress,
                                    suffixImagePath: 'images/pdf_image.svg',
                                    controller: filename,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter your email address';
                                      }
                                      return null;
                                    },
                                    label: 'Name',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if(screenWidthForAttachment<1500)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 30),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
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
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 15),
                                  child: AddAttachmentField(
                                    type: TextInputType.emailAddress,
                                    suffixImagePath: 'images/pdf_image.svg',
                                    controller: filename,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter your email address';
                                      }
                                      return null;
                                    },
                                    label: 'Name',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          _selectFile();
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
                                'Add file',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          // DrAidCubit.get(context).createAppointment(
                          //     PatientId: 1
                          //     , date: '2024-5-10',
                          //     startTime: '17:30:00',
                          //     endTime: '18:00:00',
                          //     complaint: 'حشو سن'
                          // );

                          // DrAidCubit.get(context).createWaitingList(
                          //     PatientId: 1,
                          //     date: '2024-6-27'
                          // );

                          if (_selectedFile != null ||
                              _selectedFileBytes != null) {
                            if(filename.text!='')
                              DrAidCubit.get(context).createAttachments(
                                patientId: DrAidCubit.get(context).patientId,
                                title: filename.text,
                                file: _selectedFile,
                                fileBytes: _selectedFileBytes,
                                token: CacheHelper.getData(key: 'token'),
                                //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiJhYWFhYdij2K3ZhdivINi02YrYriDYp9mE2LTYqNin2KgiLCJyb2xlcyI6WyJhZG1pbiJdLCJpYXQiOjE3MTg5MTQ3ODh9.z6zwzLFfHljjEkR2fvxbZ-vAKWN0YfCRjMHMnvzmaG8'
                              );

                            // createAttachments(
                            //   patientId: 1,
                            //   title: filename.text,
                            //   file: _selectedFile,
                            //   fileBytes: _selectedFileBytes,
                            //   token: 'your_token_here', // Replace with your actual token
                            // );
                          } else {
                            print("No file selected");
                          }

                          // if (_selectedFile != null) {
                          //   print("Final selected file path: ${_selectedFile!.path}");
                          //   DrAidCubit.get(context).createAttachments(
                          //     patientId: 1,
                          //     title: filename.text,
                          //     file: _selectedFile!,
                          //     token: 'your_token_here', // Replace with your actual token
                          //   );
                          // } else {
                          //   print("No file selected");
                          // }
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
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
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
      },
    );
  }

  // Future<void> openInChrome(String url) async {
  //   try {
  //     if (await canLaunch(url)) {
  //       await launch(
  //         url,
  //         forceSafariVC: false,
  //         forceWebView: false,
  //         headers: <String, String>{'header_key': 'header_value'},
  //       );
  //     } else {
  //       throw 'Could not launch $url';
  //     }
  //   } catch (e) {
  //     print('Error launching URL: $e');
  //     // Handle error as needed
  //   }
  // }

  void _openFile(String filePath) {
    final url = 'file:///' + filePath.replaceAll('\\', '/');
    html.window.open(url, '_blank');
  }

  Future<void> openInChrome(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'header_key': 'header_value'},
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Handle error as needed
    }
  }

  String getFileUrl(String filePath) {
    // Replace backslashes with forward slashes and prefix with 'file:///'
    return filePath.replaceAll(r'\\', '/');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    screenWidthForAttachment=screenWidth;
    return BlocConsumer<DrAidCubit, DrAidStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (DrAidCubit.get(context).getPatientModel?.data.attachments.length !=
            null) {
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
                        height: 450,
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                if(screenWidth>=1400)
                                  Container(
                                    width: 800,
                                    height: 260,
                                    color: Colors.white,
                                    child: GridView.count(
                                      crossAxisCount: 3,
                                      children: List<Widget>.generate(
                                          DrAidCubit.get(context)
                                              .getPatientModel!
                                              .data
                                              .attachments
                                              .length, (index) {
                                        return InkWell(
                                          onTap: () async {
                                            print(5);

                                            //   _openFilePicker();
                                            //   _openFile1();

                                            String url = DrAidCubit.get(context)
                                                .getPatientModel!
                                                .data
                                                .attachments[index]
                                                .url;
                                            if (url.startsWith('D:\\')) {
                                              // Replace backslashes with forward slashes and prepend with http://localhost
                                              var formattedUrl = 'http://localhost/' +
                                                  url.replaceAll(r'\\', '/');
                                              String fileUrl = getFileUrl(
                                                  'D:\\backend for final project\\uploads\\1719353522452-تحليل 9');
                                              // openInChrome(fileUrl);
                                              //  openInChrome('D://backend%20for%20final%20project//uploads//1719354937988-%C3%98%C2%AA%C3%98%C2%AD%C3%99%C2%84%C3%99%C2%8A%C3%99%C2%84%2010');
                                              // await openInChrome('D:\\backend for final project\\uploads//1718971863897-plant.jpg');
                                              await openInChrome(formattedUrl);
                                            }
                                            // String fileUrl = 'D:\\backend for final project\\uploads//1718971863897-plant.jpg';
                                            //  String filePath = 'D:/backend for final project/uploads/1718971863897-plant.jpg';
                                            // _openFile(filePath);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              width: 200,
                                              height: 260,
                                              color: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'images/pdf_image.svg',
                                                      semanticsLabel: 'My SVG Image',
                                                      height: 120,
                                                      width: 120,
                                                      //color: fontColor2,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      DrAidCubit.get(context).getPatientModel!.data.attachments[index].title,
                                                      //'تحليل الحساسية',
                                                      style: const TextStyle(
                                                        fontSize: 26,
                                                        color: buttonColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );

                                        //treatmentPlanItem();
                                      }),
                                    ),

                                    //       GridView.builder(
                                    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    //             crossAxisCount: 3,
                                    //             childAspectRatio: 1, // Adjust this value to change the aspect ratio of the items
                                    //           ),
                                    //           itemBuilder:(context,index) {
                                    //             return   Container(
                                    //               margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    //               width: 100, // Specify the width of the container
                                    //               height: 200, // Specify the height of the container
                                    //               decoration: BoxDecoration(
                                    //                 border: Border.all(
                                    //                   color: borderColor, // Set the border color
                                    //                   width: 2, // Set the border width
                                    //                 ),
                                    //                 borderRadius: BorderRadius.circular(10), // Apply a circular border radius
                                    //               ),
                                    //               child: const Column(
                                    //                 children: [
                                    //                   SizedBox(height: 10,),
                                    //                   Row(
                                    //                     children: [
                                    //                       Text(' .  باراسيتامول',style: TextStyle(
                                    //                         fontSize: 20,
                                    //                         color:fontColor,
                                    //                       ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                   SizedBox(height: 10,),
                                    //                   Row(
                                    //                     children: [
                                    //                       Text(' .  أنسولين',style: TextStyle(
                                    //                         fontSize: 20,
                                    //                         color:fontColor,
                                    //                       ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                   SizedBox(height: 10,),
                                    //                   Row(
                                    //                     children: [
                                    //                       Text(' .  دوا أحمر',style: TextStyle(
                                    //                         fontSize: 20,
                                    //                         color:fontColor,
                                    //                       ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             );
                                    //
                                    //
                                    //             //   Container(
                                    //             //   margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    //             //   height: 20,
                                    //             //   width: 5,
                                    //             //   color: Colors.red,
                                    //             // );
                                    // }
                                    //
                                    //
                                    //       ),

                                    // ListView(
                                    //   children: [
                                    //     Container(
                                    //       height: 50,
                                    //       width: 10,
                                    //       color: Colors.red,
                                    //     ),
                                    //     SizedBox(height: 10,),
                                    //   ],
                                    // ),
                                  ),
                                if(screenWidth<1400)
                                  Container(
                                    width: 200,
                                    height: 260,
                                    color: Colors.white,
                                    child: ListView.separated(
                                      scrollDirection: Axis.vertical, // Ensures the list scrolls vertically
                                      itemCount: DrAidCubit.get(context).getPatientModel!.data.attachments.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            String url = DrAidCubit.get(context).getPatientModel!.data.attachments[index].url;
                                            if (url.startsWith('D:\\')) {
                                              var formattedUrl = 'http://localhost/' + url.replaceAll(r'\\', '/');
                                              await openInChrome(formattedUrl);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              width: 200,
                                              height: 260,
                                              color: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'images/pdf_image.svg',
                                                      semanticsLabel: 'My SVG Image',
                                                      height: 120,
                                                      width: 120,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      DrAidCubit.get(context).getPatientModel!.data.attachments[index].title,
                                                      style: const TextStyle(
                                                        fontSize: 26,
                                                        color: buttonColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) => const SizedBox(
                                        height: 10, // Adds space between items
                                      ),
                                    ),
                                  ) ,
                              ],
                            ),

                            //SizedBox(height: 20,),
                            InkWell(
                              onTap: () {
                                // treatmentPlanDetails(context);
                                //  addNewTreatmentPlan(context);
                                //addPayment(context);
                                addNewAttachment(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  // Add your Container here
                                  height: 45, // Specify the height of the new container
                                  width: 230, // Make it take the full width
                                  //  color: Colors.blue, // Example color
                                  decoration: BoxDecoration(
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'إضافة مرفق جديد',
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                      height: 450,
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              if(screenWidth>=1400)
                                Container(
                                  width: 800,
                                  height: 260,
                                  color: Colors.white,
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    children: List<Widget>.generate(
                                        DrAidCubit.get(context)
                                            .getPatientModel!
                                            .data
                                            .attachments
                                            .length, (index) {
                                      return InkWell(
                                        onTap: () async {
                                          print(5);

                                          //   _openFilePicker();
                                          //   _openFile1();

                                          String url = DrAidCubit.get(context)
                                              .getPatientModel!
                                              .data
                                              .attachments[index]
                                              .url;
                                          if (url.startsWith('D:\\')) {
                                            // Replace backslashes with forward slashes and prepend with http://localhost
                                            var formattedUrl = 'http://localhost/' +
                                                url.replaceAll(r'\\', '/');
                                            String fileUrl = getFileUrl(
                                                'D:\\backend for final project\\uploads\\1719353522452-تحليل 9');
                                            // openInChrome(fileUrl);
                                            //  openInChrome('D://backend%20for%20final%20project//uploads//1719354937988-%C3%98%C2%AA%C3%98%C2%AD%C3%99%C2%84%C3%99%C2%8A%C3%99%C2%84%2010');
                                            // await openInChrome('D:\\backend for final project\\uploads//1718971863897-plant.jpg');
                                            await openInChrome(formattedUrl);
                                          }
                                          // String fileUrl = 'D:\\backend for final project\\uploads//1718971863897-plant.jpg';
                                          //  String filePath = 'D:/backend for final project/uploads/1718971863897-plant.jpg';
                                          // _openFile(filePath);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            width: 200,
                                            height: 260,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'images/pdf_image.svg',
                                                    semanticsLabel: 'My SVG Image',
                                                    height: 120,
                                                    width: 120,
                                                    //color: fontColor2,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    DrAidCubit.get(context).getPatientModel!.data.attachments[index].title,
                                                    //'تحليل الحساسية',
                                                    style: const TextStyle(
                                                      fontSize: 26,
                                                      color: buttonColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );

                                      //treatmentPlanItem();
                                    }),
                                  ),

                                  //       GridView.builder(
                                  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  //             crossAxisCount: 3,
                                  //             childAspectRatio: 1, // Adjust this value to change the aspect ratio of the items
                                  //           ),
                                  //           itemBuilder:(context,index) {
                                  //             return   Container(
                                  //               margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  //               width: 100, // Specify the width of the container
                                  //               height: 200, // Specify the height of the container
                                  //               decoration: BoxDecoration(
                                  //                 border: Border.all(
                                  //                   color: borderColor, // Set the border color
                                  //                   width: 2, // Set the border width
                                  //                 ),
                                  //                 borderRadius: BorderRadius.circular(10), // Apply a circular border radius
                                  //               ),
                                  //               child: const Column(
                                  //                 children: [
                                  //                   SizedBox(height: 10,),
                                  //                   Row(
                                  //                     children: [
                                  //                       Text(' .  باراسيتامول',style: TextStyle(
                                  //                         fontSize: 20,
                                  //                         color:fontColor,
                                  //                       ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                   SizedBox(height: 10,),
                                  //                   Row(
                                  //                     children: [
                                  //                       Text(' .  أنسولين',style: TextStyle(
                                  //                         fontSize: 20,
                                  //                         color:fontColor,
                                  //                       ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                   SizedBox(height: 10,),
                                  //                   Row(
                                  //                     children: [
                                  //                       Text(' .  دوا أحمر',style: TextStyle(
                                  //                         fontSize: 20,
                                  //                         color:fontColor,
                                  //                       ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             );
                                  //
                                  //
                                  //             //   Container(
                                  //             //   margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  //             //   height: 20,
                                  //             //   width: 5,
                                  //             //   color: Colors.red,
                                  //             // );
                                  // }
                                  //
                                  //
                                  //       ),

                                  // ListView(
                                  //   children: [
                                  //     Container(
                                  //       height: 50,
                                  //       width: 10,
                                  //       color: Colors.red,
                                  //     ),
                                  //     SizedBox(height: 10,),
                                  //   ],
                                  // ),
                                ),
                              if(screenWidth<1400)
                                Container(
                                  width: 200,
                                  height: 260,
                                  color: Colors.white,
                                  child: ListView.separated(
                                    scrollDirection: Axis.vertical, // Ensures the list scrolls vertically
                                    itemCount: DrAidCubit.get(context).getPatientModel!.data.attachments.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async {
                                          String url = DrAidCubit.get(context).getPatientModel!.data.attachments[index].url;
                                          if (url.startsWith('D:\\')) {
                                            var formattedUrl = 'http://localhost/' + url.replaceAll(r'\\', '/');
                                            await openInChrome(formattedUrl);
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            width: 200,
                                            height: 260,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'images/pdf_image.svg',
                                                    semanticsLabel: 'My SVG Image',
                                                    height: 120,
                                                    width: 120,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    DrAidCubit.get(context).getPatientModel!.data.attachments[index].title,
                                                    style: const TextStyle(
                                                      fontSize: 26,
                                                      color: buttonColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => const SizedBox(
                                      height: 10, // Adds space between items
                                    ),
                                  ),
                                ) ,
                            ],
                          ),

                          //SizedBox(height: 20,),
                          InkWell(
                            onTap: () {
                              // treatmentPlanDetails(context);
                              //  addNewTreatmentPlan(context);
                              //addPayment(context);
                              addNewAttachment(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                // Add your Container here
                                height: 45, // Specify the height of the new container
                                width: 230, // Make it take the full width
                                //  color: Colors.blue, // Example color
                                decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Add attachment',
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

            }
          );
        } else if (DrAidCubit.get(context)
                    .getPatientModel
                    ?.data
                    .attachments
                    .length !=
                null &&
            state is DrAidCreateAttachmentsSuccessState) {
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
                        height: 450,
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                if(screenWidth>=1400)
                                  Container(
                                    width: 800,
                                    height: 260,
                                    color: Colors.white,
                                    child: GridView.count(
                                      crossAxisCount: 3,
                                      children: List<Widget>.generate(
                                          DrAidCubit.get(context)
                                              .getPatientModel!
                                              .data
                                              .attachments
                                              .length, (index) {
                                        return InkWell(
                                          onTap: () async {
                                            print(5);

                                            //   _openFilePicker();
                                            //   _openFile1();

                                            String url = DrAidCubit.get(context)
                                                .getPatientModel!
                                                .data
                                                .attachments[index]
                                                .url;
                                            if (url.startsWith('D:\\')) {
                                              // Replace backslashes with forward slashes and prepend with http://localhost
                                              var formattedUrl = 'http://localhost/' +
                                                  url.replaceAll(r'\\', '/');
                                              String fileUrl = getFileUrl(
                                                  'D:\\backend for final project\\uploads\\1719353522452-تحليل 9');
                                              // openInChrome(fileUrl);
                                              //  openInChrome('D://backend%20for%20final%20project//uploads//1719354937988-%C3%98%C2%AA%C3%98%C2%AD%C3%99%C2%84%C3%99%C2%8A%C3%99%C2%84%2010');
                                              // await openInChrome('D:\\backend for final project\\uploads//1718971863897-plant.jpg');
                                              await openInChrome(formattedUrl);
                                            }
                                            // String fileUrl = 'D:\\backend for final project\\uploads//1718971863897-plant.jpg';
                                            //  String filePath = 'D:/backend for final project/uploads/1718971863897-plant.jpg';
                                            // _openFile(filePath);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              width: 200,
                                              height: 260,
                                              color: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'images/pdf_image.svg',
                                                      semanticsLabel: 'My SVG Image',
                                                      height: 120,
                                                      width: 120,
                                                      //color: fontColor2,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      DrAidCubit.get(context).getPatientModel!.data.attachments[index].title,
                                                      //'تحليل الحساسية',
                                                      style: const TextStyle(
                                                        fontSize: 26,
                                                        color: buttonColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );

                                        //treatmentPlanItem();
                                      }),
                                    ),

                                  ),
                                if(screenWidth<1400)
                                  Container(
                                    width: 200,
                                    height: 260,
                                    color: Colors.white,
                                    child: ListView.separated(
                                      scrollDirection: Axis.vertical, // Ensures the list scrolls vertically
                                      itemCount: DrAidCubit.get(context).getPatientModel!.data.attachments.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            String url = DrAidCubit.get(context).getPatientModel!.data.attachments[index].url;
                                            if (url.startsWith('D:\\')) {
                                              var formattedUrl = 'http://localhost/' + url.replaceAll(r'\\', '/');
                                              await openInChrome(formattedUrl);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              width: 200,
                                              height: 260,
                                              color: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'images/pdf_image.svg',
                                                      semanticsLabel: 'My SVG Image',
                                                      height: 120,
                                                      width: 120,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      DrAidCubit.get(context).getPatientModel!.data.attachments[index].title,
                                                      style: const TextStyle(
                                                        fontSize: 26,
                                                        color: buttonColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) => const SizedBox(
                                        height: 10, // Adds space between items
                                      ),
                                    ),
                                  ) ,
                              ],
                            ),

                            //SizedBox(height: 20,),
                            InkWell(
                              onTap: () {
                                // treatmentPlanDetails(context);
                                //  addNewTreatmentPlan(context);
                                //addPayment(context);
                                addNewAttachment(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  // Add your Container here
                                  height: 45, // Specify the height of the new container
                                  width: 230, // Make it take the full width
                                  //  color: Colors.blue, // Example color
                                  decoration: BoxDecoration(
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'إضافة مرفق جديد',
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                      height: 450,
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              if(screenWidth>=1400)
                                Container(
                                  width: 800,
                                  height: 260,
                                  color: Colors.white,
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    children: List<Widget>.generate(
                                        DrAidCubit.get(context)
                                            .getPatientModel!
                                            .data
                                            .attachments
                                            .length, (index) {
                                      return InkWell(
                                        onTap: () async {
                                          print(5);

                                          //   _openFilePicker();
                                          //   _openFile1();

                                          String url = DrAidCubit.get(context)
                                              .getPatientModel!
                                              .data
                                              .attachments[index]
                                              .url;
                                          if (url.startsWith('D:\\')) {
                                            // Replace backslashes with forward slashes and prepend with http://localhost
                                            var formattedUrl = 'http://localhost/' +
                                                url.replaceAll(r'\\', '/');
                                            String fileUrl = getFileUrl(
                                                'D:\\backend for final project\\uploads\\1719353522452-تحليل 9');
                                            // openInChrome(fileUrl);
                                            //  openInChrome('D://backend%20for%20final%20project//uploads//1719354937988-%C3%98%C2%AA%C3%98%C2%AD%C3%99%C2%84%C3%99%C2%8A%C3%99%C2%84%2010');
                                            // await openInChrome('D:\\backend for final project\\uploads//1718971863897-plant.jpg');
                                            await openInChrome(formattedUrl);
                                          }
                                          // String fileUrl = 'D:\\backend for final project\\uploads//1718971863897-plant.jpg';
                                          //  String filePath = 'D:/backend for final project/uploads/1718971863897-plant.jpg';
                                          // _openFile(filePath);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            width: 200,
                                            height: 260,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'images/pdf_image.svg',
                                                    semanticsLabel: 'My SVG Image',
                                                    height: 120,
                                                    width: 120,
                                                    //color: fontColor2,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    DrAidCubit.get(context).getPatientModel!.data.attachments[index].title,
                                                    //'تحليل الحساسية',
                                                    style: const TextStyle(
                                                      fontSize: 26,
                                                      color: buttonColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );

                                      //treatmentPlanItem();
                                    }),
                                  ),

                                ),
                              if(screenWidth<1400)
                                Container(
                                  width: 200,
                                  height: 260,
                                  color: Colors.white,
                                  child: ListView.separated(
                                    scrollDirection: Axis.vertical, // Ensures the list scrolls vertically
                                    itemCount: DrAidCubit.get(context).getPatientModel!.data.attachments.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () async {
                                          String url = DrAidCubit.get(context).getPatientModel!.data.attachments[index].url;
                                          if (url.startsWith('D:\\')) {
                                            var formattedUrl = 'http://localhost/' + url.replaceAll(r'\\', '/');
                                            await openInChrome(formattedUrl);
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            width: 200,
                                            height: 260,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'images/pdf_image.svg',
                                                    semanticsLabel: 'My SVG Image',
                                                    height: 120,
                                                    width: 120,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    DrAidCubit.get(context).getPatientModel!.data.attachments[index].title,
                                                    style: const TextStyle(
                                                      fontSize: 26,
                                                      color: buttonColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => const SizedBox(
                                      height: 10, // Adds space between items
                                    ),
                                  ),
                                ) ,
                            ],
                          ),

                          //SizedBox(height: 20,),
                          InkWell(
                            onTap: () {
                              // treatmentPlanDetails(context);
                              //  addNewTreatmentPlan(context);
                              //addPayment(context);
                              addNewAttachment(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                // Add your Container here
                                height: 45, // Specify the height of the new container
                                width: 230, // Make it take the full width
                                //  color: Colors.blue, // Example color
                                decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Add attachment',
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

            }
          );
        } else {
          return Builder(
            builder: (context) {
              if(languagee=='arabic')
                {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: const Center(
                      child: Text(
                        'حدث خطأ ما',
                        style: TextStyle(fontSize: 24, color: Colors.grey),
                      ),
                    ),
                  );
                }
              else{
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: const Center(
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ),
                );
              }

            }
          );
        }
      },
    );
  }
}
