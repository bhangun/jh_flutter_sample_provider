import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/config.dart';
import '../../../../services/helper.dart';
import '../../../../services/locator.dart';
import '../../../../services/navigation.dart';
import '../../../../services/network/connection.dart';
import '../../../../services/routes.dart';
import '../../../../services/sharedpref/preferences.dart';
import '../../../../bloc/error/index.dart';
import '../user/index.dart';



class AuthenticationBloc extends ChangeNotifier {

  ErrorBloc _errorBloc = ErrorBloc();

  UserBloc userStore ;

  String userEmail = ''; 

  String password = '';
  
  String confirmPassword = '';
  
  bool success = false;
  
  bool loggedIn = false;

  bool loading = false;

  bool rememberMe = false;
 
  bool get canLogin => hasErrorsInLogin ;//&& userEmail !='' && password !='';
 
  bool get canRegister =>
      !hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

 
  bool get canForgetPassword => !hasErrorInForgotPassword && userEmail.isNotEmpty;
  
  // error handling:-------------------------------------------------------------------
 
  bool get hasErrorsInLogin => userEmail != '' || password != '';

 
  bool get hasErrorsInRegister =>
      userEmail != null || password != null || confirmPassword != null;

 
  bool get hasErrorInForgotPassword => userEmail != null;

  // actions:-------------------------------------------------------------------
 
  void setUserId(String value) {
    print('$canLogin  >>>>>>> $value ');
    userEmail = value;
    validateUserEmail(value);
  }

 
  void setPassword(String value) {
    password = value;
    validatePassword(value);
  }

 
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

 
  void validateUserEmail(String value) {
    // Regex for email validation
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
    
    RegExp regExp = new RegExp(p);

    if (value.isEmpty) {
      userEmail = "Email can't be empty";
    } else if (regExp.hasMatch(value)) {
      userEmail = null;
    }
    /* else if (!isEmail(value)) {
      userEmail = 'Please enter a valid email address';
    } */ else {
      userEmail = null;
    }
    
    // errorStore.showError = true;
    // errorStore.errorMessage = 'Email provided isn\'t valid.Try another email address';
    
  }

 
  void validatePassword(String value) {
    if (value.isEmpty) {
      password = "Password can't be empty";
    } /* else if (value.length < 6) {
      password = "Password must be at-least 6 characters long";
    }  */else {
      password = null;
    }
  }

 
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      confirmPassword = "Password doen't match";
    } else {
      confirmPassword = null;
    }
  }

 
  Future register() async {
    loading = true;
  }


 
  login(String _username,String _password,[bool _rememberMe=false]) async {
    loading = true;
    success = false;
    _errorBloc.errorMessage = 'bismillah';
   try {
      
      var body = jsonEncode({"username": _username, "password": _password, "rememberMe": _rememberMe});
      
      final response = await restPost("authenticate", body);
      setPrefs(TOKEN, json.decode(response)["id_token"]);

      //SharedPreferences.getInstance().then((prefs) {
      // SharedPreferences.getInstance().then((p)=>p.setBool(Preferences.is_logged_in, true));
       // prefs.setBool(Preferences.is_logged_in, true);
      //});  

      loading = false;
      loggedIn = true;
      success = true;
      //errorStore.showError = false;
      locator<NavigationService>().navigateTo('/home');
    } catch (e){
      loading = false;
      success = false;
     /*  errorStore.showError = true;
      errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Username and password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
      print(e); */
    }
  }


  navigate(BuildContext context){
      return 
       Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false); 
  }

 
  Future forgotPassword() async {
    loading = true;
  }

 
  Future logout() async {
    SharedPreferences.getInstance().then((preference) {
              preference.setBool(Preferences.is_logged_in, false);
    });
    loading = true;
  }

  // general methods:-----------------------------------------------------------
 

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
  }
}
