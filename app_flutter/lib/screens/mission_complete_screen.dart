import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/providers.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/mission_scaffold.dart';

class MissionCompleteScreen extends ConsumerWidget {
  final String missionId;
  const MissionCompleteScreen({super.key, required this.missionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MissionLoader(
      missionId: missionId,
      builder: (context, m) {
        Future<void> award() async {
          await ref
              .read(progressStoreProvider)
              .completeMission(m.id, m.badge);
          ref.read(completedProvider.notifier).state =
              ref.read(progressStoreProvider).completed;
          ref.read(badgesProvider.notifier).state =
              ref.read(progressStoreProvider).badges;
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Did it work?')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  MissionArt('assets/svg/ui/star_badge.svg', size: 120),
                  const SizedBox(height: 8),
                  Text('You earned the ${m.badge}!',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  const Text('How did it go?', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _choice(context, 'Yes!', TQColors.mint, () async {
                        await award();
                        if (context.mounted) context.go('/badges');
                      }),
                      _choice(context, 'Almost', TQColors.sun, () async {
                        await award();
                        if (context.mounted) {
                          context.go('/mission/${m.id}/steps');
                        }
                      }),
                      _choice(context, 'Not yet', TQColors.sky, () {
                        context.go('/mission/${m.id}/prep');
                      }),
                    ],
                  ),
                  const Spacer(),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56)),
                    onPressed: () => context.go('/home'),
                    icon: const Icon(Icons.home_outlined),
                    label: const Text('Back to missions'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _choice(
          BuildContext context, String t, Color c, VoidCallback onTap) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: c, minimumSize: const Size.fromHeight(64)),
            onPressed: onTap,
            child: Text(t, style: const TextStyle(fontSize: 18)),
          ),
        ),
      );
}
