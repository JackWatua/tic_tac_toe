import 'dart:io';
import 'dart:math';

main() {
  print("Choose a player lable : enter X or O ");

  String player_label = stdin.readLineSync().toString();

  player_label = player_label.toUpperCase();
//if player chooses x assign computer o and vice versa
  if (player_label == "X") {
    player_lable = " X ";
    computer_lable = " O ";
  } else if (player_label == "O") {
    player_lable = " O ";
    computer_lable = " X ";
  }

  print("You : $player_label");
  print("Computer : $computer_lable");
  print("\n\n");
  //call the playgame function which accepts one argument (number of rounds).
  playGame(3); // play 3 rounds;
}

//Create an empty playboard (a 3 by 3 matrice). used to diplay player moves
List playboard = [
  ["\' \'", "\' \'", "\' \'"],
  ["\' \'", "\' \'", "\' \'"],
  ["\' \'", "\' \'", "\' \'"],
];

//make a list of valid play options

List valid_play_options = ["X", "O"];

//Stores the computer player label: if player chooses x set computer lable to y
var player_lable = " P ";
var computer_lable = " C ";
//set wins and draws to 0

int computer_Wins = 0; //set computer wins to 0

int draws = 0; // set draws to 0

int player_wins = 0; //set player wins to 0
//make a list of posible moves

List play_options = [
  [1, 0],
  [0, 0],
  [0, 1],
  [0, 2],
  [1, 1],
  [1, 2],
  [2, 0],
  [2, 1],
  [2, 2]
];

//below is a function that prints out a list showing player moves
void print_play_board(List playboard) {
  for (var i in playboard) {
    print(i);
  }
}

//Player moves

player1_move() {
  int sample_move = Random().nextInt(play_options.length - 1);
  if (!checkfilledBoard()) {
    //Check if board is not filled and proceed to play
    while (true) {
      try {
        print(
            "Your ($player_lable) turn, Enter move eg. (${play_options[sample_move][0]}, ${play_options[sample_move][1]})"); // ask user to enter a move (x, y)
        String player_move = stdin.readLineSync().toString();
        int player_x = int.parse(player_move.split(',')[0]);
        int player_y = int.parse(player_move.split(',')[1]);
        if (check_move(player_x, player_y)) {
          //checks if playboard [x][y] is empty
          playboard[player_x][player_y] = player_lable;
          break;
        } else {
          print(
              "You played ($player_x, $player_y) but the position alraedy filled!");
          continue;
        }
      } catch (FormatError) {
        print(
            "Rules: Moves must be numeric and separated by a comma. Both numbers should range from 0 -2!!!");
      }
    }
  }
}

//Computer moves
computer_player_move() {
  //set computer move to random
  int comp_x = Random().nextInt(3);
  int comp_y = Random().nextInt(3);
  if (!checkfilledBoard()) {
    //Check if board is not filled and allow the computer to play
    while (true) {
      if (check_move(comp_x, comp_y)) {
        //checks if playboard [x][y] is empty
        playboard[comp_x][comp_y] = computer_lable;
        break;
      } else {
        //if playboard[x][y] is not empty reset computer move
        comp_x = Random().nextInt(3);
        comp_y = Random().nextInt(3);
      }
    }
  }
}

//Create a function that checks if a bord is filled.
bool checkfilledBoard() {
  for (var i in playboard) {
    for (var t in i) {
      if (t == "\' \'") {
        //if there are still empty spaces in the playboard return false
        return false;
      } else {
        continue; // else do nothing
      }
    }
  }
  return true; // return true if there are no empty spaces in the playboard
}

//Create a function that ckecks if a position in the playboard is already filled by another player

bool check_move(int x, int y) {
  if (playboard[x][y] != "\' \'") {
    return false; // if player enters a move that is already played. return false
  } else {
    return true; // else return true
  }
}

//Bellow is a function that checks whether the 3 by 3 rows or colums and diagonal have the same item
bool check_win(player_move) {
  if (playboard[0][0] == player_move &&
      playboard[0][1] == player_move &&
      playboard[0][2] == player_move) {
    return true;
  } else if (playboard[1][0] == player_move &&
      playboard[1][1] == player_move &&
      playboard[1][2] == player_move) {
    return true;
  } else if (playboard[2][0] == player_move &&
      playboard[2][1] == player_move &&
      playboard[2][2] == player_move) {
    return true;
  } else if (playboard[0][0] == player_move &&
      playboard[1][0] == player_move &&
      playboard[2][0] == player_move) {
    return true;
  } else if (playboard[0][1] == player_move &&
      playboard[1][1] == player_move &&
      playboard[2][1] == player_move) {
    return true;
  } else if (playboard[0][2] == player_move &&
      playboard[1][2] == player_move &&
      playboard[2][2] == player_move) {
    return true;
  } else if (playboard[0][0] == player_move &&
      playboard[1][1] == player_move &&
      playboard[2][2] == player_move) {
    return true;
  } else if (playboard[0][2] == player_move &&
      playboard[1][1] == player_move &&
      playboard[2][0] == player_move) {
    return true;
  } else {
    return false;
  }
}

//create a function that resests the playboard to empty cels if a round is finished
List restPlayboard(List playboard) {
  playboard = [
    ["\' \'", "\' \'", "\' \'"],
    ["\' \'", "\' \'", "\' \'"],
    ["\' \'", "\' \'", "\' \'"],
  ];
  return playboard;
}

//Create a function that allows both the user and the computer to play.
//call player1_move and computerPlayer_move()

void playGame(int rounds) {
  Function bothPlayerMoves = () {
    while (true) {
      player1_move();
      computer_player_move();
      print_play_board(playboard);
      if (check_win(player_lable) ||
          check_win(computer_lable) ||
          checkfilledBoard()) {
        if (check_win(player_lable)) {
          print("You win");
          playboard = restPlayboard(playboard);
          player_wins += 1;
          break;
        } else if (check_win(computer_lable)) {
          print("Comp wins");
          playboard = restPlayboard(playboard);
          computer_Wins += 1;
          break;
        } else {
          print("Game over board filled. It is a draw");
          playboard = restPlayboard(playboard);
          draws += 1;
          break;
        }
      } else {
        continue;
      }
    }
  };
  for (var i = 0; i < rounds; i++) {
    print("_____________________Round ${i + 1}_____________________________");
    bothPlayerMoves();
    print("Your wins : $player_wins");
    print("Computer wins : $computer_Wins");
    print("Draws $draws");
    print(
        "_____________________Round ${i + 1} ends_____________________________");
  }
}
