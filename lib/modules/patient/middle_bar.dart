// import 'package:draid/layout/cubit/cubit.dart';
// import 'package:draid/layout/cubit/states.dart';
// import 'package:flutter/material.dart';

// import '../../shared/styles/colors.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MiddleBar extends StatefulWidget {
//   final List<String> texts;
//   const MiddleBar({
//     required this.texts,
//     super.key,
//   });

//   @override
//   State<MiddleBar> createState() => _MiddleBarState();
// }

// class _MiddleBarState extends State<MiddleBar> {
//   int index = 0;

//   int selectedIndex1 = 0;

//   @override
//   Widget build(BuildContext context) {
//     Widget buildContainer(context, int index) {
//       if (index == 0) {
//         return InkWell(
//           onTap: () {
//             setState(() {
//               selectedIndex1 = index;
//               DrAidCubit.get(context).changeCurrentIndex(index);
//               DrAidCubit.get(context).printCurrentIndex();
//             });
//           },
//           child: Container(
//             width: 246,
//             height: 50,
//             decoration: BoxDecoration(
//               color: selectedIndex1 == index ? buttonColor : Colors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       color: selectedIndex1 == index
//                           ? Colors.white
//                           : numberBackGroundColor,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         '1',
//                         style: TextStyle(fontSize: 20, color: fontColor2),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     widget.texts[index],
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: selectedIndex1 == index
//                             ? Colors.white
//                             : fontColor2),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//       if (index == 1) {
//         return InkWell(
//           onTap: () {
//             setState(() {
//               selectedIndex1 = index;
//               DrAidCubit.get(context).changeCurrentIndex(index);
//               DrAidCubit.get(context).printCurrentIndex();
//             });
//           },
//           child: Container(
//             width: 246,
//             height: 50,
//             decoration: BoxDecoration(
//               color: selectedIndex1 == index ? buttonColor : Colors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       color: selectedIndex1 == index
//                           ? Colors.white
//                           : numberBackGroundColor,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         '2',
//                         style: TextStyle(fontSize: 20, color: fontColor2),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     widget.texts[index],
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: selectedIndex1 == index
//                             ? Colors.white
//                             : fontColor2),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//       if (index == 2) {
//         return InkWell(
//           onTap: () {
//             setState(() {
//               selectedIndex1 = index;
//               DrAidCubit.get(context).changeCurrentIndex(index);
//               DrAidCubit.get(context).printCurrentIndex();
//             });
//           },
//           child: Container(
//             width: 246,
//             height: 50,
//             decoration: BoxDecoration(
//               color: selectedIndex1 == index ? buttonColor : Colors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       color: selectedIndex1 == index
//                           ? Colors.white
//                           : numberBackGroundColor,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         '3',
//                         style: TextStyle(fontSize: 20, color: fontColor2),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     widget.texts[index],
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: selectedIndex1 == index
//                             ? Colors.white
//                             : fontColor2),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//       if (index == 3) {
//         return InkWell(
//           onTap: () {
//             setState(() {
//               selectedIndex1 = index;
//               DrAidCubit.get(context).changeCurrentIndex(index);
//               DrAidCubit.get(context).printCurrentIndex();
//             });
//           },
//           child: Container(
//             width: 246,
//             height: 50,
//             decoration: BoxDecoration(
//               color: selectedIndex1 == index ? buttonColor : Colors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       color: selectedIndex1 == index
//                           ? Colors.white
//                           : numberBackGroundColor,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         '4',
//                         style: TextStyle(fontSize: 20, color: fontColor2),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     widget.texts[index],
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: selectedIndex1 == index
//                             ? Colors.white
//                             : fontColor2),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       } else {
//         return const SizedBox(
//           width: 10,
//         );
//       }
//     }

