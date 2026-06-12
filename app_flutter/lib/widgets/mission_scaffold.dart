import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/providers.dart';
import '../models/mission.dart';

/// Loads all missions, finds one by id, and hands it to [builder].
class MissionLoader extends ConsumerWidget {
  final String missionId;
  final Widget Function(BuildContext, Mission) builder;
  const MissionLoader(
      {super.key, required this.missionId, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(missionsProvider);
    return async.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (all) {
        final m = all.where((x) => x.id == missionId).firstOrNull;
        if (m == null) {
          return const Scaffold(
              body: Center(child: Text('Mission not found.')));
        }
        return builder(context, m);
      },
    );
  }
}
