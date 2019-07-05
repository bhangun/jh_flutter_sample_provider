import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../../bloc/error/index.dart';
import '../../../widgets/alert_widget.dart';
import '../../../widgets/appbar_widget.dart';
import '../bloc/user/index.dart';
import '../../../widgets/global_methods.dart';
import '../../../widgets/progress_indicator_widget.dart';


class UserList extends StatefulWidget {
  final String title;
  UserList({Key key, this.title}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final _listKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  UserBloc _userBloc = Provider.of<UserBloc>(context);


  _userBloc.getUserList();
  return Scaffold(
                    key: _listKey,
                        // cannot be used using this form $_userBloc.totalUser
                        appBar: buildAppBar(context, 'User List ( ${_userBloc.totalUser} )'),
                        body: _buildBody(_userBloc,context),
                        floatingActionButton: FloatingActionButton(
                          onPressed: _userBloc.add,
                          tooltip: 'Add',
                          child: Icon(Icons.add),
                        )
    );
  }

  _buildBody(UserBloc _userBloc,BuildContext context) {
    return Stack(
      children: <Widget>[
        _userBloc.loading
                ? CustomProgressIndicatorWidget()
                : Material(child: _buildSlidelist(_userBloc,context)),
       _userBloc.success
                ? showInformation(context, 'info', 'bismillah')
                : showErrorMessage(context, '')//_errorBloc.errorMessage)
        ,_userBloc.isModified ? KutAlert():Container(),
      ],
    );
  }

  _buildSlidelist(UserBloc _userBloc,BuildContext context){
    return !_userBloc.islistEmpty? 
          ListView.separated(
            itemCount: _userBloc.userList.length,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return Slidable(
                  key: ValueKey(index),
                  actionPane: SlidableDrawerActionPane(),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Archive',
                      color: Colors.blue,
                      icon: Icons.archive,
                    ),
                    IconSlideAction(
                      caption: 'Share',
                      color: Colors.indigo,
                      icon: Icons.share,
                    ),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'More',
                      color: Colors.grey.shade200,
                      icon: Icons.more_horiz,
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: ()=> _userBloc.delete(_userBloc.userList[index].login),
                    ),
                  ],
                  dismissal: SlidableDismissal(
                    child: SlidableDrawerDismissal(),
                  ),
                  child: ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  '${_userBloc.userList[index].login}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  '${_userBloc.userList[index].email } ',// ${_userBloc.itemDetail.email}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                 onTap: ()=>_userBloc.itemTapU(index)
              ),
                );
            }
          )
          : Center(child: Text('Data empty'));
  }
}