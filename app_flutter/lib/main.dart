import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/progress_store.dart';
import 'data/providers.dart';
import 'router.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await ProgressStore.create();

  runApp(
    ProviderScope(
      overrides: [
        progressStoreProvider.overrideWithValue(store),
      ],
      child: const TadaQuestApp(),
    ),
  );
}

class TadaQuestApp extends StatelessWidget {
  const TadaQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tada Quest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: appRouter,
    );
  }
}
