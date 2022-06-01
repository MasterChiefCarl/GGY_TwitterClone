part of 'navigation_service.dart';

PageRoute getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.route:
      return FadeRoute(page: const AuthScreen(), settings: settings);
    case HomeScreen.route:
      return SlideLeftRoute(page: const HomeScreen(), settings: settings);
    default:
      return FadeRoute(page: const AuthScreen(),settings: settings);
  }
}