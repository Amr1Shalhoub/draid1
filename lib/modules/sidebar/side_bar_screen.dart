import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/components/components.dart';
import 'package:draid/shared/components/constants.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';

// class SideBarScreen extends StatefulWidget {
//   const SideBarScreen({super.key});
//
//   @override
//   State<SideBarScreen> createState() => _SideBarScreenState();
// }
//
// class _SideBarScreenState extends State<SideBarScreen> {
//   int index = 0;
//   bool isExpanded = true;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Column(
//           children: [
//             Flexible(
//               fit: FlexFit.loose,
//               child: NavigationRail(
//                 extended: isExpanded,
//                 backgroundColor: Colors.white,
//                 unselectedIconTheme:
//                     const IconThemeData(color: Colors.grey, opacity: 1),
//                 unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
//                 selectedIconTheme: IconThemeData(color: Colors.blue.shade400),
//                 selectedLabelTextStyle: TextStyle(color: Colors.blue.shade400),
//                 destinations: const [
//                   NavigationRailDestination(
//                       icon: SvgIcon(
//                         icon: SvgIconData(
//                           'images/vector.svg',
//                         ),
//                         size: 20,
//                       ),
//                       label: Text('الرئيسية')),
//                   NavigationRailDestination(
//                     icon: SvgIcon(
//                       icon: SvgIconData(
//                         'images/person.svg',
//                       ),
//                       size: 20,
//                     ),
//                     label: Text('الأطباء'),
//                   ),
//                   NavigationRailDestination(
//                     icon: Icon(Icons.settings),
//                     label: Text('الإعدادات'),
//                   ),
//                   NavigationRailDestination(
//                     icon: SvgIcon(
//                       icon: SvgIconData(
//                         'images/message.svg',
//                       ),
//                       size: 20,
//                     ),
//                     label: Text('الرسائل'),
//                   ),
//                 ],
//                 selectedIndex: index,
//                 onDestinationSelected: (index) => setState(() {
//                   this.index = index;
//                 }),
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }


class SideBarScreen extends StatefulWidget {
  const SideBarScreen({super.key});

  @override
  State<SideBarScreen> createState() => _SideBarScreenState();
}

