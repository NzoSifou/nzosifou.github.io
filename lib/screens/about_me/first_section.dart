import 'dart:math';

import 'package:flutter/material.dart';

class FirstSection extends StatelessWidget {
  const FirstSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const blockHeight = 11;
        final baseSize =
        (constraints.maxHeight / blockHeight).floorToDouble();
        final containerWidth = constraints.maxWidth;
        final containerHeight = constraints.maxHeight;

        var horizontalCount = (containerWidth / baseSize).floor();
        if (horizontalCount == 0) horizontalCount = 1;

        var verticalCount = (containerHeight / baseSize).floor();
        if (verticalCount == 0) verticalCount = 1;

        final imageSize = min(
          containerWidth / horizontalCount,
          containerHeight / verticalCount,
        );

        // Init grid
        final grid = List<List<String>>.generate(
          verticalCount,
              (_) => List.generate(
            horizontalCount,
                (_) => 'assets/minecraft/sky.png',
          ),
        );

        // Determine where the line with image2 is (lineFromBottom == 3)
        final image2Row = verticalCount - 3;

        // Apply image2 and image3 rows
        for (var row = image2Row; row < verticalCount; row++) {
          for (var col = 0; col < horizontalCount; col++) {
            grid[row][col] =
            row == image2Row
                ? 'assets/minecraft/grass_block.png'
                : 'assets/minecraft/dirt_block.png';
          }
        }

        // Pattern definition (7x5)
        final pattern = [
          ['1', '4', '4', '4', '1'],
          ['1', '4', '4', '4', '1'],
          ['4', '4', '4', '4', '4'],
          ['4', '4', '4', '4', '4'],
          ['1', '1', '5', '1', '1'],
          ['1', '1', '5', '1', '1'],
          ['1', '1', '5', '1', '1'],
        ];

        final imageMap = <String, String>{
          '1': 'assets/minecraft/sky.png',
          '2': 'assets/minecraft/grass_block.png',
          '3': 'assets/minecraft/dirt_block.png',
          '4': 'assets/minecraft/oak_leaves.png',
          '5': 'assets/minecraft/oak_log.png',
        };

        // Function to check if pattern can be placed
        bool canPlace(int startRow, int startCol, List<List<bool>> used) {
          for (var r = -1; r <= 7; r++) {
            for (var c = -1; c <= 5; c++) {
              final checkRow = startRow + r;
              final checkCol = startCol + c;
              if (checkRow < 0 ||
                  checkCol < 0 ||
                  checkRow >= verticalCount ||
                  checkCol >= horizontalCount) {
                continue;
              }
              if (r >= 0 &&
                  r < 7 &&
                  c >= 0 &&
                  c < 5 &&
                  used[checkRow][checkCol]) {
                return false;
              }
              if (r == -1 || r == 7 || c == -1 || c == 5) {
                if (checkRow < verticalCount &&
                    checkCol < horizontalCount &&
                    used[checkRow][checkCol]) {
                  return false;
                }
              }
            }
          }
          return true;
        }

        // Mark pattern
        void placePattern(
            int startRow,
            int startCol,
            List<List<bool>> used,
            ) {
          for (var r = 0; r < 7; r++) {
            for (var c = 0; c < 5; c++) {
              final row = startRow + r;
              final col = startCol + c;
              if (row < verticalCount && col < horizontalCount) {
                grid[row][col] = imageMap[pattern[r][c]]!;
                used[row][col] = true;
              }
            }
          }
        }

        // Try to place patterns randomly
        final used = List.generate(
          verticalCount,
              (_) => List.generate(horizontalCount, (_) => false),
        );

        final allValidPositions = <Point<int>>[];

        final fixedPatternStartRow = verticalCount - 5 - 5;
        if (fixedPatternStartRow >= 0) {
          for (var col = 0; col <= horizontalCount - 5; col++) {
            if (canPlace(fixedPatternStartRow, col, used)) {
              allValidPositions.add(Point(fixedPatternStartRow, col));
            }
          }
        }

        final rand = Random();
        allValidPositions.shuffle(rand);

        final maxPatterns = allValidPositions.length;
        final numToPlace = rand.nextInt(maxPatterns) + 1; // At least 1

        for (var i = 0; i < numToPlace; i++) {
          final pos = allValidPositions[i];
          if (canPlace(pos.x, pos.y, used)) {
            placePattern(pos.x, pos.y, used);
          }
        }

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
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: imageSize, end: imageSize),
              duration: const Duration(milliseconds: 300),
              builder: (context, size, child) {
                return SizedBox(width: size, height: size, child: child);
              },
              child: Image.asset(imagePath, fit: BoxFit.cover),
            );
          },
        );
      },
    );
  }
}
