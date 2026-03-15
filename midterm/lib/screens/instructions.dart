import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to Play Go"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            '''
GO (Baduk) - Basic Rules

1. The game is played on a 9x9 board.

2. Two players take turns placing stones:
   • Black goes first
   • White goes second

3. Stones are placed on intersections of the board lines.

4. Stones stay on the board unless they are captured.

5. A group of stones is captured when all of its liberties
   (empty adjacent spaces) are filled by the opponent.

6. Captured stones are removed from the board.

7. Players may also choose to PASS their turn.

8. The game ends when both players pass.

9. The player who controls the most territory wins.

Territory = empty spaces surrounded by your stones.
            ''',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}