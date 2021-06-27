import 'package:get_it/get_it.dart';
import 'package:my_shop/Services/utility_service.dart';
import 'Services/navigation_service.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => UtiltiyService());
}
