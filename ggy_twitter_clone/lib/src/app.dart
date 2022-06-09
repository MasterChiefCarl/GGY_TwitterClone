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
          primaryColor: Colors.orange,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.orange,
              onPrimary: Colors.white,
              secondary: Colors.blue,
              onSecondary: Colors.white,
              error: Colors.black,
              onError: Colors.red,
              background: Color.fromARGB(255, 192, 192, 192),
              onBackground: Colors.white,
              surface: Colors.red,
              onSurface: Colors.red,
              shadow: Color.fromARGB(255, 0, 0, 0)),
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
