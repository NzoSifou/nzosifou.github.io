import 'dart:math';

import 'package:flutter/material.dart';

class ThirdSection extends StatelessWidget {
  const ThirdSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final baseSize = (constraints.maxHeight / 12).floorToDouble();
        final containerWidth = constraints.maxWidth;
        final containerHeight = constraints.maxHeight;

        int horizontalCount = (containerWidth / baseSize).floor();
        int verticalCount = (containerHeight / baseSize).floor();

        final rand = Random();

        List<String> normalBlocks = _generateBlockList(
          weights: {
            'assets/minecraft/deepslate.png': 64,
            'assets/minecraft/deepslate_iron_ore.png': 8,
            'assets/minecraft/deepslate_gold_ore.png': 8,
            'assets/minecraft/deepslate_redstone_ore.png': 7,
            'assets/minecraft/deepslate_lapis_lazuli_ore.png': 7,
            'assets/minecraft/deepslate_diamond_ore.png': 4,
            'assets/minecraft/deepslate_emerald_ore.png': 2,
          },
        );

        List<List<String>> grid = List.generate(verticalCount, (row) {
          if (row == verticalCount - 1) {
            // Last row = full bedrock
            return List.generate(
              horizontalCount,
              (_) => 'assets/minecraft/bedrock.png',
            );
          } else if (row == verticalCount - 2) {
            // Second to last row = 50% bedrock, 50% random
            return List.generate(horizontalCount, (_) {
              return rand.nextBool()
                  ? 'assets/minecraft/bedrock.png'
                  : normalBlocks[rand.nextInt(normalBlocks.length)];
            });
          } else {
            return List.generate(
              horizontalCount,
              (_) => normalBlocks[rand.nextInt(normalBlocks.length)],
            );
          }
        });

        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: horizontalCount,
            childAspectRatio: 1,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
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
    List<String> list = [];
    weights.forEach((key, weight) {
      list.addAll(List.generate(weight, (_) => key));
    });
    return list;
  }
}
