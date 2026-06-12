import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/mission.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/mission_scaffold.dart';

class MissionStepScreen extends StatelessWidget {
  final String missionId;
  const MissionStepScreen({super.key, required this.missionId});

  @override
  Widget build(BuildContext context) {
    return MissionLoader(
      missionId: missionId,
      builder: (context, m) => _StepRunner(mission: m),
    );
  }
}

class _StepRunner extends StatefulWidget {
  final Mission mission;
  const _StepRunner({required this.mission});
  @override
  State<_StepRunner> createState() => _StepRunnerState();
}

class _StepRunnerState extends State<_StepRunner> {
  int _i = 0;
  bool _showHelp = false;

  @override
  Widget build(BuildContext context) {
    final m = widget.mission;
    final last = _i == m.steps.length - 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Step ${_i + 1} of ${m.steps.length}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: (_i + 1) / m.steps.length,
                minHeight: 10,
                backgroundColor: Colors.black12,
                color: TQColors.sun,
              ),
              const SizedBox(height: 20),
              MissionArt(m.bundledAsset, size: 120),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: Text(
                    m.steps[_i],
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              if (_showHelp)
                Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: TQColors.sky.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text('Hint: ${m.showTip}',
                      style: const TextStyle(fontSize: 15)),
                ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56)),
                      onPressed: _i == 0
                          ? () => context.go('/mission/${m.id}/prep')
                          : () => setState(() => _i--),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: last
                          ? () => context.go('/mission/${m.id}/secret')
                          : () => setState(() {
                                _i++;
                                _showHelp = false;
                              }),
                      icon: Icon(last
                          ? Icons.auto_awesome
                          : Icons.arrow_forward),
                      label: Text(last ? 'Show secret' : 'Next'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () => setState(() => _showHelp = !_showHelp),
                icon: const Icon(Icons.help_outline),
                label: Text(_showHelp ? 'Hide help' : 'Need help'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
