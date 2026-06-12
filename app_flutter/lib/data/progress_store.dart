import 'package:shared_preferences/shared_preferences.dart';
import '../models/mission.dart';

/// On-device only progress. No network, no identifiers, no names.
class ProgressStore {
  static const _kCompleted = 'tq_completed_ids';
  static const _kBadges = 'tq_badge_ids';
  static const _kAgePath = 'tq_age_path';
  static const _kSound = 'tq_sound_on';
  static const _kGrownUp = 'tq_grownup_present';

  final SharedPreferences _prefs;
  ProgressStore(this._prefs);

  static Future<ProgressStore> create() async =>
      ProgressStore(await SharedPreferences.getInstance());

  Set<String> get completed => (_prefs.getStringList(_kCompleted) ?? []).toSet();
  Set<String> get badges => (_prefs.getStringList(_kBadges) ?? []).toSet();

  AgePath? get agePath => AgePathX.fromId(_prefs.getString(_kAgePath));
  bool get soundOn => _prefs.getBool(_kSound) ?? false;
  bool get grownUpPresent => _prefs.getBool(_kGrownUp) ?? false;

  Future<void> setAgePath(AgePath p) => _prefs.setString(_kAgePath, p.id);
  Future<void> setSound(bool v) => _prefs.setBool(_kSound, v);
  Future<void> setGrownUpPresent(bool v) => _prefs.setBool(_kGrownUp, v);

  Future<void> completeMission(String id, String badge) async {
    final c = completed..add(id);
    final b = badges..add(badge);
    await _prefs.setStringList(_kCompleted, c.toList());
    await _prefs.setStringList(_kBadges, b.toList());
  }

  Future<void> resetAll() async {
    await _prefs.remove(_kCompleted);
    await _prefs.remove(_kBadges);
    await _prefs.remove(_kAgePath);
    await _prefs.remove(_kGrownUp);
  }
}
