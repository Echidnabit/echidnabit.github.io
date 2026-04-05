import 'dart:math' as math;

import 'package:echidnabit_website_flutter/src/app_route_factory.dart';
import 'package:echidnabit_website_flutter/src/models/app_showcase.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return FScaffold(
      header: FHeader(
        suffixes: [
          FHeaderAction(
            onPress: () {
              Navigator.of(context).pushNamed(AppRouteFactory.privacyPolicy);
            },
            icon: const Icon(Icons.privacy_tip_outlined),
          ),
        ],
      ),
      childPad: false,
      child: SelectionArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: const _HomeIntro(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: const _HeroSection(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                child: Text(
                  'Apps',
                  style: context.theme.typography.xl.copyWith(
                    color: context.theme.colors.foreground,
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

                  final mainAxisExtent = constraints.crossAxisExtent >= 980
                      ? 520.0
                      : 500.0;
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: mainAxisExtent,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final app = appShowcases[index];
                      return AppShowcaseCard(app: app, isCompact: false);
                    }, childCount: appShowcases.length),
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

class _HomeIntro extends StatelessWidget {
  const _HomeIntro();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 620;
        final logo = Container(
          width: isNarrow ? 132 : 152,
          height: isNarrow ? 132 : 152,
          decoration: BoxDecoration(
            color: context.theme.colors.secondary,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: context.theme.colors.border),
          ),
          padding: const EdgeInsets.all(18),
          child: Image.asset('assets/logo.png', fit: BoxFit.contain),
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: logo),
            const SizedBox(height: 16),
            Text(
              'Echidnabit',
              textAlign: TextAlign.center,
              style: context.theme.typography.xl2.copyWith(
                color: context.theme.colors.foreground,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return FCard.raw(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [context.theme.colors.secondary, context.theme.colors.card],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: context.theme.colors.border),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 720;
            final content = Column(
              crossAxisAlignment: stacked
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile app studio',
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Contact me',
                  style: context.theme.typography.xl2.copyWith(
                    color: context.theme.colors.foreground,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Contact me with any bugs, feature requests, or suggestions.',
                  style: context.theme.typography.md.copyWith(
                    color: context.theme.colors.mutedForeground,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 18),
                FButton(
                  onPress: () async {
                    final contactUri = Uri(
                      scheme: 'mailto',
                      path: 'echidnabit@gmail.com',
                      queryParameters: {'subject': 'Hello from echidnabit.com'},
                    );
                    await launchUrl(contactUri);
                  },
                  mainAxisSize: MainAxisSize.min,
                  child: const Text('echidnabit@gmail.com'),
                ),
              ],
            );

            if (stacked) {
              return content;
            }

            return content;
          },
        ),
      ),
    );
  }
}

class AppShowcaseCard extends StatelessWidget {
  const AppShowcaseCard({
    super.key,
    required this.app,
    required this.isCompact,
  });

  final AppShowcase app;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final appStoreUrl = app.appStoreUrl;
    final iconFillRatio = isCompact ? 0.62 : 0.72;

    return FCard.raw(
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.colors.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.theme.colors.border),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;
            final targetSize = math
                .min(availableWidth * iconFillRatio, isCompact ? 160.0 : 220.0)
                .clamp(120.0, 220.0);
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
                        borderRadius: BorderRadius.circular(targetSize * 0.24),
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
                const SizedBox(height: 18),
                Text(
                  app.name,
                  style: context.theme.typography.xl.copyWith(
                    color: context.theme.colors.foreground,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  app.description,
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colors.mutedForeground,
                    height: 1.35,
                  ),
                ),
                if (appStoreUrl != null) ...[
                  const SizedBox(height: 16),
                  FButton(
                    variant: .outline,
                    mainAxisSize: MainAxisSize.min,
                    onPress: () async {
                      await launchUrl(Uri.parse(appStoreUrl));
                    },
                    child: const Text('Download for iPhone'),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
