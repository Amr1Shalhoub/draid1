import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientBasicInformationForSecretary extends StatelessWidget {
  const PatientBasicInformationForSecretary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<DrAidCubit,DrAidStates>(
      listener: (context,state){},
      builder: (context,state){
        return Builder(
          builder: (context) {
            if(languagee=='arabic')
              {
                return Directionality(
                  textDirection: TextDirection.rtl,

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 175.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 400,
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
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

                              ],
                            ),
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

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 175.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 400,
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
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

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

          }
        );

      },
    );

  }
}
