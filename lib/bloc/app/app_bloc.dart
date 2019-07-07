import 'package:flutter/material.dart';
import 'package:jh_flutter_provider/themes/index.dart';



class AppBloc extends ChangeNotifier {
  bool isLocale = true;

  ThemeData get theme => isLightTheme? LightTheme.buildTheme():DarkTheme.buildTheme() ;

  bool get wtheme => isLightTheme? true:false ;
 
  bool isLightTheme = true;

  Locale get locale => Locale('en', '');
 
  switchToDark(){
    isLightTheme = true;
    // print('$theme Light $isLightTheme');
  }
 
  switchToLight(){
    isLightTheme = true;
    // print('$wtheme Light $isLightTheme');
  }
}