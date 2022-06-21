import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/service_locators.dart';
import 'package:ggy_twitter_clone/src/controllers/navigation/navigation_service.dart';
import 'package:ggy_twitter_clone/src/screens/authentication/auth_screen.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
          scaffoldBackgroundColor: Colors.white,
          textTheme:  const TextTheme(
            headline1: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          colorScheme:  ColorScheme(
              brightness: Brightness.light,
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.black,
              secondary: Colors.grey,
              onSecondary: Colors.white,
              error: Colors.black,
              onError: Colors.red,
              background: Theme.of(context).scaffoldBackgroundColor,
              onBackground: Colors.white,
              surface: Colors.red,
              onSurface: Colors.red,
              shadow: const Color.fromARGB(255, 0, 0, 0)),
          iconTheme: const IconThemeData(
              color: Colors.red, size: 30)),
      debugShowCheckedModeBanner: false,
      builder: (context, Widget? child) => child as Widget,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: NavigationService.generateRoute,
      initialRoute: AuthScreen.route,
    );
  }
}
