// import 'package:draid/layout/cubit/cubit.dart';
// import 'package:draid/shared/components/components.dart';
// import 'package:draid/shared/styles/colors.dart';
// import 'package:flutter/material.dart';
//
// class Login extends StatelessWidget {
//   const Login({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//     return Scaffold(
//       body: Row(
//         children: [
//           Expanded(
//             child: Container(
//               color: Colors.white,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'images/logo.gif',
//                     width: 300,
//                     height: 300,
//                   ),
//                   const Text(
//                     'Doctor Aid',
//                     style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               color: ColorManager.backgroundColor,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 200, right: 200),
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'مرحبا بك،',
//                         style: TextStyle(
//                             fontSize: 32, fontWeight: FontWeight.bold),
//                       ),
//                       const Text(
//                         'سجل دخولك للعيادة',
//                         style: TextStyle(
//                             fontSize: 32, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 20),
//                       LoginFormField(
//                         controller: emailController,
//                         hintText: 'البريد الإلكتروني',
//                         color: Colors.white,
//                         validate: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'رجاءً ادخل البريد الإلكتروني';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 25),
//                       LoginFormField(
//                         controller: passwordController,
//                         hintText: 'كلمة المرور',
//                         color: Colors.white,
//                         isPassword: true,
//                         validate: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'رجاءً ادخل كلمة المرور';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 100),
//                       LoginButtonWidget(onPressed: () {
//                         if (formKey.currentState!.validate()) {
//                           DrAidCubit.get(context).login(
//                             email: emailController.text,
//                             password: passwordController.text,
//                             context: context,
//                           );
//                           print("email: ${emailController.text}");
//                           print("password: ${passwordController.text}");
//                         } else {
//                           formKey.currentState!.save();
//                         }
//                       }),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


  // here is the more responsive :

