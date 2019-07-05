import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../bloc/error/index.dart';

import '../../../widgets/alert_widget.dart';
import '../bloc/user/index.dart';
import '../../../widgets/global_methods.dart';
import '../../../widgets/progress_indicator_widget.dart';
import '../models/user_model.dart';


class UserForm extends StatefulWidget {
  final User data;
  final bool isEdit = false;
  UserForm({this.data});
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  bool _activated = false;
  final _username = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _email = TextEditingController();


@override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _firstname.dispose();
    _lastname.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc _userBloc = Provider.of<UserBloc>(context);

_username.addListener(() {
      _userBloc.setUsername(_username.text);
    });

    _firstname.addListener(() {
      _userBloc.setFirstname(_firstname.text);
    });

    _lastname.addListener(() {
      _userBloc.setLastname(_lastname.text);
    });

    _email.addListener(() {
      _userBloc.setEmail(_email.text);
    });


     if (widget.data != null) {
     // widget.isEdit = true;
      User user = widget.data;

      _username.text = user.login;
      _firstname.text = user.firstName;
      _lastname.text = user.lastName;
      _email.text = user.email;
    }

    return MultiProvider(providers: [
      ChangeNotifierProvider(builder: (_) => UserBloc())
    ], child: Scaffold(
        appBar: AppBar(
          title: Text('Create User'),
        ),
        body: _buildBody(_userBloc),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=> _userBloc.save(),
          tooltip: 'Add',
          child: Icon(Icons.save),
        ))
    );
  }

  _buildBody(UserBloc _userBloc) {
    return Stack(
      children: <Widget>[
         _userBloc.loading
                ? CustomProgressIndicatorWidget()
                : Material(child: _buildForm(_userBloc))
          ,
        _userBloc.success
                ? Container()
                : showErrorMessage(context, '')//_errorBloc.errorMessage)
          ,
        _userBloc.isModified ? KutAlert():Container()
          ,
      ],
    );
  }

  _buildForm(UserBloc _userBloc){
    return SafeArea(
                child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: _buildListChild(_userBloc))
          );
  }

  _buildListChild(UserBloc _userBloc) {
    return <Widget>[
      SizedBox(height: 120.0),
      TextField(
        controller: _username,
        decoration: InputDecoration(
          filled: true,
          labelText: 'Login',
        ),
      ),
      TextField(
        controller: _firstname,
        decoration: InputDecoration(
          filled: true,
          labelText: 'First Name',
        ),
      ),
      TextField(
        controller: _lastname,
        decoration: InputDecoration(
          filled: true,
          labelText: 'Last Name',
        ),
      ),
      TextField(
        controller: _email,
        decoration: InputDecoration(
          filled: true,
          labelText: 'Email',
        ),
      ),
      Checkbox(
          value: _activated,
          onChanged: (bool newValue) =>_userBloc.setActivated(_email.text)
      ),
      FlatButton(
          child: Text('Profile'),

          onPressed: () {}
      ),
    ];
  }
}
