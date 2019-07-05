// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'bloc/error/index.dart';
import 'constants/strings.dart';
import 'bloc/app/index.dart';
import 'modules/account/bloc/authentication/index.dart';
import 'modules/account/bloc/user/index.dart';
import 'views/splash.dart';
import 'services/locator.dart';
import 'services/routes.dart';
import 'services/navigation.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    setupLocator();
    runApp( MultiProvider(
        providers: [
            ChangeNotifierProvider(builder: (_) => AppBloc()),
            ChangeNotifierProvider(builder: (_) => AuthenticationBloc()),
            ChangeNotifierProvider(builder: (_) => UserBloc()),
            ChangeNotifierProvider(builder: (_) => ErrorBloc()),
        ], child: KutilangApp()
    ));
  });
}

class KutilangApp extends StatelessWidget {
 
  final _appKey = GlobalKey<State>();
 
  @override
  Widget build(BuildContext context) {
    final AppBloc _appBloc = Provider.of<AppBloc>(context);

    return  MaterialApp(
                key: _appKey,
                debugShowCheckedModeBanner: false,
                title: Strings.appName,
                theme: _appBloc.theme,
                routes: Routes.routes,
                home: SplashScreen(),
                navigatorKey: NavigationService.navigatorKey
    );
  }
}