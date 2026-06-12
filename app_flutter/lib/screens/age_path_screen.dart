import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/providers.dart';
import '../models/mission.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class AgePathScreen extends ConsumerWidget {
  const AgePathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = [TQColors.sky, TQColors.mint, TQColors.purple, TQColors.sun];
    return Scaffold(
      appBar: AppBar(title: const Text('Who is playing?')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              const Text(
                'No name. No account. Just pick who is playing.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ...List.generate(AgePath.values.length, (i) {
                final p = AgePath.values[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: BigButton(
                    p.label,
                    color: colors[i % colors.length],
                    onPressed: () async {
                      await ref.read(sessionProvider.notifier).setAgePath(p);
                      if (p == AgePath.grownUp) {
                        if (context.mounted) context.go('/grownup');
                      } else {
                        if (context.mounted) context.go('/safety');
                      }
                    },
                  ),
                );
              }),
              const Spacer(),
              const Text(
                'A grown-up should help with water, coins, clips, soap, or scissors.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
