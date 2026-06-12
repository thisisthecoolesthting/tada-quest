import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/splash_screen.dart';
import 'screens/age_path_screen.dart';
import 'screens/safety_promise_screen.dart';
import 'screens/mission_home_screen.dart';
import 'screens/mission_prep_screen.dart';
import 'screens/mission_step_screen.dart';
import 'screens/mission_secret_screen.dart';
import 'screens/mission_showtime_screen.dart';
import 'screens/mission_complete_screen.dart';
import 'screens/badge_book_screen.dart';
import 'screens/grown_up_gate_screen.dart';
import 'screens/grown_up_info_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (c, s) => const SplashScreen()),
    GoRoute(path: '/age', builder: (c, s) => const AgePathScreen()),
    GoRoute(path: '/safety', builder: (c, s) => const SafetyPromiseScreen()),
    GoRoute(path: '/home', builder: (c, s) => const MissionHomeScreen()),
    GoRoute(
      path: '/mission/:id/prep',
      builder: (c, s) => MissionPrepScreen(missionId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: '/mission/:id/steps',
      builder: (c, s) => MissionStepScreen(missionId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: '/mission/:id/secret',
      builder: (c, s) => MissionSecretScreen(missionId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: '/mission/:id/showtime',
      builder: (c, s) =>
          MissionShowtimeScreen(missionId: s.pathParameters['id']!),
    ),
    GoRoute(
      path: '/mission/:id/complete',
      builder: (c, s) =>
          MissionCompleteScreen(missionId: s.pathParameters['id']!),
    ),
    GoRoute(path: '/badges', builder: (c, s) => const BadgeBookScreen()),
    GoRoute(path: '/grownup', builder: (c, s) => const GrownUpGateScreen()),
    GoRoute(path: '/grownup/info', builder: (c, s) => const GrownUpInfoScreen()),
  ],
  errorBuilder: (c, s) => const Scaffold(
    body: Center(child: Text('Lost? Tap back to go home.')),
  ),
);
