import 'package:flutter/material.dart';

class AppliSizes {
  static const int splashScreenTitleFontSize = 48;
  static const double titleFontSize = 60;
  static const double sidePadding = 15;
  static const double fontSizeTabBarTitle = 12;
  static const double fontSize = 15;
  static const double fontBigSize = 16.5;
  static const double fontSizeLittle = 13;
  static const double fontSizeVeryLittle = 10;
  static const double widgetSidePadding = 20;
  static const double buttonRadius = 10;
  static const double imageRadius = 8;
  static const double linePadding = 4;
  static const double widgetBorderRadius = 34;
  static const double textFieldRadius = 4;
  static const EdgeInsets bottomSheetPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 10);
  static const appBarSize = 20.0;
  static const appBarExpandedSize = 180.0;
  static const tileWidth = 148.0;
  static const tileHeight = 276.0;
}

class AppliColors {
  static const mybackground = Color.fromARGB(255, 5, 94, 150);
  static const main = Color(0xFF271664);
  static const red = Color(0xFFDB3022);
  static const yellow = Color(0xFFDBB022);
  static const lemon = Color(0xFFE5E500);
  static const orange = Color(0xfffeb84f);
  static const blue = Color(0xFF22a8c2);
  static const grey = Color(0xFF808080);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFFD5D5D5);
  static const darkGray = Color(0xFF979797);
  static const white = Color(0xFFFFFFFF);
  static const background = Color(0xFFE5E5E5);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const green = Color(0xFF2AA952);
  static const beige = Color(0xFFF5F5DC);
  static const brown = Color(0xFF8B4513);
  static const pink = Color(0xFFFFC0CB);
  static const purple = Color(0xFFEE82EE);
}

class AppConsts {
  static const pageSize = 20;
  static const durationSnackbar = 3;
}

class ColorConstants {
  static const Map<String, int> colorMapping = {
    'rouge': 0xFFDB3022,
    'bleu': 0xFF22a8c2,
    'noir': 0xFF222222,
    'vert': 0xFF2AA952,
    'jaune': 0xFFDBB022,
    'gris': 0xFF808080,
    'beige': 0xFFF5F5DC,
    'marron': 0xFF8B4513,
    'orange': 0xfffeb84f,
    'rose': 0xFFFFC0CB,
    'violet': 0xFFEE82EE,
  };

  static const Map<String, String> imageMapping = {
    'multicolore': 'assets/multicolore.png',
  };
}

// class AppliTontineTheme {
//   static ThemeData of(context) {
//     final theme = Theme.of(context);
//     return theme.copyWith(
//       primaryColor: AppliColors.main,
//       primaryColorLight: AppliColors.lightGray,
//       dialogBackgroundColor: AppliColors.backgroundLight,
//       dividerColor: Colors.transparent,
//       appBarTheme: theme.appBarTheme.copyWith(
//           color: AppliColors.white,
//           iconTheme: const IconThemeData(color: AppliColors.black),
//           toolbarTextStyle: theme.textTheme
//               .copyWith(
//               bodySmall: const TextStyle(
//                 color: AppliColors.black,
//                 fontSize: 18,
//                 fontFamily: 'Metropolis',
//                 fontWeight: FontWeight.w400,
//               ))
//               .bodyMedium,
//           titleTextStyle: theme.textTheme
//               .copyWith(
//               bodySmall: const TextStyle(
//                 color: AppliColors.black,
//                 fontSize: 18,
//                 fontFamily: 'Metropolis',
//                 fontWeight: FontWeight.w400,
//               ))
//               .titleLarge),
//       textTheme: theme.textTheme
//           .copyWith(
//         //over image white text
//         headlineSmall: theme.textTheme.headlineSmall?.copyWith(
//           fontSize: 48,
//           color: AppliColors.white,
//           fontFamily: 'Metropolis',
//           fontWeight: FontWeight.w900,
//         ),
//         titleLarge: theme.textTheme.titleLarge?.copyWith(
//           fontSize: 24,
//           color: AppliColors.black,
//           fontWeight: FontWeight.w900,
//           fontFamily: 'Metropolis',
//         ),
//         //
//
//         //product title
//         headlineMedium: theme.textTheme.headlineMedium?.copyWith(
//           color: AppliColors.black,
//           fontSize: 16,
//           fontWeight: FontWeight.w400,
//           fontFamily: 'Metropolis',
//         ),
//
//         displaySmall: theme.textTheme.displaySmall?.copyWith(
//           fontFamily: 'Metropolis',
//           fontWeight: FontWeight.w400,
//         ),
//         //product price
//         displayMedium: theme.textTheme.displayMedium?.copyWith(
//           color: AppliColors.lightGray,
//           fontSize: 14,
//           fontFamily: 'Metropolis',
//           fontWeight: FontWeight.w400,
//         ),
//         displayLarge: theme.textTheme.displayLarge?.copyWith(
//           fontFamily: 'Metropolis',
//           fontWeight: FontWeight.w500,
//         ),
//
//         titleSmall: theme.textTheme.titleSmall?.copyWith(
//           fontSize: 18,
//           color: AppliColors.black,
//           fontFamily: 'Metropolis',
//           fontWeight: FontWeight.w400,
//         ),
//
//         titleMedium: theme.textTheme.titleMedium?.copyWith(
//           fontSize: 24,
//           color: AppliColors.darkGray,
//           fontFamily: 'Metropolis',
//           fontWeight: FontWeight.w500,
//         ),
//         //red button with white text
//         labelLarge: theme.textTheme.labelLarge?.copyWith(
//           fontSize: 14,
//           color: AppliColors.white,
//           fontFamily: 'Metropolis',
//           fontWeight: FontWeight.w500,
//         ),
//         //black caption title
//         bodySmall: theme.textTheme.bodySmall?.copyWith(
//           fontSize: 34,
//           color: AppliColors.black,
//           fontFamily: 'Metropolis',
//           fontWeight: FontWeight.w700,
//         ),
//         //light gray small text
//         bodyLarge: theme.textTheme.bodyLarge?.copyWith(
//           color: AppliColors.lightGray,
//           fontSize: 15,
//           fontFamily: 'Metropolis',
//           fontWeight: FontWeight.w400,
//         ),
//         //view all link
//         bodyMedium: theme.textTheme.bodyMedium?.copyWith(
//           color: AppliColors.black,
//           fontSize: 11,
//           fontFamily: 'Metropolis',
//           fontWeight: FontWeight.w400,
//         ),
//       )
//           .apply(fontFamily: 'Metropolis'),
//       buttonTheme: theme.buttonTheme.copyWith(
//         minWidth: 50,
//         buttonColor: AppliColors.red,
//       ), bottomAppBarTheme: const BottomAppBarTheme(color: AppliColors.lightGray), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppliColors.main).copyWith(background: AppliColors.background).copyWith(error: AppliColors.red),
//     );
//   }
// }