//     return BlocConsumer<DrAidCubit, DrAidStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         //var CurrentIndex=DrAidCubit.get(context).currentindex;
//         DrAidCubit.get(context).printCurrentIndex();
//         return Row(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width * 0.65,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.65,
//                     child: ListView.separated(
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) =>
//                             buildContainer(context, index),
//                         separatorBuilder: (context, index) => const SizedBox(
//                               width: 5,
//                             ),
//                         itemCount: 4),
//                   ),

//                   //List.generate(4, (index1) => buildContainer(index1)),
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class MiddleBar extends StatefulWidget {
//   final List<String> texts;
//   const MiddleBar({
//     required this.texts,
//     super.key,
//   });
//
//   @override
//   State<MiddleBar> createState() => _MiddleBarState();
// }
//
// class _MiddleBarState extends State<MiddleBar> {
//   int selectedIndex1 = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     Widget buildContainer(BuildContext context, int index) {
//       return InkWell(
//         onTap: () {
//           setState(() {
//             selectedIndex1 = index;
//             DrAidCubit.get(context).changeCurrentIndex(index);
//            // DrAidCubit.get(context).printCurrentIndex();
//             //DrAidCubit.get(context).changeFinanceIndex(index);
//
//
//           });
//         },
//         child: Container(
//           width: 246,
//           height: 50,
//           decoration: BoxDecoration(
//             color: selectedIndex1 == index ? buttonColor : Colors.white,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Container(
//                   width: 30,
//                   height: 30,
//                   decoration: BoxDecoration(
//                     color: selectedIndex1 == index
//                         ? Colors.white
//                         : numberBackGroundColor,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Center(
//                     child: Text(
//                       '${index + 1}',
//                       style: const TextStyle(fontSize: 20, color: fontColor2),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 15,
//                 ),
//                 Text(
//                   widget.texts[index],
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: selectedIndex1 == index
//                           ? Colors.white
//                           : fontColor2),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//
//     return BlocConsumer<DrAidCubit, DrAidStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         DrAidCubit.get(context).printCurrentIndex();
//         return Row(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width * 0.65,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.65,
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) =>
//                           buildContainer(context, index),
//                       separatorBuilder: (context, index) => const SizedBox(
//                         width: 5,
//                       ),
//                       itemCount: widget.texts.length,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }



// here is the more responsive


class MiddleBar extends StatefulWidget {
  final List<String> texts;
  const MiddleBar({
    required this.texts,
    super.key,
  });

  @override
  State<MiddleBar> createState() => _MiddleBarState();
}

class _MiddleBarState extends State<MiddleBar> {
  int selectedIndex1 = 0;

  @override
  Widget build(BuildContext context) {
    Widget buildContainer(BuildContext context, int index) {

      return Builder(
        builder: (context) {
          if(modee=='light')
            {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex1 = index;
                    DrAidCubit.get(context).changeCurrentIndex(index);
                  });
                },
                child: Container(
                  width: 246,
                  height: 50,
                  decoration: BoxDecoration(
                    color: selectedIndex1 == index ? buttonColor : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: selectedIndex1 == index
                                ? Colors.white
                                : numberBackGroundColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(fontSize: 20, color: fontColor2),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.texts[index],
                          style: TextStyle(
                              fontSize: 20,
                              color: selectedIndex1 == index
                                  ? Colors.white
                                  : fontColor2),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          else{
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex1 = index;
                  DrAidCubit.get(context).changeCurrentIndex(index);
                });
              },
              child: Container(
                width: 246,
                height: 50,
                decoration: BoxDecoration(
                  color: selectedIndex1 == index ? Colors.orangeAccent : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: selectedIndex1 == index
                              ? Colors.white
                              : numberBackGroundColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(fontSize: 20, color: fontColor2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.texts[index],
                        style: TextStyle(
                            fontSize: 20,
                            color: selectedIndex1 == index
                                ? Colors.white
                                : fontColor2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

        }
      );
    }

    return BlocConsumer<DrAidCubit, DrAidStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DrAidCubit.get(context).printCurrentIndex();
        return Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => buildContainer(context, index),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 5,
                ),
                itemCount: widget.texts.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
