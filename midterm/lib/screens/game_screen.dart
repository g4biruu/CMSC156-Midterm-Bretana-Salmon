import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../widgets/go_board.dart';
import '../models/board.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Board board = Board();

  int currentPlayer = 1; // 1 = Black, 2 = White
  int consecutivePasses = 0;
  bool gameOver = false;

  void playMove(int x, int y) {
    setState(() {
      if (board.placeStone(x, y, currentPlayer)) {
        consecutivePasses = 0;
        currentPlayer = currentPlayer == 1 ? 2 : 1;
      }
    });
  }

  void passMove() {
    setState(() {
      consecutivePasses++;
      if (consecutivePasses >= 2) {
        gameOver = true;
      } else {
        currentPlayer = currentPlayer == 1 ? 2 : 1;
      }
    });
  }

  void resetGame() {
    setState(() {
      board.reset();
      currentPlayer = 1;
      consecutivePasses = 0;
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int blackStones = board.countCaptures(1);
    int whiteStones = board.countCaptures(2);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Go Game"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),

            // Player scores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Black",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: currentPlayer == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    Text("Stones: $blackStones", style: TextStyle(fontSize: 16))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "White",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: currentPlayer == 2
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    Text("Stones: $whiteStones", style: TextStyle(fontSize: 16))
                  ],
                ),
              ],
            ),

            SizedBox(height: 10),

            // Turn indicator
            if (!gameOver)
              Text(
                currentPlayer == 1 ? "Turn: Black" : "Turn: White",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            else
              Text(
                "Game Over!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

            SizedBox(height: 15),

            // Game Board
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: GoBoard(
                  board: board.grid,
                  onTap: gameOver ? (x, y) {} : playMove,
                  currentPlayer: currentPlayer,
                ),
              ),
            ),

            SizedBox(height: 15),

            // Game Buttons
            if (!gameOver)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: passMove,
                    icon: Icon(Icons.skip_next),
                    label: Text("Pass"),
                  ),
                  ElevatedButton.icon(
                    onPressed: resetGame,
                    icon: Icon(Icons.restart_alt),
                    label: Text("Reset Game"),
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: resetGame,
                    icon: Icon(Icons.restart_alt),
                    label: Text("Play Again"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.exit_to_app),
                    label: Text("Main Menu"),
                  ),
                ],
              ),

            SizedBox(height: 10),

            if (!gameOver)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    gameOver = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
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