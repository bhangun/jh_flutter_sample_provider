import 'package:flutter/material.dart';
import 'package:jh_flutter_provider/themes/index.dart';



class AppBloc extends ChangeNotifier {

/* set app() {
    //_counter = val;//
    notifyListeners();
  }
 */
  ThemeData get theme => isLightTheme? LightTheme.buildTheme():DarkTheme.buildTheme() ;

   
  bool get wtheme => isLightTheme? true:false ;

 
  bool isLightTheme = true;


  void count(bool b){
    // print('>>>>>>>>>>>>>>>>$b');
  }

 
  switchToDark(){
    isLightTheme = true;
    // print('$theme Light $isLightTheme');
  }

 
  switchToLight(){
    isLightTheme = true;
    // print('$wtheme Light $isLightTheme');
  }
}