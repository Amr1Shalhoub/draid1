
// import 'package:draid/shared/styles/colors.dart';
// import 'package:flutter/material.dart';

// class NavBar extends StatelessWidget {
//   final navLinks=['Home','Features','Contacts'];

//    NavBar({super.key});
//   List<Widget> navItem(){
//     return navLinks.map((text){return Padding(
//         padding: const EdgeInsets.only(left: 18),
//             child: Text(text,style: const TextStyle(fontSize: 16),),
//     );
//     }
//     ).toList();
//   }
//  // const NavBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 38),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             height: 45,
//               width: 45,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(18),
//               gradient: const LinearGradient(
//                   colors: [
//                     coolBlue,
//                     coolBlue,
//                    // Color(0xFFC86DD7),
//                     //Color(0xFF3023AE)
//                   ],
//                 begin: Alignment.bottomRight,
//                 end: Alignment.topLeft,

//               )
//             ),
//             child: const Center(child:
//               Text('DA',style: TextStyle(
//                 fontSize:30,
//                 color: Colors.white,
//               ),
//               ),
//             ),
//           ),
//           //SizedBox(width: 16,),
//           const Text('Doctor Aid',style: TextStyle(fontSize: 26,),),
//           const SizedBox(width: 40,),
//           const Text('Home',style: TextStyle(fontSize: 18),),
//           const Text('Features',style: TextStyle(fontSize: 18),),
//           const Text('Contacts',style: TextStyle(fontSize: 18),),
//           Container(
//             margin: const EdgeInsets.only(left: 20),
//             width: 120,
//             height: 40,
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(colors:[
//                 coolBlue,
//                 coolBlue,
//                 //Color(0xFFC86DD7),
//                 //Color(0xFF3023AE)
//               ],
//                 begin: Alignment.bottomRight,
//                 end: Alignment.topLeft, ),
//               borderRadius: BorderRadius.circular(20),


//             ),
//             child: const Material(
//               color:Colors.transparent ,
//               child: Center(child: Text('Login',style: TextStyle(fontSize: 16,color: Colors.white),),),
//             ),

//           ),



//         ],
//       ),


//     );
//   }
// }
