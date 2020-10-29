import 'package:flutter/material.dart';
import 'package:to_do_list/feature/index.dart';

class Routes {
  static const String appHome = "/appHome";
  static const String toDoForm = "/toDoForm";

  static Widget generateRoute(Widget page) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return page;
          },
        ),
      ),
    );
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final Map<String, dynamic> args = settings?.arguments ?? {};

    switch (settings.name) {
      case appHome:
        return MaterialPageRoute(
          builder: (context) {
            return generateRoute(HomePage());
          },
        );
        break;

      case toDoForm:
        return MaterialPageRoute(
          builder: (context) {
            return generateRoute(ToDoForm(
              toDo: args["toDo"],
            ));
          },
        );
        break;
    }

    return MaterialPageRoute(builder: (context) => generateRoute(HomePage()));
  }
}
