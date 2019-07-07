import 'package:flutter/material.dart';
import 'package:jh_flutter_provider/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';
import '../bloc/user/index.dart';

class UserDetail extends StatefulWidget {
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {

 

  @override
  Widget build(BuildContext context) {
      UserBloc _userBloc = Provider.of<UserBloc>(context);
    return ChangeNotifierProvider(builder: (_) => UserBloc(), child:
    Scaffold(
        appBar: buildAppBar(context, 'User Detail >>${_userBloc.isItemEmpty}'),//${_userBloc.itemDetail.firstName}'),
        body: _userBloc.isItemEmpty?
            Center(child: Text('User data are empty >> ${_userBloc.position}')):
             userDetail( _userBloc,context),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _userBloc.viewDetail(),
          tooltip: 'Add',
          child: Icon(Icons.edit),
        )));
  }

  userDetail(UserBloc _userBloc,BuildContext context) {
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 100.0),
          Icon(Icons.person, size: 100, color: Colors.blue[500]),
         Column(
              children: <Widget>[
                Text(_userBloc.itemDetail.firstName),
                Text(_userBloc.itemDetail.lastName),
                Text(_userBloc.itemDetail.email),
                Text(_userBloc.itemDetail.authorities.toString()),
                Text(_userBloc.itemDetail.lastModifiedDate.toString()),
                Text(_userBloc.itemDetail.createdDate.toString()),
              ])
        ]);
        
  }
}
