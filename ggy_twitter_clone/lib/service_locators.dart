
import 'package:get_it/get_it.dart';
import 'package:ggy_twitter_clone/src/controllers/auth_controllers.dart';
import 'package:ggy_twitter_clone/src/controllers/navigation/navigation_service.dart';

final locator = GetIt.instance;

void setupLocators() {
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<AuthController>(AuthController());
}
