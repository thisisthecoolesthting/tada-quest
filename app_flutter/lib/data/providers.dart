import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mission.dart';
import 'mission_repository.dart';
import 'progress_store.dart';

final missionRepositoryProvider =
    Provider<MissionRepository>((ref) => MissionRepository());

final missionsProvider = FutureProvider<List<Mission>>((ref) async {
  return ref.read(missionRepositoryProvider).load();
});

/// Must be overridden in main() with the initialized store.
final progressStoreProvider = Provider<ProgressStore>(
  (ref) => throw UnimplementedError('ProgressStore not initialized'),
);

/// Holds the in-session UI state for the selected age path and grown-up flag.
class SessionState {
  final AgePath? agePath;
  final bool grownUpPresent;
  const SessionState({this.agePath, this.grownUpPresent = false});

  SessionState copyWith({AgePath? agePath, bool? grownUpPresent}) => SessionState(
        agePath: agePath ?? this.agePath,
        grownUpPresent: grownUpPresent ?? this.grownUpPresent,
      );
}

class SessionNotifier extends StateNotifier<SessionState> {
  final ProgressStore _store;
  SessionNotifier(this._store)
      : super(SessionState(
          agePath: _store.agePath,
          grownUpPresent: _store.grownUpPresent,
        ));

  Future<void> setAgePath(AgePath p) async {
    await _store.setAgePath(p);
    state = state.copyWith(agePath: p);
  }

  Future<void> setGrownUpPresent(bool v) async {
    await _store.setGrownUpPresent(v);
    state = state.copyWith(grownUpPresent: v);
  }
}

final sessionProvider =
    StateNotifierProvider<SessionNotifier, SessionState>((ref) {
  return SessionNotifier(ref.read(progressStoreProvider));
});

/// Missions filtered by the current session's age path + grown-up flag.
final visibleMissionsProvider = FutureProvider<List<Mission>>((ref) async {
  final all = await ref.watch(missionsProvider.future);
  final session = ref.watch(sessionProvider);
  final path = session.agePath ?? AgePath.six8;
  return MissionFilter.forAgePath(all, path,
      grownUpPresent: session.grownUpPresent);
});

/// Completed-set + badges, refreshed on demand.
final completedProvider = StateProvider<Set<String>>((ref) {
  return ref.read(progressStoreProvider).completed;
});
final badgesProvider = StateProvider<Set<String>>((ref) {
  return ref.read(progressStoreProvider).badges;
});
