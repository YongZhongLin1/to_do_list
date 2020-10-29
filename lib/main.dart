import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list/locator.dart';
import 'package:to_do_list/myApp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator();
  runApp(app);
}
