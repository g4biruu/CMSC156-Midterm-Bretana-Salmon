import 'package:flutter/material.dart';
import '../widgets/go_board.dart';
import '../models/board.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  final Board board = Board();

  int currentPlayer = 1;
  int blackCaptures = 0;
  int whiteCaptures = 0;

  void playMove(int x, int y) {
    setState(() {
      if (board.placeStone(x, y, currentPlayer)) {
        currentPlayer = currentPlayer == 1 ? 2 : 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],

      body: SafeArea(
        child: Column(
          children: [

            SizedBox(height: 20),

            // Captures row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Black", style: TextStyle(fontSize: 18)),
                    Text("Captives: $blackCaptures")
                  ],
                ),

                Column(
                  children: [
                    Text("White", style: TextStyle(fontSize: 18)),
                    Text("Captives: $whiteCaptures")
                  ],
                ),
              ],
            ),

            SizedBox(height: 10),

            // Turn indicator
            Text(
              currentPlayer == 1 ? "Turn: Black" : "Turn: White",
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 15),

            // Board
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: GoBoard(
                  board: board.grid,
                  onTap: playMove,
                ),
              ),
            ),

            SizedBox(height: 10),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  onPressed: () {},
                  child: Text("Pass"),
                ),

                ElevatedButton(
                  onPressed: () {},
                  child: Text("Confirm Move"),
                ),
              ],
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[400],
              ),
              child: Text("Resign"),
            ),

            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}