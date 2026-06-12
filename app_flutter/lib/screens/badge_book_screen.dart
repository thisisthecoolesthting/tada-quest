import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/providers.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class BadgeBookScreen extends ConsumerWidget {
  const BadgeBookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badges = ref.watch(badgesProvider).toList()..sort();
    return Scaffold(
      appBar: AppBar(title: const Text('Badge Book')),
      body: SafeArea(
        child: badges.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'No badges yet.\nFinish a mission to earn your first one!',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                children: badges
                    .map((b) => Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MissionArt('assets/svg/ui/star_badge.svg',
                                  size: 72),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(b,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: BigButton('Back to missions',
            icon: Icons.home_outlined,
            color: TQColors.purple,
            onPressed: () => context.go('/home')),
      ),
    );
  }
}
