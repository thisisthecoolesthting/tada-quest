import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/mission.dart';

/// Loads and caches missions from the bundled JSON. No network access.
class MissionRepository {
  List<Mission>? _cache;
  Map<String, dynamic>? _meta;

  Future<List<Mission>> load() async {
    if (_cache != null) return _cache!;
    final raw = await rootBundle.loadString('assets/content/missions.json');
    final data = parse(raw);
    _cache = data;
    return data;
  }

  Map<String, dynamic> get meta => _meta ?? const {};

  /// Pure parse — used directly by tests without a Flutter binding.
  List<Mission> parse(String raw) {
    final map = jsonDecode(raw) as Map<String, dynamic>;
    _meta = {
      'appName': map['appName'],
      'tagline': map['tagline'],
      'privacyStance': map['privacyStance'],
    };
    final missions = (map['missions'] as List)
        .map((e) => Mission.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.number.compareTo(b.number));
    return missions;
  }
}
