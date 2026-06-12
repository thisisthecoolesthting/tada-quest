import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/providers.dart';
import '../models/mission.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

final _activeFilterProvider = StateProvider<String>((ref) => 'All');

class MissionHomeScreen extends ConsumerWidget {
  const MissionHomeScreen({super.key});

  static const filters = [
    'All',
    'Starter',
    'Easy',
    'Medium',
    'No mess',
    'Water',
    'No props',
  ];

  bool _matches(Mission m, String f) {
    switch (f) {
      case 'All':
        return true;
      case 'Starter':
        return m.skill == 'starter';
      case 'Easy':
        return m.skill == 'easy';
      case 'Medium':
        return m.skill == 'medium';
      case 'No mess':
        return m.messLevel == 'none';
      case 'Water':
        return m.messLevel.contains('water');
      case 'No props':
        return m.items.any((i) => i.contains('no props'));
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visible = ref.watch(visibleMissionsProvider);
    final filter = ref.watch(_activeFilterProvider);
    final completed = ref.watch(completedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Missions'),
        actions: [
          IconButton(
            tooltip: 'Badge book',
            icon: const Icon(Icons.emoji_events_outlined),
            onPressed: () => context.go('/badges'),
          ),
          IconButton(
            tooltip: 'Grown-up area',
            icon: const Icon(Icons.lock_outline),
            onPressed: () => context.go('/grownup'),
          ),
        ],
      ),
      body: SafeArea(
        child: visible.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Could not load missions.\n$e')),
          data: (missions) {
            final shown =
                missions.where((m) => _matches(m, filter)).toList();
            return Column(
              children: [
                _ProgressBar(done: completed.length, total: missions.length),
                SizedBox(
                  height: 56,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: filters.map((f) {
                      final sel = f == filter;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(f),
                          selected: sel,
                          onSelected: (_) => ref
                              .read(_activeFilterProvider.notifier)
                              .state = f,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: shown.length,
                    itemBuilder: (c, i) {
                      final m = shown[i];
                      final done = completed.contains(m.id);
                      return Card(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(28),
                          onTap: () => context.go('/mission/${m.id}/prep'),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                MissionArt(m.bundledAsset, size: 72),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(m.title,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                          ),
                                          if (done)
                                            const Icon(Icons.check_circle,
                                                color: TQColors.mint),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(m.subtitle,
                                          style: const TextStyle(fontSize: 14)),
                                      const SizedBox(height: 8),
                                      Wrap(spacing: 8, runSpacing: 6, children: [
                                        _pill('${m.timeMinutes} min'),
                                        _pill(m.skill),
                                        if (m.needsAdult) const AdultBadge(),
                                      ]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _pill(String t) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: TQColors.sky.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(t, style: const TextStyle(fontSize: 13)),
      );
}

class _ProgressBar extends StatelessWidget {
  final int done;
  final int total;
  const _ProgressBar({required this.done, required this.total});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          const Icon(Icons.star, color: TQColors.sun),
          const SizedBox(width: 8),
          Text('$done of $total missions done',
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const Spacer(),
          SizedBox(
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: total == 0 ? 0 : done / total,
                minHeight: 10,
                backgroundColor: Colors.black12,
                color: TQColors.mint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
