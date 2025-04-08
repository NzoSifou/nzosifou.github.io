import 'package:flutter/material.dart';

class TimelineStep extends StatelessWidget {
  const TimelineStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isLeft = true,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withAlpha(26),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              if (isLeft)
                Icon(
                  icon,
                  size: 32,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: isLeft ? TextAlign.left : TextAlign.right,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              if (!isLeft)
                Icon(
                  icon,
                  size: 32,
                  color: Theme.of(context).colorScheme.secondary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
