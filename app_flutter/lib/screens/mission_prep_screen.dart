import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/mission_scaffold.dart';

class MissionPrepScreen extends StatelessWidget {
  final String missionId;
  const MissionPrepScreen({super.key, required this.missionId});

  @override
  Widget build(BuildContext context) {
    return MissionLoader(
      missionId: missionId,
      builder: (context, m) => Scaffold(
        appBar: AppBar(title: Text(m.title)),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(child: MissionArt(m.bundledAsset, size: 120)),
              const SizedBox(height: 12),
              Text(m.effect,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              const _Header(Icons.backpack_outlined, 'What you need'),
              ...m.items.map((i) => _bullet(i)),
              const SizedBox(height: 16),
              const _Header(Icons.shield_outlined, 'Safety check'),
              ...m.safety.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SafetyChip(s),
                  )),
              if (m.needsAdult) ...[
                const SizedBox(height: 8),
                const AdultBadge(),
              ],
              const SizedBox(height: 24),
              BigButton('I have the stuff',
                  icon: Icons.thumb_up_alt_outlined,
                  onPressed: () => context.go('/mission/${m.id}/steps')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bullet(String t) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(children: [
          const Icon(Icons.circle, size: 8, color: TQColors.purple),
          const SizedBox(width: 10),
          Expanded(child: Text(t, style: const TextStyle(fontSize: 16))),
        ]),
      );
}

class _Header extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Header(this.icon, this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(children: [
          Icon(icon, color: TQColors.purpleDeep),
          const SizedBox(width: 8),
          Text(text,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w800)),
        ]),
      );
}
