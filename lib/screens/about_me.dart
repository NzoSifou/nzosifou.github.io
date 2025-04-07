import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AboutMeScreen extends StatefulWidget {
  @override
  _AboutMeScreenState createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _scrolling = false;
  Duration duration = Duration(milliseconds: 500);

  void _onScroll(PointerScrollEvent event) async {
    if (_scrolling) return;
    _scrolling = true;

    if (event.scrollDelta.dy > 0 && _currentPage < 2) {
      _currentPage++;
    } else if (event.scrollDelta.dy < 0 && _currentPage > 0) {
      _currentPage--;
    }

    await _pageController.animateToPage(
      _currentPage,
      duration: duration,
      curve: Curves.easeInOut,
    );

    Future.delayed(duration, () {
      _scrolling = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) {
          _onScroll(event);
        }
      },
      child: PageView(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              const baseSize = 90.0;
              final containerWidth = constraints.maxWidth;
              final containerHeight = constraints.maxHeight;

              int horizontalCount = (containerWidth / baseSize).floor();
              if (horizontalCount == 0) horizontalCount = 1;

              int verticalCount = (containerHeight / baseSize).floor();
              if (verticalCount == 0) verticalCount = 1;

              final imageSize = min(
                containerWidth / horizontalCount,
                containerHeight / verticalCount,
              );

              // Init grid
              List<List<String>> grid = List.generate(
                verticalCount,
                    (_) => List.generate(horizontalCount, (_) => 'assets/minecraft/sky.png'),
              );

              // Determine where the line with image2 is (lineFromBottom == 3)
              final image2Row = verticalCount - 3;

              // Apply image2 and image3 rows
              for (int row = image2Row; row < verticalCount; row++) {
                for (int col = 0; col < horizontalCount; col++) {
                  grid[row][col] = row == image2Row
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

              Map<String, String> imageMap = {
                '1': 'assets/minecraft/sky.png',
                '2': 'assets/minecraft/grass_block.png',
                '3': 'assets/minecraft/dirt_block.png',
                '4': 'assets/minecraft/oak_leaves.png',
                '5': 'assets/minecraft/oak_log.png',
              };

              // Function to check if pattern can be placed
              bool canPlace(int startRow, int startCol, List<List<bool>> used) {
                for (int r = -1; r <= 7; r++) {
                  for (int c = -1; c <= 5; c++) {
                    int checkRow = startRow + r;
                    int checkCol = startCol + c;
                    if (checkRow < 0 || checkCol < 0 || checkRow >= verticalCount || checkCol >= horizontalCount) continue;
                    if (r >= 0 && r < 7 && c >= 0 && c < 5 && used[checkRow][checkCol]) return false;
                    if (r == -1 || r == 7 || c == -1 || c == 5) {
                      if (checkRow < verticalCount && checkCol < horizontalCount && used[checkRow][checkCol]) return false;
                    }
                  }
                }
                return true;
              }

              // Mark pattern
              void placePattern(int startRow, int startCol, List<List<bool>> used) {
                for (int r = 0; r < 7; r++) {
                  for (int c = 0; c < 5; c++) {
                    int row = startRow + r;
                    int col = startCol + c;
                    if (row < verticalCount && col < horizontalCount) {
                      grid[row][col] = imageMap[pattern[r][c]]!;
                      used[row][col] = true;
                    }
                  }
                }
              }

              // Try to place patterns randomly
              List<List<bool>> used = List.generate(
                verticalCount,
                    (_) => List.generate(horizontalCount, (_) => false),
              );

              List<Point<int>> allValidPositions = [];

              for (int row = 0; row <= image2Row - 7; row++) {
                for (int col = 0; col <= horizontalCount - 5; col++) {
                  if (canPlace(row, col, used)) {
                    allValidPositions.add(Point(row, col));
                  }
                }
              }

              final rand = Random();
              allValidPositions.shuffle(rand);

              int maxPatterns = allValidPositions.length;
              int numToPlace = rand.nextInt(maxPatterns) + 1; // At least 1

              for (int i = 0; i < numToPlace; i++) {
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
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1,
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
                      return SizedBox(
                        width: size,
                        height: size,
                        child: child,
                      );
                    },
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            },
          ),
          Container(color: Theme.of(context).colorScheme.primaryContainer),
          Container(color: Theme.of(context).colorScheme.tertiaryContainer),
        ],
      ),
    );
  }
}