import 'package:draid/shared/components/constants.dart';
import 'package:flutter/material.dart';

class ColorManager {
  static Color buttonColor = const Color(0xff3485f7);
  static Color backgroundColor = const Color(0xfff8f9fd);
  static Color greyColor = const Color(0xff666973);
  static Color babyGreyColor = const Color(0xffe3ebee);
  static Color borderGreyColor = const Color(0xffdddddd);
  static Color greenColor = const Color(0xff2cc56f);
  static Color coolGreen = const Color(0xff9ad3b0);
  static Color fontColor = const Color(0xff7d7d7d);
  static Color coolWhite = const Color(0xfffafae6);
  static Color coolWhite2 = const Color(0xfff8f9fd);
  static Color coolBlue = const Color(0xff8aaef3);
  static Color textFieldBorderColor = const Color(0xffC3C3C3);
  static Color fontColor2 = const Color(0xffAAAAAA);
  static Color fontColor3 = const Color(0xff6ba4ff);
  static Color numberBackGroundColor = const Color(0xffEBEBFF);
  static Color borderColor = const Color(0xffc3c3c3);
  static Color linearGradiant2 = const Color(0xffA3C6FE);
}




class ColorManager2 {
  // Define the colors as static variables
  static const Color coolBlue = Color.fromRGBO(138, 174, 243, 1);
  static const Color coolGreen = Color.fromRGBO(154, 211, 176, 1);
  static const Color coolWhite = Color.fromRGBO(250, 250, 230, 1);
  static var coolWhite2 = Color.fromRGBO(248, 249, 253, 1);
  static const Color textFieldBorderColor = Color.fromRGBO(195, 195, 195, 1);
  static const Color buttonColor = Color.fromRGBO(52, 133, 247, 1);
  static const Color fontColor = Color.fromRGBO(125, 125, 125, 1);
  static const Color fontColor2 = Color.fromRGBO(170, 170, 170, 1);
  static const Color fontColor3 = Color.fromRGBO(125, 125, 125, 1);
  static const Color fontColor4 = Color.fromRGBO(107, 164, 255, 1);
  static const Color numberBackGroundColor = Color.fromRGBO(235, 235, 255, 1);
  static const Color borderColor = Color.fromRGBO(195, 195, 195, 1);
  static const Color linearGradiant1 = Color.fromRGBO(77, 145, 255, 1);
  static const Color linearGradiant2 = Color.fromRGBO(164, 199, 255, 1);
  static const Color coolGreen1 = Color.fromRGBO(148, 203, 105, 1);
  static const Color coolOrange = Color.fromRGBO(242, 201, 56, 1);
  static const Color coolBorderColor = Color.fromRGBO(126, 199, 250, 1);
  static const Color simpleDialogTitleColor = Color.fromRGBO(84, 84, 85, 1);
  static const Color blueText = Color.fromRGBO(33, 129, 196, 1);
  static const Color circulerAvatarColor = Color.fromRGBO(108, 163, 253, 1);
  static const Color dividerColor = Color.fromRGBO(115, 115, 115, 1);
  static  Color datePickerColor = Color.fromRGBO(235, 235, 255, 1);
  static Color blueee=Colors.blue;
  static const Color white = Colors.white;

  // Method to change colors based on mode
  static void changeColorsAccordingToMode(String mode) {
    if (mode == 'light') {
      coolWhite2 = Color.fromRGBO(248, 249, 253, 1);
    } else if (mode == 'dark') {
      coolWhite2 = Colors.black26;
      datePickerColor=Colors.yellow;
      blueee=Colors.orange;

    }
  }
}



class DarkModeColors {
  static const Color background = Color(0xFF121212);
  static const Color cardBackground = Color(0xFF1C1C1C);
  static const Color primaryText = Color(0xFFE0E0E0);
  static const Color secondaryText = Color(0xFFB0B0B0);
  static const Color disabledText = Color(0xFF707070);
  static const Color errorText = Color(0xFFCF6679);
  static const Color primaryButtonBackground = Color(0xFF1E88E5);
  static const Color secondaryButtonBackground = Color(0xFF3C4043);
  static const Color buttonText = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFF383838);
  static const Color accent = Color(0xFF03DAC6);
  static const Color icon = Color(0xFFE0E0E0);
}





const coolBlue = Color.fromRGBO(138, 174, 243, 1);
const coolGreen = Color.fromRGBO(154, 211, 176, 1);
const coolWhite = Color.fromRGBO(250, 250, 230, 1);
var coolWhite2 = Color.fromRGBO(248, 249, 253, 1);
const textFieldBorderColor = Color.fromRGBO(195, 195, 195, 1);
const buttonColor = Color.fromRGBO(52, 133, 247, 1);
const fontColor = Color.fromRGBO(125, 125, 125, 1);
const fontColor2 = Color.fromRGBO(170, 170, 170, 1);
const fontColor3 = Color.fromRGBO(125, 125, 125, 1);
const fontColor4 = Color.fromRGBO(107, 164, 255, 1);
const numberBackGroundColor = Color.fromRGBO(235, 235, 255, 1);
const borderColor = Color.fromRGBO(195, 195, 195, 1);
const linearGradiant1 = Color.fromRGBO(77, 145, 255, 1);
const linearGradiant2 = Color.fromRGBO(164, 199, 255, 1);
const coolGreen1 = Color.fromRGBO(148, 203, 105, 1);
const coolOrange = Color.fromRGBO(242, 201, 56, 1);
const coolBorderColor = Color.fromRGBO(126, 199, 250, 1);
const simpleDialogTitleColor = Color.fromRGBO(84, 84, 85, 1);
const blueText = Color.fromRGBO(33, 129, 196, 1);
const circulerAvatarColor = Color.fromRGBO(108, 163, 253, 1);
const dividerColor = Color.fromRGBO(115, 115, 115, 1);
const datePickerColor = Color.fromRGBO(235, 235, 255, 1);
const white = Colors.white;


void changeColorsAccordingToMode(){
  if(modee=='')
    {
      coolWhite2 = Color.fromRGBO(248, 249, 253, 1);
    }
  if(modee=='light')
    {
       coolWhite2 = Color.fromRGBO(248, 249, 253, 1);


    }
  else if(modee=='dark')
    {
       coolWhite2 = Colors.black87;
    }
}
//const coolBlue = Color.fromRGBO(146, 196, 221, 1);