class _SideBarScreenState extends State<SideBarScreen> {
  int index = 0;
  int _selectedIndex=0;


  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Execute different functions based on the selected index
    switch (index) {
      case 0:
        _onHomeSelected();
        break;
      case 1:
        _onDoctorsSelected();
        break;
      case 2:
        _onSettingsSelected();
        break;
      case 3:
        _onAddEmployee();
        break;
    }
  }
  void _onHomeSelected() {

    // Your logic for when the "الرئيسية" (Home) destination is selected
    print("Home icon clicked");
  }

  void _onDoctorsSelected() {
    // Your logic for when the "الأطباء" (Doctors) destination is selected
    print("Doctors icon clicked");
  }

  void _onSettingsSelected() {
    changeSettings(context);
    // Your logic for when the "الإعدادات" (Settings) destination is selected
    print("Settings icon clicked");
  }
  void _onAddEmployee() {
    //changeSettings(context);
    addEmployee(context);
    // Your logic for when the "الإعدادات" (Settings) destination is selected
    print("Settings icon clicked");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DrAidCubit,DrAidStates>(
      listener: (context,state){

      },
      builder: (context,state){
        return LayoutBuilder(
          builder: (context, constraints) {
            bool isExpanded = constraints.maxWidth > 600;
            return Builder(
                builder: (context) {
                  if(modee=='light'&&languagee=='arabic')
                    return NavigationRail(
                      extended: isExpanded,
                      backgroundColor: Colors.white,
                      unselectedIconTheme: const IconThemeData(color: Colors.grey, opacity: 1),
                      unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
                      selectedIconTheme: IconThemeData(color: Colors.blue.shade400),
                      selectedLabelTextStyle: TextStyle(color: Colors.blue.shade400),
                      destinations:  [
                        NavigationRailDestination(
                          icon: SvgIcon(
                            icon: SvgIconData('images/vector.svg'),
                            size: 20,
                          ),
                          label: Text('الرئيسية'),

                        ),
                        NavigationRailDestination(
                          icon: SvgIcon(
                            icon: SvgIconData('images/person.svg'),
                            size: 20,
                          ),
                          label: Text('الأطباء'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.settings),
                          label: Text('الإعدادات'),
                        ),
                        if(roleFromBackend=='admin'||roleFromBackend=='doctor')
                        NavigationRailDestination(
                          icon: Icon(Icons.person_add_sharp),
                          label: Text('الموظفين'),
                        ),
                        // NavigationRailDestination(
                        //   icon: SvgIcon(
                        //     icon: SvgIconData('images/message.svg'),
                        //     size: 20,
                        //   ),
                        //   label: Text('الرسائل'),
                        // ),
                      ],
                      selectedIndex:_selectedIndex,
                      onDestinationSelected: _onDestinationSelected,
                      //index,
                      // onDestinationSelected: (index) => setState(() {
                      //   this.index = index;
                      //
                      // }),
                    );
                  else if(modee=='dark'&&languagee=='arabic'){
                    return NavigationRail(
                      extended: isExpanded,
                      backgroundColor: DarkModeColors.cardBackground,
                      unselectedIconTheme: const IconThemeData(color: Colors.orangeAccent, opacity: 1),
                      unselectedLabelTextStyle: const TextStyle(color: Colors.orangeAccent),
                      selectedIconTheme: IconThemeData(color: Colors.orange.shade900),
                      selectedLabelTextStyle: TextStyle(color: Colors.orange.shade900),
                      destinations:  [
                        NavigationRailDestination(
                          icon: SvgIcon(
                            icon: SvgIconData('images/vector.svg'),
                            size: 20,
                          ),
                          label: Text('الرئيسية'),
                        ),
                        NavigationRailDestination(
                          icon: SvgIcon(
                            icon: SvgIconData('images/person.svg'),
                            size: 20,
                          ),
                          label: Text('الأطباء'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.settings),
                          label: Text('الإعدادات'),
                        ),
                        if(roleFromBackend=='admin'||roleFromBackend=='doctor')
                          NavigationRailDestination(
                            icon: Icon(Icons.person_add_sharp),
                            label: Text('الموظفين'),
                          ),
                        // NavigationRailDestination(
                        //   icon: SvgIcon(
                        //     icon: SvgIconData('images/message.svg'),
                        //     size: 20,
                        //   ),
                        //   label: Text('الرسائل'),
                        // ),
                      ],
                      selectedIndex:_selectedIndex,
                      onDestinationSelected: _onDestinationSelected,
                      // selectedIndex: index,
                      // onDestinationSelected: (index) => setState(() {
                      //   this.index = index;
                      //
                      // }
                      // ),
                    );
                  }
                  else if(modee=='light'&&languagee=='english'){
                    return NavigationRail(
                      extended: isExpanded,
                      backgroundColor: Colors.white,
                      unselectedIconTheme: const IconThemeData(color: Colors.grey, opacity: 1),
                      unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
                      selectedIconTheme: IconThemeData(color: Colors.blue.shade400),
                      selectedLabelTextStyle: TextStyle(color: Colors.blue.shade400),
                      destinations:  [
                        NavigationRailDestination(
                          icon: SvgIcon(
                            icon: SvgIconData('images/vector.svg'),
                            size: 20,
                          ),
                          label: Text('Main'),
                        ),
                        NavigationRailDestination(
                          icon: SvgIcon(
                            icon: SvgIconData('images/person.svg'),
                            size: 20,
                          ),
                          label: Text('Doctors'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.settings),
                          label: Text('Settings'),
                        ),
                        if(roleFromBackend=='admin'||roleFromBackend=='doctor')
                          NavigationRailDestination(
                            icon: Icon(Icons.person_add_sharp),
                            label: Text('Employees'),
                          ),
                        // NavigationRailDestination(
                        //   icon: SvgIcon(
                        //     icon: SvgIconData('images/message.svg'),
                        //     size: 20,
                        //   ),
                        //   label: Text('Messages'),
                        // ),
                      ],
                      selectedIndex:_selectedIndex,
                      onDestinationSelected: _onDestinationSelected,
                      // selectedIndex: index,
                      // onDestinationSelected: (index) => setState(() {
                      //   this.index = index;
                      // }),
                    );
                  }
                  else if(modee=='dark'&&languagee=='english'){
                    return NavigationRail(
                      extended: isExpanded,
                      backgroundColor: DarkModeColors.cardBackground,
                      unselectedIconTheme: const IconThemeData(color: Colors.orangeAccent, opacity: 1),
                      unselectedLabelTextStyle: const TextStyle(color: Colors.orangeAccent),
                      selectedIconTheme: IconThemeData(color: Colors.orange.shade900),
                      selectedLabelTextStyle: TextStyle(color: Colors.orange.shade900),
                      destinations:  [
                        NavigationRailDestination(
                          icon: SvgIcon(
                            icon: SvgIconData('images/vector.svg'),
                            size: 20,
                          ),
                          label: Text('Main'),
                        ),
                        NavigationRailDestination(
                          icon: SvgIcon(
                            icon: SvgIconData('images/person.svg'),
                            size: 20,
                          ),
                          label: Text('Doctors'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.settings),
                          label: Text('Settings'),
                        ),
                        if(roleFromBackend=='admin'||roleFromBackend=='doctor')
                          NavigationRailDestination(
                            icon: Icon(Icons.person_add_sharp),
                            label: Text('Employees'),
                          ),
                        // NavigationRailDestination(
                        //   icon: SvgIcon(
                        //     icon: SvgIconData('images/message.svg'),
                        //     size: 20,
                        //   ),
                        //   label: Text('Messages'),
                        // ),
                      ],
                      selectedIndex:_selectedIndex,
                      onDestinationSelected: _onDestinationSelected,
                      // selectedIndex: index,
                      // onDestinationSelected: (index) => setState(() {
                      //   this.index = index;
                      // }),
                    );
                  }
                  else{
                    return SizedBox(height: 10,);
                  }
                }
            );
          },
        );
      },

    );


  }
}
