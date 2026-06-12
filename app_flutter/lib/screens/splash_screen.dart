import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MissionArt('assets/svg/characters/mascot_spark_owl.svg',
                    size: 160),
                const SizedBox(height: 16),
                const MissionArt('assets/svg/brand/logo_tada_quest.svg',
                    size: 120),
                const SizedBox(height: 8),
                const Text(
                  'Tada Quest',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: TQColors.purpleDeep),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Safe home magic missions',
                  style: TextStyle(fontSize: 18, color: TQColors.ink),
                ),
                const SizedBox(height: 40),
                BigButton('Start',
                    icon: Icons.play_arrow_rounded,
                    onPressed: () => context.go('/age')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
