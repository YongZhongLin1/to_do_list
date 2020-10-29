import 'package:get_it/get_it.dart';
import 'package:to_do_list/service/index.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
