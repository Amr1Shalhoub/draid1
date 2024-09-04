
import 'package:draid/modules/responsive/desktop_body.dart';
import 'package:draid/modules/responsive/mobile_body.dart';
import 'package:draid/modules/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

class ResponsiveDesignScreen extends StatelessWidget {
  const ResponsiveDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(mobileBody: MyMobileBody(), desktopBody: MyDesktopBody());
  }
}
