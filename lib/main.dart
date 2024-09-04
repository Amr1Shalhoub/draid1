// ignore_for_file: unused_import

import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/layout/finance_layout/finance_layout.dart';
import 'package:draid/layout/patient_layout/patient_information_layout.dart';
import 'package:draid/modules/all_patients/all_patients.dart';
import 'package:draid/modules/alltreatments/show_treatments.dart';
import 'package:draid/modules/addclinic/add_clinic.dart';
import 'package:draid/modules/dashboard/dashboard_screen.dart';
import 'package:draid/modules/login/login_screen.dart';
import 'package:draid/modules/patient/teeth_chart.dart';
import 'package:draid/shared/bloc_observer.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/network/local/cache_helper.dart';
import 'package:draid/shared/network/local/flutter_secure_storage_helper.dart';
import 'package:draid/shared/network/remote/dio_helper.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  //await FlutterSecure.init();

 // tokennn = await FlutterSecure.getData(key: 'jwt_token')??'3';

  tokennn=await CacheHelper.getData(key: 'token')??'3';
  roleFromBackend=await CacheHelper.getData(key: 'role')??'2';
  modee=await CacheHelper.getData(key: 'mode')??'light';
  languagee=await CacheHelper.getData(key: 'language')??'arabic';
  changeColorsAccordingToMode();
  print(5);
  print(tokennn);
  print(roleFromBackend);


  Widget widget;
  if(tokennn=='3')
    {
      widget =
      const Login();
    }
  else{
    widget =DashboardScreen();
  }

   // const DashboardScreen();

  runApp(MyApp(
    startWidget: widget,
  ));
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    final String currentDate =
        DateTime.now().toIso8601String().split('T').first;

    if(tokennn=='3')
      {
        return  MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => DrAidCubit()
                    // ..getAllTreatments()
                    // ..getAppointments()
                    // ..getWaitingList()
                    // ..getAppointmentsByDate(date: currentDate)
                    // ..getWaitingListByDate(date: currentDate)
                    // ..getAllPatientsData()
                // ..getWaitingList()

              ),
            ],
            child: BlocConsumer<DrAidCubit, DrAidStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return MaterialApp(
                  theme: ThemeData(primarySwatch: Colors.deepPurple),
                  debugShowCheckedModeBanner: false,
                  builder: EasyLoading.init(),
                  home: Directionality(
                    textDirection: TextDirection.rtl,
                    child: startWidget,
                  ),
                );
              },
            ));
      }

   else if(roleFromBackend=='assistant')
      {
        return  MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => DrAidCubit()
                    ..getAllTreatments()
                    ..getAppointments()
                    ..getWaitingList()
                    ..getAppointmentsByDate(date: currentDate)
                    ..getWaitingListByDate(date: currentDate)
                    ..getAllPatientsData()
                // ..getWaitingList()

              ),
            ],
            child: BlocConsumer<DrAidCubit, DrAidStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return MaterialApp(
                  theme: ThemeData(primarySwatch: Colors.deepPurple,
                    scaffoldBackgroundColor: Colors.grey


                  ),
                  debugShowCheckedModeBanner: false,
                  builder: EasyLoading.init(),
                  home: Builder(
                    builder: (context) {
                      if(languagee=='arabic')
                        {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: startWidget,
                          );
                        }
                      else{
                        return Directionality(
                          textDirection: TextDirection.ltr,
                          child: startWidget,
                        );
                      }

                    }
                  ),
                );
              },
            ));
      }
  else  if(roleFromBackend=='secretary')
    {
      return  MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => DrAidCubit()
                  ..getAllPayments()
                  ..getBillsForAClinic()
                  ..getPatientPayments()
                  ..getAppointments()
                  ..getWaitingList()
                  ..getAppointmentsByDate(date: currentDate)
                  ..getWaitingListByDate(date: currentDate)
                  ..getAllPatientsData()
                  ..getPatientDebts()
              // ..getWaitingList()

            ),
          ],
          child: BlocConsumer<DrAidCubit, DrAidStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                theme: ThemeData(primarySwatch: Colors.deepPurple),
                debugShowCheckedModeBanner: false,
                builder: EasyLoading.init(),
                home: Directionality(
                  textDirection: TextDirection.rtl,
                  child: startWidget,
                ),
              );
            },
          ));
    }
    else{
      return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => DrAidCubit()
                  ..getAllTreatments()
                  ..getAllPayments()
                  ..getBillsForAClinic()
                  ..getPatientPayments()
                  ..getAppointments()
                  ..getWaitingList()
                  ..getAppointmentsByDate(date: currentDate)
                  ..getWaitingListByDate(date: currentDate)
                  ..getAllPatientsData()
                  ..getPatientDebts()
              // ..getWaitingList()

            ),
          ],
          child: BlocConsumer<DrAidCubit, DrAidStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                theme: ThemeData(primarySwatch: Colors.deepPurple,

                ),
                debugShowCheckedModeBanner: false,
                builder: EasyLoading.init(),
                home: Directionality(
                  textDirection: TextDirection.rtl,
                  child: startWidget,
                ),
              );
            },
          ));
    }


  }
}
