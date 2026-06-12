import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:tada_quest/data/mission_repository.dart';
import 'package:tada_quest/models/mission.dart';

void main() {
  final raw = File('assets/content/missions.json').readAsStringSync();
  final repo = MissionRepository();
  final missions = repo.parse(raw);

  group('missions.json', () {
    test('parses all 12 missions', () {
      expect(missions.length, 12);
    });

    test('every mission has required fields', () {
      for (final m in missions) {
        expect(m.id.isNotEmpty, true);
        expect(m.title.isNotEmpty, true);
        expect(m.steps.isNotEmpty, true, reason: '${m.id} has steps');
        expect(m.safety.isNotEmpty, true, reason: '${m.id} has safety');
        expect(m.badge.isNotEmpty, true);
        expect(['starter', 'easy', 'medium'].contains(m.skill), true,
            reason: '${m.id} skill=${m.skill}');
      }
    });

    test('missions are number-ordered', () {
      for (var i = 0; i < missions.length; i++) {
        expect(missions[i].number, i + 1);
      }
    });
  });

  group('age filtering', () {
    test('4-6 path shows only starter missions', () {
      final r = MissionFilter.forAgePath(missions, AgePath.four6);
      expect(r.every((m) => m.skill == 'starter'), true);
      expect(r.isNotEmpty, true);
    });

    test('6-8 path hides medium missions when no grown-up', () {
      final r = MissionFilter.forAgePath(missions, AgePath.six8,
          grownUpPresent: false);
      expect(r.any((m) => m.skill == 'medium'), false);
      // includes starter + easy
      expect(r.any((m) => m.skill == 'starter'), true);
      expect(r.any((m) => m.skill == 'easy'), true);
    });

    test('6-8 path reveals medium missions when grown-up present', () {
      final r = MissionFilter.forAgePath(missions, AgePath.six8,
          grownUpPresent: true);
      expect(r.any((m) => m.skill == 'medium'), true);
    });

    test('9-12 path shows all missions', () {
      final r = MissionFilter.forAgePath(missions, AgePath.nine12);
      expect(r.length, missions.length);
    });
  });

  group('safety invariants', () {
    // Whole-word match so innocent words like "matching" don't trip "match".
    test('no banned hazards in any mission', () {
      const banned = [
        'fire',
        'match',
        'candle',
        'lighter',
        'knife',
        'needle',
        'glass',
        'chemical',
        'medicine',
        'bleach',
      ];
      for (final m in missions) {
        final blob =
            (m.items.join(' ') + ' ' + m.steps.join(' ')).toLowerCase();
        for (final b in banned) {
          final re = RegExp('\\b${RegExp.escape(b)}\\b');
          expect(re.hasMatch(blob), false,
              reason: '${m.id} must not mention the hazard "$b"');
        }
      }
    });

    // Sharp tools (scissors) are allowed ONLY as grown-up prep: any mission
    // mentioning them must be flagged needsAdult with a grown-up safety note.
    test('scissors only appear in adult-gated missions', () {
      for (final m in missions) {
        final blob =
            (m.items.join(' ') + ' ' + m.steps.join(' ')).toLowerCase();
        if (RegExp(r'\bscissors\b').hasMatch(blob)) {
          expect(m.needsAdult, true,
              reason: '${m.id} uses scissors so must require a grown-up');
          expect(
            m.safety.any((s) => s.toLowerCase().contains('grown-up')),
            true,
            reason: '${m.id} must have a grown-up safety note for scissors',
          );
        }
      }
    });
  });
}
