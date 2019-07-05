
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jh_flutter_provider/bloc/error/error_bloc.dart';

import '../../../../services/locator.dart';
import '../../../../services/navigation.dart';
import '../../../../services/routes.dart';
import '../../../../bloc/alert/index.dart';
import '../../../../modules/account/models/user_model.dart';
import '../../../../services/helper.dart';
import '../../../../services/network/connection.dart';
import '../../helper/account_helper.dart';
import '../../../../bloc/error/index.dart';


class UserBloc extends ChangeNotifier {

  ErrorBloc _errorBloc;

  User itemDetail;
 
  bool islistEmpty=true;
 
  bool isItemEmpty=true;
 
  User userProfile;
 
  bool isModified=false;
 
  List<User> userList ;
 
  int totalUser = 0;
 
  bool success = false;

  bool loading = false;
 
  int id;
 
  String username; 

  String firstname;

  String lastname;
 
  String email;
 
  String activated;
 
  String profile;

  // actions:-------------------------------------------------------------------
 
  void setUserId(int value) {
    id = value;
  }
 
  void setUsername(String value) {
    username = value;
  }

  void setFirstname(String value) {
    firstname = value;
  }
  
  void setLastname(String value) {
    lastname = value;
  }

  void setEmail(String value) {
    email = value;
  }
 
  void setActivated(String value) {
    activated = value;
  }
 
  void setProfile(String value) {
    profile = value;
  }

 
  setItemData(int data){
    isItemEmpty = false;
    itemDetail = userList[data];
  }

  int position=0;

  itemTapU(int _position){
    try{
   position = _position;
    itemDetail = userList[position];
    isItemEmpty = false;
  
    }catch(e){}
   // setItemData(userList[position]);
    //if(itemDetail != null)
      //isItemEmpty = false;

    locator<NavigationService>().navigateTo(Routes.userDetail);
  }
 
  itemTap(User data){
     locator<NavigationService>().navigateTo(Routes.userDetail);
      itemDetail = data;
  }

  add(){
    locator<NavigationService>().navigateTo(Routes.userForm);
  }
 
  save(){ print('----------------save');
    isModified =false;
    createUser(mapping());
    //dialogDelete();
    locator<NavigationService>().navigateTo(Routes.userList);
  }
 
  delete(String userid){
    dialogDelete();
    //isModified =true;
    deleteUser(userid);
    getUserList();
  }

  update(int id){
    dialogDelete();
  }
 
  Future getUserList() async{ 
    loading = true;
    success = true;
    islistEmpty = true;
    try{
      users().then((data)=> userList = data); 
    }catch(e){
        print(e.toString());
    }
    
    if(userList != null ){
      totalUser = userList.length;
      loading = false;
      islistEmpty = false;
     // _errorBloc.showError = true;
    } else {
      //_errorBloc.showError = true;
      //_errorBloc.errorMessage = 'Data Empty';
    }
   
  }

  getProfile() async {
    String profile = await restGet(API_ACCOUNT,true,false);
      setPrefs(PROFILE, profile);

      userProfile = User.fromJson(json.decode(profile));
      print('--${userProfile.email}--');
  }

  dialogDelete([String item]){
    //_alertStore.setTitleDialog('Delete');
    //_alertStore.setContentDialog('This item $item would be delete');
    print('----');
  }

   dialogUpdate([String item]){
   // _alertStore.setTitleDialog('Update');
    //_alertStore.setContentDialog('This item $item would be update');
  }

  mapping(){
    return User(
              //id: id,
              login: username,
              firstName: firstname,
              lastName: lastname,
              email: email,
              activated: true,
              createdBy: username,
              createdDate: instantToDate(DateTime.now()),
              langKey: "en",
              imageUrl: "",
              authorities: ['"ROLE_USER"'],
              lastModifiedBy: username,
              lastModifiedDate: instantToDate(DateTime.now())
              );
  }
}