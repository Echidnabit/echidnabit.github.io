import 'package:flutter/widgets.dart';

class AppShowcase {
  const AppShowcase({
    required this.name,
    required this.description,
    required this.iconAsset,
    required this.accentColor,
    this.appStoreUrl,
  });

  final String name;
  final String description;
  final String iconAsset;
  final Color accentColor;
  final String? appStoreUrl;
}
