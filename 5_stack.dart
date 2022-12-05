import 'dart:async';
import 'dart:io';

void main() async {
  final inputs = await readFile();
  final stacks = inputToStacks(inputs);
  final moves = inputToMoves(inputs);
  moves.forEach((move) {
    processMove(move, stacks, isFILO: false);
  });
  stacks.forEach((stack) {
    print(stack);
  });
  final result = getTopStack(stacks);
  print("AMDG $result");
}

Future<List> readFile() async {
  return await File('stack_input.txt').readAsLines();
}

List<List> inputToStacks(List inputs) {
  List<List> stacks = [];
  int separationIndex =
      inputs.indexWhere((element) => element.toString().isEmpty);
  for (var i = separationIndex; i >= 0; i--) {
    final lines = inputs[i].toString().split('');
    int stackIndex = 0;
    for (var j = 1; j <= lines.length; j++) {
      if (int.tryParse(lines[j]) != null) {
        stacks.add([]);
      } else if (lines[j] != " ") {
        stacks[stackIndex].add(lines[j]);
      }
      stackIndex += 1;
      j += 3;
    }
  }
  return stacks;
}

List inputToMoves(List inputs) {
  int separationIndex =
      inputs.indexWhere((element) => element.toString().isEmpty);
  return inputs.sublist(separationIndex + 1, inputs.length);
}

void processMove(String move, List<List> stacks, {bool isFILO = true}) {
  //move 2 from 2 to 7
  // number of items, stack to stack
  final moves = move
      .split(" ")
      .where((element) => int.tryParse(element) != null)
      .toList();
  int items = int.parse(moves[0]);
  int origin = int.parse(moves[1]) - 1;
  int destination = int.parse(moves[2]) - 1;

  //
  List originStack = stacks[origin];
  List destinationStack = stacks[origin];
  stacks[origin] = originStack.sublist(0, originStack.length - items);
  stacks[destination] = [
    ...stacks[destination],
    if (isFILO)
      ...originStack
          .sublist(originStack.length - items, originStack.length)
          .reversed,
    ...originStack.sublist(originStack.length - items, originStack.length),
  ];
}

String getTopStack(List<List> stacks) {
  String result = "";
  stacks.forEach((stack) {
    result += stack.last;
  });
  return result;
}
