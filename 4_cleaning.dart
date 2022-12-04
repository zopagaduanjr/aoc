import 'dart:async';
import 'dart:io';

void main() async {
  List inputs = await readFile();
  int result = 0;
  int absoluteResult = 0;
  inputs.forEach((e) {
    final verdict = processPair(e);
    final absoluteVerdict = processAbsolutePair(e);
    print("$e : $absoluteVerdict");
    if (verdict) {
      result += 1;
    }
    if (absoluteVerdict) {
      absoluteResult += 1;
    }
  });
  print("AMDG, $result");
  print("AMDG, $absoluteResult");
}

Future<List> readFile() async {
  return await File('cleaning_input.txt').readAsLines();
}

class Pair {
  int start;
  int end;

  Pair({
    required this.start,
    required this.end,
  });
}

bool processPair(String pair) {
  List pairs = pair.split(',');
  Pair firstPair = Pair(
    start: int.parse(pairs.first.split('-').first),
    end: int.parse(pairs.first.split('-').last),
  );
  Pair secondPair = Pair(
    start: int.parse(pairs.last.split('-').first),
    end: int.parse(pairs.last.split('-').last),
  );

  if (firstPair.start <= secondPair.start && firstPair.end >= secondPair.end) {
    return true;
  } else if (firstPair.start >= secondPair.start &&
      firstPair.end <= secondPair.end) {
    return true;
  }
  return false;

  // 2-8 , 3-7
  // 6-6 , 4-6
  // TODO create logic
  // case 1
  // if firstPair.start is less than secondPair.start and if firstPair.end is greater than secondPair.last
  // case 2
  // if firstPair.start is greater than secondPair.start and if firstPair.end is less than or equal to secondPair.last
}

bool processAbsolutePair(String pair) {
  List pairs = pair.split(',');
  Pair firstPair = Pair(
    start: int.parse(pairs.first.split('-').first),
    end: int.parse(pairs.first.split('-').last),
  );
  Pair secondPair = Pair(
    start: int.parse(pairs.last.split('-').first),
    end: int.parse(pairs.last.split('-').last),
  );

  if (firstPair.start <= secondPair.start && firstPair.end >= secondPair.end) {
    return true;
  } else if (firstPair.start >= secondPair.start &&
      firstPair.end <= secondPair.end) {
    return true;
  } else if (firstPair.start <= secondPair.start &&
      firstPair.end >= secondPair.start) {
    return true;
  } else if (firstPair.start >= secondPair.start &&
      firstPair.start <= secondPair.end) {
    return true;
  }
  return false;

  //5-7, 7-9

  //92-96,4-92

  // if firstPair.first is less than secondPair.first and firstPair.last is greater than secondPair.first
  // if firstPair.last is >= secondPair.first
  //1-2, 5-7
}
