import 'package:flutter/material.dart';

class GoBoard extends StatefulWidget {
  final List<List<int>> board;
  final Function(int, int) onTap;
  final int currentPlayer;

  const GoBoard({
    super.key,
    required this.board,
    required this.onTap,
    required this.currentPlayer,
  });

  @override
  State<GoBoard> createState() => _GoBoardState();
}

class _GoBoardState extends State<GoBoard> {
  int? selectedX;
  int? selectedY;

  void _showConfirmDialog(int x, int y) {
    int player = widget.currentPlayer;
    String playerColor = player == 1 ? "Black" : "White";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Move"),
        content: Text("Place $playerColor stone at intersection ($x, $y)?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onTap(x, y);
              setState(() {
                selectedX = null;
                selectedY = null;
              });
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const int size = 9;
    const double padding = 20; // Consistent padding

    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate board size accounting for padding
          double totalSize = constraints.maxWidth;
          double boardSize = totalSize - (padding * 2);
          double cellSize = boardSize / (size - 1);
          double stoneRadius = cellSize * 0.35;

          return Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(padding),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD2B48C),
                border: Border.all(color: Colors.black, width: 6),
              ),
              child: GestureDetector(
                onTapDown: (details) {
                  double dx = details.localPosition.dx;
                  double dy = details.localPosition.dy;

                  int x = (dx / cellSize).round().clamp(0, size - 1);
                  int y = (dy / cellSize).round().clamp(0, size - 1);

                  // Prevent placing stones on border (x=0, x=8, y=0, y=8)
                  bool isOnBorder = (x == 0 || x == size - 1) || (y == 0 || y == size - 1);

                  if (!isOnBorder && widget.board[y][x] == 0) {
                    _showConfirmDialog(x, y);
                  }
                },
                child: CustomPaint(
                  painter: GoBoardPainter(
                    board: widget.board,
                    size: size,
                    cellSize: cellSize,
                    stoneRadius: stoneRadius,
                  ),
                  size: Size(boardSize, boardSize),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GoBoardPainter extends CustomPainter {
  final List<List<int>> board;
  final int size;
  final double cellSize;
  final double stoneRadius;

  GoBoardPainter({
    required this.board,
    required this.size,
    required this.cellSize,
    required this.stoneRadius,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    // Draw board background
    Paint bgPaint = Paint()
      ..color = Color(0xFFD2B48C)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, canvasSize.width, canvasSize.height),
      bgPaint,
    );

    // Draw board lines
    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    for (int i = 0; i < size; i++) {
      double pos = i * cellSize;

      // Horizontal lines
      canvas.drawLine(
        Offset(0, pos),
        Offset(canvasSize.width, pos),
        linePaint,
      );

      // Vertical lines
      canvas.drawLine(
        Offset(pos, 0),
        Offset(pos, canvasSize.height),
        linePaint,
      );
    }

    // Draw stones at intersections
    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        int cell = board[y][x];
        if (cell != 0) {
          double posX = x * cellSize;
          double posY = y * cellSize;

          // Determine if stone is captured (negative value)
          bool isCaptured = cell < 0;
          int stoneColor = isCaptured ? -cell : cell;
          double opacity = isCaptured ? 0.3 : 1.0;

          Paint stonePaint = Paint()
            ..color = (stoneColor == 1 ? Colors.black : Colors.white).withOpacity(opacity)
            ..style = PaintingStyle.fill;

          Paint stoneBorderPaint = Paint()
            ..color = Colors.black.withOpacity(opacity)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5;

          canvas.drawCircle(Offset(posX, posY), stoneRadius, stonePaint);
          canvas.drawCircle(Offset(posX, posY), stoneRadius, stoneBorderPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(GoBoardPainter oldDelegate) {
    return oldDelegate.board != board;
  }
}