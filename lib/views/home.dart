import 'package:flutter/material.dart';
import 'package:jh_flutter_provider/bloc/error/index.dart';
import 'package:provider/provider.dart';
import '../bloc/app/index.dart';
import '../widgets/rounded_button_widget.dart';
import '../modules/account/bloc/authentication/index.dart';
import '../modules/account/bloc/user/index.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/global_methods.dart';
import '../widgets/progress_indicator_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
     final AppBloc _appBloc = Provider.of<AppBloc>(context);
     final AuthenticationBloc _authBloc = Provider.of<AuthenticationBloc>(context);
     final UserBloc _userBloc = Provider.of<UserBloc>(context);
     final ErrorBloc _errorBloc = Provider.of<ErrorBloc>(context);

    _userBloc.getProfile();

    return Scaffold(
      key: _homeKey,
      appBar: buildAppBar(context,'Home'),
      body: _buildBody(_authBloc,_appBloc,_errorBloc),
      drawer: CommonDrawer(),
      bottomNavigationBar: BottomAppBar(child: Text('kkk'),),
    );
  }

   _buildBody(AuthenticationBloc _authBloc,AppBloc _appBloc,ErrorBloc _errorBloc) {
    return Stack(
      children: <Widget>[
        !_authBloc.loggedIn
                ? CustomProgressIndicatorWidget()
                : Material(child: SafeArea(
                child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  RoundedButtonWidget(
                buttonText: '>>>> ${_errorBloc.errorMessage}',
                buttonColor:  Theme.of(context).buttonColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () => _appBloc.switchToLight()
              ),
              RoundedButtonWidget(
                buttonText: 'Dark',
                buttonColor:  Theme.of(context).buttonColor,
                textColor: Theme.of(context).textTheme.button.color,   
                onPressed: ()=>_appBloc.switchToDark()
              ),
                ]
                )
                 )
        ),
        _authBloc.success
                ? Container()
                : showErrorMessage(context, _errorBloc.errorMessage)
      ],
    );
  }
}