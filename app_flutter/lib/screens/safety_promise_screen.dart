import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/providers.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class SafetyPromiseScreen extends ConsumerWidget {
  const SafetyPromiseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promises = [
      (Icons.local_fire_department_outlined, 'No fire'),
      (Icons.content_cut_outlined, 'No sharp stuff'),
      (Icons.family_restroom, 'Ask a grown-up'),
      (Icons.cleaning_services_outlined, 'Clean up after'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Our Magic Promise')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Text('Every mission is safe. Here is our promise:',
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  children: promises
                      .map((p) => Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(p.$1, size: 56, color: TQColors.purple),
                                const SizedBox(height: 10),
                                Text(p.$2,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),
              BigButton("I'm ready",
                  icon: Icons.check_circle_outline,
                  onPressed: () => context.go('/home')),
            ],
          ),
        ),
      ),
    );
  }
}
