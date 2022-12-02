import 'dart:async';
import 'dart:io';

void main() async {
  print("AMDG");
  print("puzzle 1 answer: ${await calculateTotalScore()}");
  print("puzzle 2 answer: ${await calculateTotalResult()}");
}

Future<List> readFile() async {
  return await File('jack_n_poy_input.txt').readAsLines();
}

Future<int> calculateTotalScore() async {
  List lines = await readFile();
  int result = 0;
  lines.forEach((element) {
    List strategies = element.split(" ");
    result += calculateScore(strategies);
  });
  return result;
}

Future<int> calculateTotalResult() async {
  List lines = await readFile();
  int result = 0;
  lines.forEach((element) {
    List strategies = element.split(" ");
    result += calculateRoundResult(strategies);
  });
  return result;
}

int calculateScore(List strategies) {
  String opponentMove = attackEquivalent[strategies[0]];
  String myMove = attackEquivalent[strategies[1].trim()];
  int result = evaluateAttacks(opponentMove, myMove);
  return result;
}

int evaluateAttacks(String opponentMove, String myMove) {
  if (opponentMove == myMove) {
    return (3 + attackValue[myMove]) as int;
  }
  return attackTruth["${opponentMove}v$myMove"] + attackValue[myMove];
}

int calculateRoundResult(List strategies) {
  String opponentMove = attackEquivalent[strategies[0]];
  int myResult = roundResult[strategies[1].trim()];
  int result = evaluateResult(opponentMove, myResult);
  return result;
}

int evaluateResult(String opponentMove, int myResult) {
  if (myResult == 3) {
    return (myResult + attackValue[opponentMove]) as int;
  } else {
    var found = attackTruth.entries.where((element) =>
        element.key.split("v").first.contains(opponentMove) &&
        element.value == myResult);
    return (myResult + attackValue[found.first.key.split("v").last]) as int;
  }
}

const Map attackEquivalent = {
  "A": "rock",
  "X": "rock",
  "B": "paper",
  "Y": "paper",
  "C": "scissors",
  "Z": "scissors",
};

const Map attackValue = {
  "rock": 1,
  "paper": 2,
  "scissors": 3,
};

const Map attackTruth = {
  "rockvpaper": 6,
  "papervrock": 0,
  "rockvscissors": 0,
  "scissorsvrock": 6,
  "papervscissors": 6,
  "scissorsvpaper": 0,
};

const Map roundResult = {
  "X": 0,
  "Y": 3,
  "Z": 6,
};
