// Importing the material.dart package to access the widgets of Flutter framework
import 'package:flutter/material.dart';

// Main function to run the app
void main() {
  // Running TicTacToeApp class
  runApp(const TicTacToeApp());
}

// Tic Tac Toe App widget that uses StatelessWidget
class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Returning a MaterialApp widget, which contains basic configurations of Material Design
    // and mentioning home property, which is set to TicTacToe widget
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      home: TicTacToe(),
    );
  }
}

// Tic Tac Toe game widget that uses StatefulWidget
class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  TicTacToeState createState() => TicTacToeState();
}

// The state of TicTacToe widget that updates based on user input
class TicTacToeState extends State<TicTacToe> {
  // A list of empty strings representing the initial state of each box on the tic tac toe board
  List<String> gameState = ['', '', '', '', '', '', '', '', ''];
  // Boolean value that lets us know whose turn is it
  bool xTurn = true;
  bool isWinnedNow = false;
  String winMessage = '';
  String turn = 'Player X turn';
  double winMessageFontSize = 40;
  @override
  Widget build(BuildContext context) {
    // Scaffold widget with AppBar at the top, having the title as “Tic Tac Toe”,
    // and a Center widget which has a Column widget containing all 9 boxes of the tic tac toe board
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              turn,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButton(0),
                buildButton(1),
                buildButton(2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButton(3),
                buildButton(4),
                buildButton(5),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButton(6),
                buildButton(7),
                buildButton(8),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              winMessage,
              style: TextStyle(
                color: Colors.green,
                fontSize: winMessageFontSize,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  xTurn = true;
                  isWinnedNow = false;
                  for (int i = 0; i < 9; i++) {
                    gameState[i] = '';
                  }
                  winMessage = '';
                  turn = 'Player X turn';
                });
              },
              child: const Text('Reset!'),
            ),
          ],
        ),
      ),
    );
  }

  // A function that returns ElevatedButton widget in terms of size (width, height), text and a function call to update the game state and to let the next player make their move
  Widget buildButton(int index) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          isWinnedNow
              ? () {}
              : setState(() {
                  if (gameState[index] == '' && xTurn) {
                    gameState[index] = 'X';
                    xTurn = !xTurn;
                    isWinnedNow = isWinned(gameState);
                    if (isWinnedNow) {
                      winMessage = 'Player X Won!';
                      turn = '';
                    } else {
                      turn = 'Player O turn';
                    }
                  } else if (gameState[index] == '' && !xTurn) {
                    gameState[index] = 'O';
                    xTurn = !xTurn;
                    isWinnedNow = isWinned(gameState);
                    if (isWinnedNow) {
                      winMessage = 'Player O Won!';
                      turn = '';
                    } else {
                      turn = 'Player X turn';
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('This square is not empty!'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    );
                  }
                  bool flag = false;
                  for (int i = 0; i < 9; i += 1) {
                    if (gameState[i] == '') {
                      flag = true;
                    }
                  }
                  if (!flag && !isWinnedNow) {
                    winMessageFontSize = 27;
                    winMessage = 'Ooops! As smart as each other!';
                    turn = '';
                  }
                });
        },
        child: Text(
          gameState[index],
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

bool isWinned(List<String> gameState) {
  if (gameState[0] == gameState[4] &&
      gameState[4] == gameState[8] &&
      gameState[0] != '') {
    return true;
  } else if (gameState[2] == gameState[4] &&
      gameState[4] == gameState[6] &&
      gameState[2] != '') {
    return true;
  } else if (gameState[1] == gameState[4] &&
      gameState[4] == gameState[7] &&
      gameState[1] != '') {
    return true;
  } else if (gameState[0] == gameState[3] &&
      gameState[3] == gameState[6] &&
      gameState[0] != '') {
    return true;
  } else if (gameState[2] == gameState[5] &&
      gameState[5] == gameState[8] &&
      gameState[2] != '') {
    return true;
  } else if (gameState[0] == gameState[1] &&
      gameState[1] == gameState[2] &&
      gameState[0] != '') {
    return true;
  } else if (gameState[3] == gameState[4] &&
      gameState[4] == gameState[5] &&
      gameState[3] != '') {
    return true;
  } else if (gameState[6] == gameState[7] &&
      gameState[7] == gameState[8] &&
      gameState[6] != '') {
    return true;
  }
  return false;
}
