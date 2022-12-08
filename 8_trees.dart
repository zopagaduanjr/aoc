import 'dart:async';
import 'dart:io';
import 'dart:math';

void main() async {
  print("AMDG");
  final input = await readFile();
  final firstResult = processTrees(input);
  print(firstResult);
  final secondResult = processMaxViewableTrees(input);
  print(secondResult);
}

Future<List<String>> readFile() async {
  return await File('8_input.txt').readAsLines();
}

int processTrees(List<String> input) {
  int visibleTrees = 0;
  for (var i = 0; i < input.length; i++) {
    List<int> trees = input[i].split('').map((e) => int.parse(e)).toList();
    for (var j = 0; j < trees.length; j++) {
      //check tree's neighbours Left, Top, Right, Bottom
      int currentTree = trees[j];
      bool isVisible = false;
      int left = (j - 1) < 0 ? -1 : trees.sublist(0, j).reduce(max);
      int top = (i - 1) < 0 ? -1 : getVerticalMax(input, j, i - 1);
      int right = (j + 1) >= trees.length
          ? -1
          : trees.sublist(j + 1, trees.length).reduce(max);
      int bottom = (i + 1) >= input.length
          ? -1
          : getVerticalMax(input, j, i + 1, descend: false);
      if ((trees[j] > left) ||
          (trees[j] > top) ||
          (trees[j] > right) ||
          (trees[j] > bottom)) {
        visibleTrees += 1;
        isVisible = true;
      }
      // print(" $top\n$left$currentTree$right     $isVisible\n $bottom");
    }
  }
  return visibleTrees;
}

int getVerticalMax(List<String> input, int x, int y, {bool descend = true}) {
  List<int> verticalTrees = [];
  if (descend) {
    for (var i = y; y >= 0; y--) {
      verticalTrees.add(int.parse(input[y][x]));
    }
  } else {
    for (var i = y; y < input.length; y++) {
      verticalTrees.add(int.parse(input[y][x]));
    }
  }
  return verticalTrees.reduce(max);
}

int processMaxViewableTrees(List<String> input) {
  int maxScore = 0;
  for (var i = 0; i < input.length; i++) {
    // print("current trees ${input[i]}");
    List<int> trees = input[i].split('').map((e) => int.parse(e)).toList();
    for (var j = 0; j < trees.length; j++) {
      int currentTree = trees[j];
      int left = (j - 1) < 0
          ? 0
          : getHorizontalViewableTrees(
              trees.sublist(0, j).reversed.toList(), currentTree);
      int top = (i - 1) < 0
          ? 0
          : getVerticalViewableTrees(input, j, i - 1, currentTree);
      int right = (j + 1) >= trees.length
          ? 0
          : getHorizontalViewableTrees(
              trees.sublist(j + 1, trees.length), currentTree);
      int bottom = (i + 1) >= input.length
          ? 0
          : getVerticalViewableTrees(input, j, i + 1, currentTree,
              descend: false);
      int score = left * top * right * bottom;
      if (score >= maxScore) {
        maxScore = score;
      }
      // print(
      //     "$top\n$left$currentTree$right - - - - - - score: $score\n$bottom\n- - - - - -");
    }
  }
  return maxScore;
}

int getVerticalViewableTrees(List<String> input, int x, int y, int currentTree,
    {bool descend = true}) {
  int trees = 0;
  if (descend) {
    for (var i = y; y >= 0; y--) {
      trees += 1;
      if (currentTree <= int.parse(input[y][x])) {
        break;
      }
    }
  } else {
    for (var i = y; y < input.length; y++) {
      trees += 1;
      if (currentTree <= int.parse(input[y][x])) {
        break;
      }
    }
  }

  return trees;
}

int getHorizontalViewableTrees(List<int> trees, int currentTree) {
  int treesSeen = 0;
  for (var i = 0; i < trees.length; i++) {
    treesSeen += 1;
    if (currentTree <= trees[i]) {
      break;
    }
  }

  return treesSeen;
}
