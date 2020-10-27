import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/common/index.dart';
import './bloc.dart';

class NavigatorBloc extends Bloc<NavigatorAction, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorBloc({this.navigatorKey});

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigatorAction event) async* {
    if (event is NavigatorActionPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigateToHomeEvent) {
      navigatorKey.currentState.pushNamed(Routes.appHome);
    } else if (event is NavigateToForm) {
      navigatorKey.currentState.pushNamed(Routes.toDoForm, arguments: {
        "onNext": (context) {
          Navigator.pop(context);
        }
      });
    }
  }
}
