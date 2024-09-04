
// import 'package:draid/modules/navbar.dart';
// import 'package:draid/shared/styles/colors.dart';
// import 'package:flutter/material.dart';

// class StartScreen extends StatelessWidget {
//   const StartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final currentWidth=MediaQuery.of(context).size.width;
//     return Scaffold(

//       body: Container(
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   colors:[
//                     Color(0xFFF8FBFF),
//                     Color(0xFFFCFDFD),
//                   ])
//           ),
//           child:Scaffold(
//             backgroundColor: Colors.transparent,
//             body: SingleChildScrollView(
//               child: Column(


//                 children: [
//                   AspectRatio(
//                     aspectRatio: 70 / 9,
//                     child: NavBar(),
//                   ),
//                  const SizedBox(height: 50,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(left: 20),
//                         width: 120,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(colors:[
//                             coolBlue,
//                             coolBlue,
//                            // Color(0xFFC86DD7)
//                             //,Color(0xFF3023AE)
//                           ],
//                             begin: Alignment.bottomRight,
//                             end: Alignment.topLeft, ),
//                           borderRadius: BorderRadius.circular(20),


//                         ),
//                         child: const Material(
//                           color:Colors.transparent ,
//                           child: Center(child: Text('Get Started',style: TextStyle(fontSize: 16,color: Colors.white),),),
//                         ),

//                       ),
//                      if(currentWidth>750)
//                        Image.asset('images/dr.png'),
//                     ],
//                   ),
//                   // SizedBox(height: 200,),
//                   // Stack(
//                   //   fit: StackFit.expand,
//                   //   children: [
//                   //     FractionallySizedBox(
//                   //       alignment: Alignment.centerRight,
//                   //       widthFactor: .6,
//                   //       child: Image.network('assets/image_01.png',scale: .85,),
//                   //     )
//                   //   ],
//                   // ),
//                   // FractionallySizedBox(
//                   //   alignment: Alignment.centerRight,
//                   //   widthFactor: .1,
//                   //   child: Text('Hello',style: TextStyle(fontSize: 26),) ,
//                   // )

//                 ],
//               ),
//             ) ,
//           )
//       ) ,
//     );


//   }
// }
