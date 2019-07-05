import 'package:flutter/material.dart';
import 'package:jh_flutter_provider/modules/account/bloc/user/index.dart';
import 'package:provider/provider.dart';
import '../services/routes.dart';

class CommonDrawer extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final UserBloc _userBloc = Provider.of<UserBloc>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: _listMenu(_userBloc,context),
      ),
    );
  }

  Widget _header(UserBloc _userBloc) => UserAccountsDrawerHeader(
        accountName: Text(
          _userBloc.userProfile.firstName,
        ),
        accountEmail: Text(
          _userBloc.userProfile.email,
        ),
        currentAccountPicture: CircleAvatar(
            // backgroundImage: ,
            ),
      );

  Widget _listTitle(String name, BuildContext context,String path) => ListTile(
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
        leading: Icon(
          Icons.person,
          color: Colors.blue,
        ),
        onTap: () => Navigator.pushReplacementNamed(context, Routes.userList),
      );

  _listMenu(UserBloc _userBloc,BuildContext context) {
    var list = <Widget>[];
    list.add(_header(_userBloc));
    list.add(_listTitle("Register", context,"/users"));
    list.add(_listTitle("User", context,"/users"));
    list.add(_listTitle("Dashboard", context,"/dashboard"));
    // kutilang-needle-add-drawer - Don't remove, used by kutilang to add new list
    list.add(_listTitle("Logout", context,"/login"));
    return list;
  }
}
