import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

/// A large, rounded, kid-friendly primary button.
class BigButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final IconData? icon;
  const BigButton(this.label,
      {super.key, this.onPressed, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: color == null
          ? null
          : ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[Icon(icon, size: 28), const SizedBox(width: 10)],
          Flexible(child: Text(label, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}

/// Renders a bundled SVG, with a friendly fallback if missing.
class MissionArt extends StatelessWidget {
  final String assetPath;
  final double size;
  const MissionArt(this.assetPath, {super.key, this.size = 96});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      placeholderBuilder: (_) =>
          Icon(Icons.auto_awesome, size: size, color: TQColors.sun),
    );
  }
}

class SafetyChip extends StatelessWidget {
  final String text;
  const SafetyChip(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: TQColors.mint.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shield_outlined, size: 18, color: TQColors.mint),
          const SizedBox(width: 6),
          Flexible(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

/// Grown-up label badge for missions needing adult help.
class AdultBadge extends StatelessWidget {
  const AdultBadge({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: TQColors.coral.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.family_restroom, size: 16, color: TQColors.coral),
          SizedBox(width: 4),
          Text('Grown-up helps',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: TQColors.coral)),
        ],
      ),
    );
  }
}
