import 'dart:math';

import 'package:flutter/cupertino.dart';

class SecondSection extends StatelessWidget {
  const SecondSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final baseSize = (constraints.maxHeight / 12).floorToDouble();
        final containerWidth = constraints.maxWidth;
        final containerHeight = constraints.maxHeight;

        final horizontalCount = (containerWidth / baseSize).floor();
        final verticalCount = (containerHeight / baseSize).floor();

        final rand = Random();

        final topHalf = _generateBlockList(
          weights: {
            'assets/minecraft/stone.png': 60,
            'assets/minecraft/coal_ore.png': 15,
            'assets/minecraft/copper_ore.png': 10,
            'assets/minecraft/iron_ore.png': 10,
            'assets/minecraft/gold_ore.png': 5,
          },
        );

        final bottomHalf = _generateBlockList(
          weights: {
            'assets/minecraft/stone.png': 50,
            'assets/minecraft/coal_ore.png': 5,
            'assets/minecraft/copper_ore.png': 5,
            'assets/minecraft/iron_ore.png': 5,
            'assets/minecraft/gold_ore.png': 10,
            'assets/minecraft/redstone_ore.png': 10,
            'assets/minecraft/lapis_lazuli_ore.png': 8,
            'assets/minecraft/diamond_ore.png': 5,
            'assets/minecraft/emerald_ore.png': 2,
          },
        );

        final grid = List.generate(
          verticalCount,
              (row) => List.generate(
            horizontalCount,
                (_) =>
            row < (verticalCount / 2)
                ? topHalf[rand.nextInt(topHalf.length)]
                : bottomHalf[rand.nextInt(bottomHalf.length)],
          ),
        );

        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: horizontalCount,
          ),
          itemCount: verticalCount * horizontalCount,
          itemBuilder: (context, index) {
            final row = index ~/ horizontalCount;
            final col = index % horizontalCount;
            final imagePath = grid[row][col];
            return Image.asset(imagePath, fit: BoxFit.cover);
          },
        );
      },
    );
  }

  List<String> _generateBlockList({required Map<String, int> weights}) {
    final list = <String>[];
    weights.forEach((key, weight) {
      list.addAll(List.generate(weight, (_) => key));
    });
    return list;
  }
}
