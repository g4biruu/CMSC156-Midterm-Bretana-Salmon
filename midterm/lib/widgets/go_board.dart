import 'package:flutter/material.dart';

class GoBoard extends StatelessWidget {

  final List<List<int>> board;
  final Function(int, int) onTap;

  const GoBoard({
    super.key,
    required this.board,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    const int size = 9;

    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        itemCount: size * size,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size,
        ),
        itemBuilder: (context, index) {

          int x = index % size;
          int y = index ~/ size;

          return GestureDetector(
            onTap: () => onTap(x, y),

            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.brown[300],
              ),
              child: _buildStone(board[y][x]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStone(int value) {

    if (value == 0) return SizedBox();

    return Center(
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value == 1 ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}