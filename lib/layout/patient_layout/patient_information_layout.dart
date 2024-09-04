import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/modules/patient/show_patient_information.dart';
import 'package:draid/modules/sidebar/side_bar_screen.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientInformationLayout extends StatefulWidget {
  const PatientInformationLayout({super.key});

  @override
  State<PatientInformationLayout> createState() =>
      _PatientInformationLayoutState();
}

class _PatientInformationLayoutState extends State<PatientInformationLayout> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    return BlocConsumer<DrAidCubit, DrAidStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  Builder(
          builder: (context) {
            if(languagee=='arabic')
              {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    backgroundColor: coolWhite2,
                    appBar: CustomAppBar(),
                    body: Row(
                      children: [
                        if(screenWidth>1530)
                          SideBarScreen(),
                        PatientInformation()],
                    ),
                  ),
                );
              }
            else{
              return Directionality(
                textDirection: TextDirection.ltr,
                child: Scaffold(
                  backgroundColor: coolWhite2,
                  appBar: CustomAppBar(),
                  body: Row(
                    children: [
                      if(screenWidth>1530)
                        SideBarScreen(),
                      PatientInformation()],
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
