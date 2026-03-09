import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Placeholder for the actual game
          Center(
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text("Game Placeholder"),
              ),
            ),
          ),

          SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                onPressed: () {},
                child: Text("Confirm Attack"),
              ),

              SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {},
                child: Text("Cancel Attack"),
              ),

              SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Resign"),
              ),

            ],
          ),

        ],
      ),
    );
  }
}