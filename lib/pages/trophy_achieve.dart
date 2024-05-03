import 'package:flutter/material.dart';

class AchievementWidget extends StatelessWidget {
  final String title;
  final int points;
  final Color trophyColor;

  const AchievementWidget({
    Key? key,
    required this.title,
    required this.points,
    this.trophyColor = Colors.yellow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Icon(
            Icons.emoji_events,
            color: trophyColor,
            size: 40,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Points: $points',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