// import 'package:draid/layout/cubit/cubit.dart';
// import 'package:draid/shared/components/components.dart';
// import 'package:draid/shared/styles/colors.dart';
// import 'package:flutter/material.dart';
//
// class Login extends StatelessWidget {
//   const Login({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth > 1200) {
//             // Desktop layout
//             return _buildDesktopLayout(context, formKey, emailController, passwordController);
//           } else if (constraints.maxWidth > 800) {
//             // Tablet layout
//             return _buildTabletLayout(context, formKey, emailController, passwordController);
//           } else {
//             // Mobile layout
//             return _buildMobileLayout(context, formKey, emailController, passwordController);
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildDesktopLayout(BuildContext context, GlobalKey<FormState> formKey,
//       TextEditingController emailController, TextEditingController passwordController) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             color: Colors.white,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'images/logo.gif',
//                   width: 300,
//                   height: 300,
//                 ),
//                 const Text(
//                   'Doctor Aid',
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             color: ColorManager.backgroundColor,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 200),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'مرحبا بك،',
//                       style: TextStyle(
//                           fontSize: 32, fontWeight: FontWeight.bold),
//                     ),
//                     const Text(
//                       'سجل دخولك للعيادة',
//                       style: TextStyle(
//                           fontSize: 32, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 20),
//                     LoginFormField(
//                       controller: emailController,
//                       hintText: 'البريد الإلكتروني',
//                       color: Colors.white,
//                       validate: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'رجاءً ادخل البريد الإلكتروني';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 25),
//                     LoginFormField(
//                       controller: passwordController,
//                       hintText: 'كلمة المرور',
//                       color: Colors.white,
//                       isPassword: true,
//                       validate: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'رجاءً ادخل كلمة المرور';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 100),
//                     LoginButtonWidget(onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         DrAidCubit.get(context).login(
//                           email: emailController.text,
//                           password: passwordController.text,
//                           context: context,
//                         );
//                         print("email: ${emailController.text}");
//                         print("password: ${passwordController.text}");
//                       } else {
//                         formKey.currentState!.save();
//                       }
//                     }),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTabletLayout(BuildContext context, GlobalKey<FormState> formKey,
//       TextEditingController emailController, TextEditingController passwordController) {
//     return Center(
//       child: Container(
//         width: 600,
//         color: ColorManager.backgroundColor,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'مرحبا بك،',
//                   style: TextStyle(
//                       fontSize: 32, fontWeight: FontWeight.bold),
//                 ),
//                 const Text(
//                   'سجل دخولك للعيادة',
//                   style: TextStyle(
//                       fontSize: 32, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 20),
//                 LoginFormField(
//                   controller: emailController,
//                   hintText: 'البريد الإلكتروني',
//                   color: Colors.white,
//                   validate: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'رجاءً ادخل البريد الإلكتروني';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 25),
//                 LoginFormField(
//                   controller: passwordController,
//                   hintText: 'كلمة المرور',
//                   color: Colors.white,
//                   isPassword: true,
//                   validate: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'رجاءً ادخل كلمة المرور';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 100),
//                 LoginButtonWidget(onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     DrAidCubit.get(context).login(
//                       email: emailController.text,
//                       password: passwordController.text,
//                       context: context,
//                     );
//                     print("email: ${emailController.text}");
//                     print("password: ${passwordController.text}");
//                   } else {
//                     formKey.currentState!.save();
//                   }
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout(BuildContext context, GlobalKey<FormState> formKey,
//       TextEditingController emailController, TextEditingController passwordController) {
//     return Center(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Center(
//                   child: Text(
//                     'مرحبا بك،',
//                     style: TextStyle(
//                         fontSize: 28, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const Center(
//                   child: Text(
//                     'سجل دخولك للعيادة',
//                     style: TextStyle(
//                         fontSize: 28, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 LoginFormField(
//                   controller: emailController,
//                   hintText: 'البريد الإلكتروني',
//                   color: Colors.white,
//                   validate: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'رجاءً ادخل البريد الإلكتروني';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 25),
//                 LoginFormField(
//                   controller: passwordController,
//                   hintText: 'كلمة المرور',
//                   color: Colors.white,
//                   isPassword: true,
//                   validate: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'رجاءً ادخل كلمة المرور';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 50),
//                 Center(
//                   child: LoginButtonWidget(onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       DrAidCubit.get(context).login(
//                         email: emailController.text,
//                         password: passwordController.text,
//                         context: context,
//                       );
//                       print("email: ${emailController.text}");
//                       print("password: ${passwordController.text}");
//                     } else {
//                       formKey.currentState!.save();
//                     }
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            // Desktop layout
            return _buildDesktopLayout(context, formKey, emailController, passwordController);
          } else if (constraints.maxWidth > 800) {
            // Tablet layout
            return _buildTabletLayout(context, formKey, emailController, passwordController);
          } else {
            // Mobile layout
            return _buildMobileLayout(context, formKey, emailController, passwordController);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, GlobalKey<FormState> formKey,
      TextEditingController emailController, TextEditingController passwordController) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/logo.gif',
                  width: 300,
                  height: 300,
                ),
                const Text(
                  'Doctor Aid',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: ColorManager.backgroundColor,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'مرحبا بك،',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'سجل دخولك للعيادة',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      LoginFormField(
                        controller: emailController,
                        hintText: 'البريد الإلكتروني',
                        color: Colors.white,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'رجاءً ادخل البريد الإلكتروني';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      LoginFormField(
                        controller: passwordController,
                        hintText: 'كلمة المرور',
                        color: Colors.white,
                        isPassword: true,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'رجاءً ادخل كلمة المرور';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 100),
                      LoginButtonWidget(onPressed: () {
                        if (formKey.currentState!.validate()) {
                          DrAidCubit.get(context).login(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context,
                          );
                          print("email: ${emailController.text}");
                          print("password: ${passwordController.text}");
                        } else {
                          formKey.currentState!.save();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context, GlobalKey<FormState> formKey,
      TextEditingController emailController, TextEditingController passwordController) {
    return Center(
      child: Container(
        width: 600,
        color: ColorManager.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'مرحبا بك،',
                    style: TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'سجل دخولك للعيادة',
                    style: TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  LoginFormField(
                    controller: emailController,
                    hintText: 'البريد الإلكتروني',
                    color: Colors.white,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'رجاءً ادخل البريد الإلكتروني';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  LoginFormField(
                    controller: passwordController,
                    hintText: 'كلمة المرور',
                    color: Colors.white,
                    isPassword: true,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'رجاءً ادخل كلمة المرور';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 100),
                  LoginButtonWidget(onPressed: () {
                    if (formKey.currentState!.validate()) {
                      DrAidCubit.get(context).login(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      );
                      print("email: ${emailController.text}");
                      print("password: ${passwordController.text}");
                    } else {
                      formKey.currentState!.save();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, GlobalKey<FormState> formKey,
      TextEditingController emailController, TextEditingController passwordController) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'مرحبا بك،',
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const Center(
                  child: Text(
                    'سجل دخولك للعيادة',
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                LoginFormField(
                  controller: emailController,
                  hintText: 'البريد الإلكتروني',
                  color: Colors.white,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رجاءً ادخل البريد الإلكتروني';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                LoginFormField(
                  controller: passwordController,
                  hintText: 'كلمة المرور',
                  color: Colors.white,
                  isPassword: true,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رجاءً ادخل كلمة المرور';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                Center(
                  child: LoginButtonWidget(onPressed: () {
                    if (formKey.currentState!.validate()) {
                      DrAidCubit.get(context).login(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      );
                      print("email: ${emailController.text}");
                      print("password: ${passwordController.text}");
                    } else {
                      formKey.currentState!.save();
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}