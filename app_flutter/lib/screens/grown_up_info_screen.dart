import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/providers.dart';
import '../theme/app_theme.dart';

/// Grown-up area. Shows privacy summary, safety rules, reset, and URLs as
/// plain text (no link-opening, so the app needs no INTERNET permission).
class GrownUpInfoScreen extends ConsumerWidget {
  const GrownUpInfoScreen({super.key});

  // Replace before publishing.
  static const websiteUrl = 'https://thisisthecoolesthting.github.io/tada-quest/';
  static const privacyUrl =
      'https://thisisthecoolesthting.github.io/tada-quest/privacy.html';
  static const contactEmail = 'reasner196@gmail.com';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.read(progressStoreProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Grown-up area')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _section('Privacy summary', [
              'Tada Quest collects no personal information.',
              'No accounts, names, photos, microphone, location, or contacts.',
              'Mission progress and badges are saved on THIS device only.',
              'No ads. No analytics. No social features. Works offline.',
            ]),
            _section('Safety rules', [
              'Missions avoid fire, sharp tools, glass, chemicals, and medicine.',
              'Water, coin, clip, soap, and small-object missions are labeled "Grown-up helps".',
              'Every mission includes a safety check and cleanup reminder.',
            ]),
            _section('Links (type these into a browser)', [
              'Website: $websiteUrl',
              'Privacy policy: $privacyUrl',
              'Contact: $contactEmail',
            ]),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Sound (coming soon)'),
              value: store.soundOn,
              onChanged: (v) async {
                await store.setSound(v);
                ref.invalidate(sessionProvider);
                (context as Element).markNeedsBuild();
              },
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  foregroundColor: TQColors.coral),
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset all progress'),
              onPressed: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (c) => AlertDialog(
                    title: const Text('Reset progress?'),
                    content: const Text(
                        'This clears completed missions and badges on this device.'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(c, false),
                          child: const Text('Cancel')),
                      TextButton(
                          onPressed: () => Navigator.pop(c, true),
                          child: const Text('Reset')),
                    ],
                  ),
                );
                if (ok == true) {
                  await store.resetAll();
                  ref.read(completedProvider.notifier).state = {};
                  ref.read(badgesProvider.notifier).state = {};
                  if (context.mounted) context.go('/home');
                }
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.go('/home'),
              icon: const Icon(Icons.home_outlined),
              label: const Text('Back to app'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<String> lines) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              ...lines.map((l) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('• $l', style: const TextStyle(fontSize: 15)),
                  )),
            ],
          ),
        ),
      );
}
