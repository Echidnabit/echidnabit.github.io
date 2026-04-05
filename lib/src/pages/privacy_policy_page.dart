import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Privacy Policy'),
        prefixes: [
          FHeaderAction.back(
            onPress: () {
              Navigator.of(context).maybePop();
            },
          ),
        ],
      ),
      childPad: false,
      child: SelectionArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          children: [
            FCard.raw(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.theme.colors.card,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: context.theme.colors.border),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Echidnabit Privacy Policy',
                      style: context.theme.typography.xl3.copyWith(
                        color: context.theme.colors.foreground,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'This basic privacy policy explains how Echidnabit handles user data in our apps and on this website.',
                      style: context.theme.typography.md.copyWith(
                        color: context.theme.colors.mutedForeground,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _PolicySection(
                      title: '1. Data collection',
                      body:
                          'Echidnabit aims to collect as little personal data as possible. If an app needs account, analytics, or crash reporting data, only the minimum required data is collected.',
                    ),
                    const SizedBox(height: 20),
                    const _PolicySection(
                      title: '2. Data use',
                      body:
                          'Any data collected is used to operate, maintain, and improve app features. We do not sell personal data.',
                    ),
                    const SizedBox(height: 20),
                    const _PolicySection(
                      title: '3. Third-party services',
                      body:
                          'Some apps may rely on trusted third-party services such as app stores, analytics, or cloud providers. Their privacy terms apply to data handled by those services.',
                    ),
                    const SizedBox(height: 20),
                    const _PolicySection(
                      title: '4. Contact',
                      body: 'Questions can be sent to Echidnabit@gmail.com.',
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Last updated: 2026-02-21',
                      style: context.theme.typography.sm.copyWith(
                        color: context.theme.colors.mutedForeground,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  const _PolicySection({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.theme.typography.lg.copyWith(
            color: context.theme.colors.foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: context.theme.typography.sm.copyWith(
            color: context.theme.colors.mutedForeground,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
