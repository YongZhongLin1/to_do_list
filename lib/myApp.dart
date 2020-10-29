import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:to_do_list/common/index.dart';
import 'package:to_do_list/feature/home/bloc/bloc.dart';
import 'package:to_do_list/feature/home/index.dart';
import 'package:to_do_list/locator.dart';
import 'package:to_do_list/service/index.dart';

var app = MultiProvider(
  providers: [
    RouteObserverProvider(),
  ],
  child: MyApp(),
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        Config.init(constraints, orientation);
        return BlocProvider<HomeBloc>(
          builder: (context) => HomeBloc(),
          child: MaterialApp(
              title: 'To-Do-List',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              navigatorKey: locator<NavigationService>().navigationKey,
              navigatorObservers: [
                RouteObserverProvider.of(context),
              ],
              home: HomePage(),
              onGenerateRoute: Routes.onGenerateRoute),
        );
      });
    });
  }
}
