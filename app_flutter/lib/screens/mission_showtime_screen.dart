import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/mission_scaffold.dart';

class MissionShowtimeScreen extends StatelessWidget {
  final String missionId;
  const MissionShowtimeScreen({super.key, required this.missionId});

  @override
  Widget build(BuildContext context) {
    return MissionLoader(
      missionId: missionId,
      builder: (context, m) => Scaffold(
        appBar: AppBar(title: const Text('Showtime!')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 8),
                const Text('Say this like a real magician:',
                    style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                Expanded(
                  child: Center(
                    child: Card(
                      color: TQColors.purpleDeep,
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Text(
                          '"${m.showTip}"',
                          style: const TextStyle(
                              fontSize: 24,
                              height: 1.4,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                BigButton('I did the trick!',
                    icon: Icons.celebration_outlined,
                    color: TQColors.mint,
                    onPressed: () => context.go('/mission/${m.id}/complete')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
