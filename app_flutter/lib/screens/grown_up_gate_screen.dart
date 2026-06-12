import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

/// Grown-up gate: hold the button for 3 seconds. No birthdate (which would
/// just teach kids to fake age). Pure interaction gate, nothing stored.
class GrownUpGateScreen extends StatefulWidget {
  const GrownUpGateScreen({super.key});
  @override
  State<GrownUpGateScreen> createState() => _GrownUpGateScreenState();
}

class _GrownUpGateScreenState extends State<GrownUpGateScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(seconds: 3))
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed && mounted) {
          context.go('/grownup/info');
        }
      });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grown-ups only')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 72, color: TQColors.purple),
              const SizedBox(height: 16),
              const Text(
                'Grown-up check',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              const Text(
                'Press and HOLD the button for 3 seconds to open the grown-up area.',
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTapDown: (_) => _c.forward(),
                onTapUp: (_) => _c.reverse(),
                onTapCancel: () => _c.reverse(),
                child: AnimatedBuilder(
                  animation: _c,
                  builder: (context, _) => Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.lerp(
                          TQColors.sky, TQColors.coral, _c.value),
                    ),
                    child: Center(
                      child: Text(
                        _c.value == 0
                            ? 'Hold'
                            : '${(3 * (1 - _c.value)).ceil()}',
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.go('/home'),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
