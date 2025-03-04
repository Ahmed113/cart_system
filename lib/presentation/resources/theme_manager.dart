import 'package:cart_system/presentation/resources/colors_manager.dart';
import 'package:cart_system/presentation/resources/fonts_manager.dart';
import 'package:cart_system/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getAppTheme(){
  return ThemeData(
    primaryColor: ColorsManager.primary,
      splashColor: Colors.transparent,
      // highlightColor: Colors.transparent,
      // hoverColor: Colors.transparent,

    /// card theme
    cardTheme: CardTheme(
      color: ColorsManager.primary,
      shadowColor: ColorsManager.grey,
      elevation: AppSizes.s4,
    ),

    /// bottom nav theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorsManager.primary,
      elevation: AppSizes.s4,
      selectedItemColor: ColorsManager.secondary,
      unselectedItemColor: ColorsManager.grey,
      landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      unselectedLabelStyle: TextStyleManager.getSemiBoldStyle(fontSize: FontSize.s16, color: ColorsManager.grey),
      selectedLabelStyle: TextStyleManager.getSemiBoldStyle(fontSize: FontSize.s16, color: ColorsManager.grey),
    ),

    textTheme: TextTheme(
      bodySmall: TextStyleManager.getSemiBoldStyle(fontSize: FontSize.s12, color: ColorsManager.darkGrey),
      bodyMedium: TextStyleManager.getSemiBoldStyle(fontSize: FontSize.s18, color: ColorsManager.darkGrey),
      bodyLarge: TextStyleManager.getSemiBoldStyle(fontSize: FontSize.s22, color: ColorsManager.darkGrey),
      titleSmall: TextStyleManager.getSemiBoldStyle(fontSize: FontSize.s14, color: ColorsManager.darkGrey),
      titleMedium: TextStyleManager.getMediumStyle(fontSize: FontSize.s16, color: ColorsManager.darkGrey),
      titleLarge: TextStyleManager.getMediumStyle(fontSize: FontSize.s18, color: ColorsManager.darkGrey),
      labelMedium: TextStyleManager.getBoldStyle(fontSize: FontSize.s16, color: ColorsManager.darkGrey),
    )
  );
}