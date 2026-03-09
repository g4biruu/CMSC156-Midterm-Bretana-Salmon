import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Game',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              child: Text("Start Game"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Exit"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),
    );
  }
}