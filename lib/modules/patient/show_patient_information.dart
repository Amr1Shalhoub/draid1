// ignore_for_file: deprecated_member_use
import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/modules/patient/middle_bar.dart';
import 'package:draid/modules/patient/teeth_chart.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PatientInformation extends StatelessWidget {
  const PatientInformation({super.key});

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
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 700,
                        color: coolWhite2,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsetsDirectional.only(start: 20, end: 130),
                                child: Row(
                                  children: [
                                    if(screenWidth>=1200&&modee=='light')
                                      InkWell(
                                        child: const Image(
                                          image: AssetImage('images/arrow.png'),
                                          width: 30,
                                          height: 20,
                                        ),
                                        onTap: () {
                                          DrAidCubit.get(context).getAllPatientsData();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    if(screenWidth>=1300&&modee=='light')
                                      const Text(
                                        'عرض معلومات مريض',
                                        style: TextStyle(fontSize: 28, color: blueText),
                                      ),
                                    if(screenWidth>=1300&&modee=='dark')
                                      const Text(
                                        'عرض معلومات مريض',
                                        style: TextStyle(fontSize: 28, color: Colors.orange),
                                      ),
                                    if(screenWidth<1300&&modee=='light')
                                      const Text(
                                        'معلومات مريض',
                                        style: TextStyle(fontSize: 14, color: blueText),
                                      ),
                                    if(screenWidth<1300&&modee=='dark')
                                      const Text(
                                        'معلومات مريض',
                                        style: TextStyle(fontSize: 14, color: Colors.orange),
                                      ),
                                    const Spacer(),
                                    if(screenWidth>=1350&&modee=='light')
                                      Container(
                                        width: 200,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: coolGreen1,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // navigateTo(context, const ToothChart());
                                            navigateTo(
                                                context,
                                                Foo(
                                                    asset: 'images/teeth.svg',
                                                    idToString: (int id) => 'Tooth $id',
                                                    patientId:
                                                    '${DrAidCubit.get(context).getPatientModel!.data.id}',
                                                    token:tokennn
                                                  // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiLYo9it2YXYryDYtNmK2K4g2KfZhNi02KjYp9ioIiwicm9sZXMiOlsiYWRtaW4iXSwiaWF0IjoxNzE4NjA0NjE2fQ.hlL_f3ls3XTsO8S1TJB5a-7y1M8SWQe2IbQ5d0DM-is',
                                                ));
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(start: 30),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                'images/tooth_icon.svg',
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
                                                'حالة المريض',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    if(screenWidth>=1350&&modee=='dark')
                                      Container(
                                        width: 200,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.orangeAccent,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // navigateTo(context, const ToothChart());
                                            navigateTo(
                                                context,
                                                Foo(
                                                    asset: 'images/teeth.svg',
                                                    idToString: (int id) => 'Tooth $id',
                                                    patientId:
                                                    '${DrAidCubit.get(context).getPatientModel!.data.id}',
                                                    token:tokennn
                                                  // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiLYo9it2YXYryDYtNmK2K4g2KfZhNi02KjYp9ioIiwicm9sZXMiOlsiYWRtaW4iXSwiaWF0IjoxNzE4NjA0NjE2fQ.hlL_f3ls3XTsO8S1TJB5a-7y1M8SWQe2IbQ5d0DM-is',
                                                ));
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(start: 30),
                                            child: Row(children: [
                                              SvgPicture.asset(
                                                'images/tooth_icon.svg',
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
                                                'حالة المريض',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    if(screenWidth<1350&&modee=='light')
                                      Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: coolGreen1,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // navigateTo(context, const ToothChart());
                                            navigateTo(
                                                context,
                                                Foo(
                                                    asset: 'images/teeth.svg',
                                                    idToString: (int id) => 'Tooth $id',
                                                    patientId:
                                                    '${DrAidCubit.get(context).getPatientModel!.data.id}',
                                                    token:tokennn
                                                  // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiLYo9it2YXYryDYtNmK2K4g2KfZhNi02KjYp9ioIiwicm9sZXMiOlsiYWRtaW4iXSwiaWF0IjoxNzE4NjA0NjE2fQ.hlL_f3ls3XTsO8S1TJB5a-7y1M8SWQe2IbQ5d0DM-is',
                                                ));
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(start: 30),
                                            child: Row(children: [

                                              const Text(
                                                'الحالة',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    if(screenWidth<1350&&modee=='dark')
                                      Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.orangeAccent,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // navigateTo(context, const ToothChart());
                                            navigateTo(
                                                context,
                                                Foo(
                                                    asset: 'images/teeth.svg',
                                                    idToString: (int id) => 'Tooth $id',
                                                    patientId:
                                                    '${DrAidCubit.get(context).getPatientModel!.data.id}',
                                                    token:tokennn
                                                  // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiLYo9it2YXYryDYtNmK2K4g2KfZhNi02KjYp9ioIiwicm9sZXMiOlsiYWRtaW4iXSwiaWF0IjoxNzE4NjA0NjE2fQ.hlL_f3ls3XTsO8S1TJB5a-7y1M8SWQe2IbQ5d0DM-is',
                                                ));
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsetsDirectional.only(start: 30),
                                            child: Row(children: [

                                              const Text(
                                                'الحالة',
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
                              const MiddleBar(
                                texts: [
                                  'المعلومات الأساسية',
                                  'الأدوية و الأمراض',
                                  'المعالجات',
                                  'المرفقات'
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DrAidCubit.get(context).bottomPatientscreens[
                              DrAidCubit.get(context).currentindex],
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
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 700,
                      color: coolWhite2,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsetsDirectional.only(start: 20, end: 130),
                              child: Row(
                                children: [
                                  if(screenWidth>=1200&&modee=='light')
                                    InkWell(
                                      child: const Image(
                                        image: AssetImage('images/arrow.png'),
                                        width: 30,
                                        height: 20,
                                      ),
                                      onTap: () {
                                        DrAidCubit.get(context).getAllPatientsData();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  if(screenWidth>=1300&&modee=='light')
                                    const Text(
                                      'Patient info',
                                      style: TextStyle(fontSize: 28, color: blueText),
                                    ),
                                  if(screenWidth>=1300&&modee=='dark')
                                    const Text(
                                      'Patient info',
                                      style: TextStyle(fontSize: 28, color: Colors.orange),
                                    ),
                                  if(screenWidth<1300&&modee=='light')
                                    const Text(
                                      'Patient info',
                                      style: TextStyle(fontSize: 14, color: blueText),
                                    ),
                                  if(screenWidth<1300&&modee=='dark')
                                    const Text(
                                      'Patient info',
                                      style: TextStyle(fontSize: 14, color: Colors.orange),
                                    ),
                                  const Spacer(),
                                  if(screenWidth>=1350&&modee=='light')
                                    Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: coolGreen1,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // navigateTo(context, const ToothChart());
                                          navigateTo(
                                              context,
                                              Foo(
                                                  asset: 'images/teeth.svg',
                                                  idToString: (int id) => 'Tooth $id',
                                                  patientId:
                                                  '${DrAidCubit.get(context).getPatientModel!.data.id}',
                                                  token:tokennn
                                                // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiLYo9it2YXYryDYtNmK2K4g2KfZhNi02KjYp9ioIiwicm9sZXMiOlsiYWRtaW4iXSwiaWF0IjoxNzE4NjA0NjE2fQ.hlL_f3ls3XTsO8S1TJB5a-7y1M8SWQe2IbQ5d0DM-is',
                                              ));
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(start: 30),
                                          child: Row(children: [
                                            SvgPicture.asset(
                                              'images/tooth_icon.svg',
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
                                              'condition',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                  if(screenWidth>=1350&&modee=='dark')
                                    Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // navigateTo(context, const ToothChart());
                                          navigateTo(
                                              context,
                                              Foo(
                                                  asset: 'images/teeth.svg',
                                                  idToString: (int id) => 'Tooth $id',
                                                  patientId:
                                                  '${DrAidCubit.get(context).getPatientModel!.data.id}',
                                                  token:tokennn
                                                // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiLYo9it2YXYryDYtNmK2K4g2KfZhNi02KjYp9ioIiwicm9sZXMiOlsiYWRtaW4iXSwiaWF0IjoxNzE4NjA0NjE2fQ.hlL_f3ls3XTsO8S1TJB5a-7y1M8SWQe2IbQ5d0DM-is',
                                              ));
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(start: 30),
                                          child: Row(children: [
                                            SvgPicture.asset(
                                              'images/tooth_icon.svg',
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
                                              'condition',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                  if(screenWidth<1350&&modee=='light')
                                    Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: coolGreen1,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // navigateTo(context, const ToothChart());
                                          navigateTo(
                                              context,
                                              Foo(
                                                  asset: 'images/teeth.svg',
                                                  idToString: (int id) => 'Tooth $id',
                                                  patientId:
                                                  '${DrAidCubit.get(context).getPatientModel!.data.id}',
                                                  token:tokennn
                                                // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiLYo9it2YXYryDYtNmK2K4g2KfZhNi02KjYp9ioIiwicm9sZXMiOlsiYWRtaW4iXSwiaWF0IjoxNzE4NjA0NjE2fQ.hlL_f3ls3XTsO8S1TJB5a-7y1M8SWQe2IbQ5d0DM-is',
                                              ));
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(start: 30),
                                          child: Row(children: [

                                            const Text(
                                              'condition',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                  if(screenWidth<1350&&modee=='dark')
                                    Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // navigateTo(context, const ToothChart());
                                          navigateTo(
                                              context,
                                              Foo(
                                                  asset: 'images/teeth.svg',
                                                  idToString: (int id) => 'Tooth $id',
                                                  patientId:
                                                  '${DrAidCubit.get(context).getPatientModel!.data.id}',
                                                  token:tokennn
                                                // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZnVsbE5hbWUiOiLYo9it2YXYryDYtNmK2K4g2KfZhNi02KjYp9ioIiwicm9sZXMiOlsiYWRtaW4iXSwiaWF0IjoxNzE4NjA0NjE2fQ.hlL_f3ls3XTsO8S1TJB5a-7y1M8SWQe2IbQ5d0DM-is',
                                              ));
                                        },
                                        child: Padding(
                                          padding:
                                          const EdgeInsetsDirectional.only(start: 30),
                                          child: Row(children: [

                                            const Text(
                                              'condition',
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
                            const MiddleBar(
                              texts: [
                                'Basic info',
                                'Medicines',
                                'Treatments',
                                'Attachments'
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DrAidCubit.get(context).bottomPatientscreens[
                            DrAidCubit.get(context).currentindex],
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
