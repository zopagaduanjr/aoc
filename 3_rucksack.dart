import 'dart:async';
import 'dart:io';

void main() async {
  String alphabet = "abcdefghijklmnopqrstuvwxyz";
  List priorities = alphabet.split('');
  int result = 0;
  int threeElvesResult = 0;
  List inputs = await readFile();
  inputs.forEach((item) {
    String intersection = getIntersections(item);
    int priority = getPriority(priorities, intersection);
    print("$intersection $priority");
    result += priority;
  });
  print("AMDG $result");
  final threeGroups = inputToThreeGroups(inputs);
  threeGroups.forEach((elves) {
    String intersection = getIntersectionsOfThree(elves);
    int priority = getPriority(priorities, intersection);
    threeElvesResult += priority;
  });
  print("AMDG $threeElvesResult");
}

Future<List> readFile() async {
  return await File('rucksack_input.txt').readAsLines();
}

String getIntersections(String item) {
  List items = item.split('');
  Set firstHalf = items.sublist(0, items.length ~/ 2).toSet();
  Set secondHalf = items.sublist(items.length ~/ 2, items.length).toSet();
  Set intersection = firstHalf.intersection(secondHalf);
  return intersection.first;
}

int getPriority(List priorities, String character) {
  int index = priorities.indexWhere((e) => e == character.toLowerCase());
  if (character == character.toUpperCase()) {
    return index + 27;
  }
  return index + 1;
}

List inputToThreeGroups(List inputs) {
  List threeGroups = [];
  for (var i = 0; i < inputs.length; i++) {
    threeGroups.add([
      inputs[i].split(''),
      inputs[i + 1].split(''),
      inputs[i + 2].split(''),
    ]);
    i += 2;
  }
  return threeGroups;
}

String getIntersectionsOfThree(List threeElves) {
  final commonElements = threeElves.fold<Set>(
      threeElves.first.toSet(), (a, b) => a.intersection(b.toSet()));
  return commonElements.first;
}
