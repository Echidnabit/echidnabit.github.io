import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const EchidnabitWebsiteApp());
}

class EchidnabitWebsiteApp extends StatelessWidget {
  const EchidnabitWebsiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echidnabit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3454D1)),
        useMaterial3: true,
      ),
      initialRoute: Uri.base.path,
      onGenerateRoute: AppRouteFactory.generateRoute,
    );
  }
}

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<AppShowcase> appShowcases = [
    AppShowcase(
      name: 'Tessellate',
      description:
          'Tessellate lets artists split their pictures so creating repeatable tessellated art is quick and easy.',
      iconAsset: 'assets/icons/tessellate.png',
      accentColor: Color(0xFF4E79E6),
      appStoreUrl: 'https://apps.apple.com/us/app/tessellate/id6473245834',
    ),
    AppShowcase(
      name: 'Pitchi',
      description:
          'Pitchi is a music learning companion targeted at musical students who want extra pitch training support.',
      iconAsset: 'assets/icons/pitchi.png',
      accentColor: Color(0xFFE66D4E),
      appStoreUrl: 'https://apps.apple.com/au/app/pitchi/id6499306008',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 520;
                    final titleBlock = Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Echidnabit',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        LayoutBuilder(
                          builder: (context, logoConstraints) {
                            final logoTarget = (logoConstraints.maxWidth * 0.32)
                                .clamp(88.0, 140.0)
                                .toDouble();
                            return Image.asset(
                              'assets/logo.png',
                              height: logoTarget,
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ],
                    );
                    final privacyButton = FilledButton.tonalIcon(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRouteFactory.privacyPolicy);
                      },
                      icon: const Icon(Icons.privacy_tip_outlined),
                      label: const Text('Privacy Policy'),
                    );

                    if (isNarrow) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          titleBlock,
                          const SizedBox(height: 12),
                          privacyButton,
                        ],
                      );
                    }

                    return ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 96),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: titleBlock,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: privacyButton,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: const _HeroSection(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: Text(
                  'Apps',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              sliver: SliverLayoutBuilder(
                builder: (context, constraints) {
                  final useTwoColumns = constraints.crossAxisExtent >= 720;
                  if (!useTwoColumns) {
                    return SliverList.builder(
                      itemCount: appShowcases.length,
                      itemBuilder: (context, index) {
                        final app = appShowcases[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AppShowcaseCard(
                            app: app,
                            isCompact: constraints.crossAxisExtent < 520,
                          ),
                        );
                      },
                    );
                  }

                  final mainAxisExtent =
                      constraints.crossAxisExtent >= 980 ? 440.0 : 460.0;
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: mainAxisExtent,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final app = appShowcases[index];
                        return AppShowcaseCard(
                          app: app,
                          isCompact: false,
                        );
                      },
                      childCount: appShowcases.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mobile app studio',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Contact me',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Contact me with any bugs, feature requests, or suggestions.',
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () async {
                final contactUri = Uri(
                  scheme: 'mailto',
                  path: 'echidnabit@gmail.com',
                  queryParameters: {'subject': 'Hello from echidnabit.com'},
                );
                await launchUrl(contactUri);
              },
              icon: const Icon(Icons.email_outlined),
              label: const Text('echidnabit@gmail.com'),
            ),
          ],
        ),
      ),
    );
  }
}

class AppShowcaseCard extends StatelessWidget {
  const AppShowcaseCard({super.key, required this.app, required this.isCompact});

  final AppShowcase app;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final appStoreUrl = app.appStoreUrl;
    final iconFillRatio = isCompact ? 0.72 : 0.8;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                final reservedHeight =
                    appStoreUrl == null ? 128.0 : 168.0;
                final maxSizeByHeight = constraints.hasBoundedHeight
                    ? math.max(0.0, constraints.maxHeight - reservedHeight)
                    : 240.0;
                final targetSize = math.min(
                  availableWidth * iconFillRatio,
                  maxSizeByHeight,
                ).clamp(120.0, 240.0);
                final iconSize = targetSize * 0.88;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: targetSize,
                        height: targetSize,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: app.accentColor.withValues(alpha: 0.12),
                            borderRadius:
                                BorderRadius.circular(targetSize * 0.24),
                          ),
                          child: Center(
                            child: Image.asset(
                              app.iconAsset,
                              width: iconSize,
                              height: iconSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      app.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(app.description),
                    if (appStoreUrl != null) ...[
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () async {
                          await launchUrl(Uri.parse(appStoreUrl));
                        },
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Download for iPhone'),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          Text(
            'Echidnabit Privacy Policy',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'This basic privacy policy explains how Echidnabit handles user data in our apps and on this website.',
          ),
          SizedBox(height: 16),
          Text('1. Data collection', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text(
            'Echidnabit aims to collect as little personal data as possible. If an app needs account, analytics, or crash reporting data, only the minimum required data is collected.',
          ),
          SizedBox(height: 16),
          Text('2. Data use', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text(
            'Any data collected is used to operate, maintain, and improve app features. We do not sell personal data.',
          ),
          SizedBox(height: 16),
          Text('3. Third-party services', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text(
            'Some apps may rely on trusted third-party services such as app stores, analytics, or cloud providers. Their privacy terms apply to data handled by those services.',
          ),
          SizedBox(height: 16),
          Text('4. Contact', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text('Questions can be sent to Echidnabit@gmail.com.'),
          SizedBox(height: 24),
          Text(
            'Last updated: 2026-02-21',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

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
