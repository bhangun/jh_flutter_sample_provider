import 'package:flutter/material.dart';

import 'material_theme_colors.dart';

class ThemeService {
/* const ThemeService._(this.name, this.data);

  final String name;
  final ThemeData data;
} */

/* final ThemeService kDarkTheme = ThemeService._('Dark', _buildDarkTheme());
final ThemeService kLightTheme = ThemeService._('Light', _buildLightTheme());
 */

  ThemeData darkTheme(){
    return buildTheme();
  }

  ThemeData lightTheme(){
    return lbuildTheme();
  }


  ThemeData lbuildTheme() {
  print('terang');
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: MatThemeColors.blue[800],
    primaryColor: MatThemeColors.blue[500],
    buttonColor: MatThemeColors.blue[200],
    scaffoldBackgroundColor: MatThemeColors.blue[50],
    cardColor: MatThemeColors.blue[50],
    textSelectionColor: MatThemeColors.blue[200],
    errorColor: MatThemeColors.deepPurple[200],
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
    ),
    primaryIconTheme: base.iconTheme.copyWith(
        color: MatThemeColors.deepPurple[100]
    ),
    textTheme: _lbuildTextTheme(base.textTheme),
    primaryTextTheme: _lbuildTextTheme(base.primaryTextTheme),
    accentTextTheme: _lbuildTextTheme(base.accentTextTheme),
  );
}

 TextTheme _lbuildTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
        fontSize: 18.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    body2: base.body2.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
  ).apply(
    // fontFamily: 'ProductSans',
    displayColor: MatThemeColors.blue,
    bodyColor: MatThemeColors.black,
  );
}

ThemeData buildTheme() {
   print('gelap');
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor:  MatThemeColors.grey,
    buttonColor: MatThemeColors.grey,
    scaffoldBackgroundColor: MatThemeColors.grey[900],
    cardColor: MatThemeColors.grey,
    textSelectionColor: MatThemeColors.grey,
    errorColor: MatThemeColors.amber[300],
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
    ),
    primaryIconTheme: base.iconTheme.copyWith(
        color: MatThemeColors.grey
    ),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

 TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
        fontSize: 18.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    body2: base.body2.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),
  ).apply(
    // fontFamily: 'ProductSans',
    displayColor: MatThemeColors.amber[900],
    bodyColor: MatThemeColors.amber[100],
  );
}


ThemeData _buildDarkTheme() {
  const Color primaryColor = Color(0xFF0175c2);
  const Color secondaryColor = Color(0xFF13B9FD);
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    primaryColor: primaryColor,
    primaryColorDark: const Color(0xFF0050a0),
    primaryColorLight: secondaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: const Color(0xFF6997DF),
    accentColor: secondaryColor,
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    backgroundColor: const Color(0xFF202124),
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

ThemeData _buildLightTheme() {
  const Color primaryColor = Color(0xFF0175c2);
  const Color secondaryColor = Color(0xFF13B9FD);
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: const Color(0xFF1E88E5),
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: secondaryColor,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
  }
}