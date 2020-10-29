import 'package:flutter/material.dart';
import 'package:to_do_list/common/index.dart';
import 'package:to_do_list/model/index.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateToForm({ToDo toDo}) async {
    return [
      _navigationKey.currentState
          .pushNamed(Routes.toDoForm, arguments: {"toDo": toDo})
    ];
  }
}
