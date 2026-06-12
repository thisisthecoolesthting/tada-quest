import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/mission_scaffold.dart';

class MissionSecretScreen extends StatelessWidget {
  final String missionId;
  const MissionSecretScreen({super.key, required this.missionId});

  @override
  Widget build(BuildContext context) {
    return MissionLoader(
      missionId: missionId,
      builder: (context, m) => Scaffold(
        appBar: AppBar(title: const Text('The Secret')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 12),
                const Icon(Icons.auto_awesome, size: 64, color: TQColors.sun),
                const SizedBox(height: 16),
                Text('How "${m.title}" works',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(m.secret,
                            style: const TextStyle(fontSize: 22, height: 1.4),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
                BigButton('Try showtime',
                    icon: Icons.theater_comedy_outlined,
                    color: TQColors.coral,
                    onPressed: () => context.go('/mission/${m.id}/showtime')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
