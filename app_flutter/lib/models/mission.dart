/// Age paths a child can pick on the Age Path screen.
enum AgePath { four6, six8, nine12, grownUp }

extension AgePathX on AgePath {
  String get label => switch (this) {
        AgePath.four6 => '4-6 with grown-up',
        AgePath.six8 => '6-8',
        AgePath.nine12 => '9-12',
        AgePath.grownUp => 'Grown-up',
      };

  /// Storage key value.
  String get id => switch (this) {
        AgePath.four6 => '4-6',
        AgePath.six8 => '6-8',
        AgePath.nine12 => '9-12',
        AgePath.grownUp => 'grown-up',
      };

  static AgePath? fromId(String? v) => switch (v) {
        '4-6' => AgePath.four6,
        '6-8' => AgePath.six8,
        '9-12' => AgePath.nine12,
        'grown-up' => AgePath.grownUp,
        _ => null,
      };
}

class Mission {
  final String id;
  final int number;
  final String title;
  final String subtitle;
  final List<String> ageBands;
  final int timeMinutes;
  final String messLevel;
  final String skill; // starter | easy | medium
  final bool needsAdult;
  final List<String> items;
  final List<String> safety;
  final String effect;
  final List<String> steps;
  final String secret;
  final String showTip;
  final String asset;
  final String badge;

  const Mission({
    required this.id,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.ageBands,
    required this.timeMinutes,
    required this.messLevel,
    required this.skill,
    required this.needsAdult,
    required this.items,
    required this.safety,
    required this.effect,
    required this.steps,
    required this.secret,
    required this.showTip,
    required this.asset,
    required this.badge,
  });

  factory Mission.fromJson(Map<String, dynamic> j) {
    List<String> sl(dynamic v) =>
        (v as List? ?? const []).map((e) => e.toString()).toList();
    return Mission(
      id: j['id'] as String,
      number: (j['number'] as num).toInt(),
      title: j['title'] as String,
      subtitle: j['subtitle'] as String? ?? '',
      ageBands: sl(j['ageBands']),
      timeMinutes: (j['timeMinutes'] as num?)?.toInt() ?? 0,
      messLevel: j['messLevel'] as String? ?? 'none',
      skill: j['skill'] as String? ?? 'easy',
      needsAdult: j['needsAdult'] as bool? ?? false,
      items: sl(j['items']),
      safety: sl(j['safety']),
      effect: j['effect'] as String? ?? '',
      steps: sl(j['steps']),
      secret: j['secret'] as String? ?? '',
      showTip: j['showTip'] as String? ?? '',
      asset: j['asset'] as String? ?? '',
      badge: j['badge'] as String? ?? 'Badge',
    );
  }

  /// The asset path as bundled inside the Flutter app (we ship under assets/).
  String get bundledAsset => asset.startsWith('assets/') ? asset : 'assets/$asset';

  /// True if this mission has any age band requiring a grown-up.
  bool get isStarter => skill == 'starter';
}

/// Pure, testable age-filtering rules.
///
/// Rules (from the product spec):
///  - 4-6 path: only starter missions, all shown with grown-up labels.
///  - 6-8 path: starter + easy missions. 9-12-only missions are hidden
///    unless a grown-up is present.
///  - 9-12 path: everything.
///  - Grown-up path: everything.
class MissionFilter {
  static List<Mission> forAgePath(
    List<Mission> all,
    AgePath path, {
    bool grownUpPresent = false,
  }) {
    switch (path) {
      case AgePath.four6:
        return all.where((m) => m.skill == 'starter').toList();
      case AgePath.six8:
        return all.where((m) {
          if (m.skill == 'starter' || m.skill == 'easy') return true;
          // medium / 9-12-only content only when a grown-up is present
          return grownUpPresent;
        }).toList();
      case AgePath.nine12:
      case AgePath.grownUp:
        return List<Mission>.from(all);
    }
  }
}
