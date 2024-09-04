import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/modules/finance/bill.dart';
import 'package:draid/modules/sidebar/side_bar_screen.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceLayout extends StatefulWidget {
  const FinanceLayout({super.key});

  @override
  State<FinanceLayout> createState() => _FinanceLayoutState();
}

class _FinanceLayoutState extends State<FinanceLayout> {
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
                        //if(!isMobile&&!isTablet)
                        if(screenWidth>1530)
                          SideBarScreen(),
                        Bill()

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
                  appBar: CustomAppBar(),
                  body: Row(
                    children: [
                      //if(!isMobile&&!isTablet)
                      if(screenWidth>1530)
                        SideBarScreen(),
                      Bill()

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
