import 'package:flutter/material.dart';

/// Small flame + numeric severity indicator (severity is an integer 1–10).
class SeverityBadge extends StatelessWidget {
  const SeverityBadge({super.key, required this.severity});

  final double severity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.local_fire_department,
            size: 18, color: Color(0xFFEC4899)),
        const SizedBox(width: 2),
        Text(
          severity.round().toString(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
