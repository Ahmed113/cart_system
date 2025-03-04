import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class FontWeightManager{
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSize{
  static double s12 = 12.sp;
  static double s14 = 14.sp;
  static double s16 = 16.sp;
  static double s17 = 17.sp;
  static double s18 = 18.sp;
  static double s20 = 20.sp;
  static double s22 = 22.sp;
  static double s32 = 32.sp;
}

class TextStyleManager{
  static TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color){
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color
    );
  }
  static TextStyle getLightStyle({required double fontSize, required Color color}){
    return _getTextStyle(fontSize, FontWeightManager.light, color);
  }

  static TextStyle getRegularStyle({double fontSize = 12, required Color color}){
    return _getTextStyle(fontSize, FontWeightManager.regular, color);
  }

  static TextStyle getMediumStyle({required double fontSize, required Color color}){
    return _getTextStyle(fontSize, FontWeightManager.medium, color);
  }

  static TextStyle getSemiBoldStyle({required double fontSize, required Color color}){
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }

  static TextStyle getBoldStyle({required double fontSize, required Color color}){
    return _getTextStyle(fontSize, FontWeightManager.bold, color);
  }
}