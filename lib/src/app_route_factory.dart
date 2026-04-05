import 'package:echidnabit_website_flutter/src/pages/home_page.dart';
import 'package:echidnabit_website_flutter/src/pages/privacy_policy_page.dart';
import 'package:flutter/material.dart';

class AppRouteFactory {
  static const String home = '/';
  static const String privacyPolicy = '/privacy-policy';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final routeName = _normalizedRoute(routeSettings.name);

    switch (routeName) {
      case home:
        return _pageRoute(const HomePage());
      case privacyPolicy:
        return _pageRoute(const PrivacyPolicyPage());
      default:
        return _pageRoute(const HomePage());
    }
  }

  static String _normalizedRoute(String? routeName) {
    if (routeName == null || routeName.isEmpty) {
      return home;
    }

    final normalizedPath = Uri.parse(routeName).path;
    if (normalizedPath.isEmpty) {
      return home;
    }

    return normalizedPath;
  }

  static MaterialPageRoute<dynamic> _pageRoute(Widget page) {
    return MaterialPageRoute<dynamic>(builder: (_) => page);
  }
}
