import 'package:echidnabit_website_flutter/src/app_route_factory.dart';
import 'package:echidnabit_website_flutter/src/theme/echidnabit_theme.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class EchidnabitWebsiteApp extends StatelessWidget {
  const EchidnabitWebsiteApp({super.key, this.initialRouteOverride});

  final String? initialRouteOverride;

  @override
  Widget build(BuildContext context) {
    final theme = EchidnabitTheme.light;

    return MaterialApp(
      title: 'Echidnabit',
      debugShowCheckedModeBanner: false,
      theme: theme.toApproximateMaterialTheme(),
      localizationsDelegates: FLocalizations.localizationsDelegates,
      supportedLocales: FLocalizations.supportedLocales,
      initialRoute: initialRouteOverride ?? Uri.base.path,
      onGenerateRoute: AppRouteFactory.generateRoute,
      builder: (context, child) =>
          FTheme(data: theme, child: child ?? const SizedBox.shrink()),
    );
  }
}
