
import 'package:draid/modules/responsive/dimensions.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
final Widget mobileBody;
final Widget desktopBody;
const ResponsiveLayout({super.key, required this.mobileBody,required this.desktopBody});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constriants){
          if(constriants.maxWidth<mobileWidth)
            {
            return  mobileBody;
            }
          else{
            return desktopBody;
          }
        }
    );
  }
}
