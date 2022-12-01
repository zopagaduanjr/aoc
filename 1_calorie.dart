import 'dart:async';
import 'dart:io';

void main() async {
  print("AMDG");
  print(await getHeaviestElf());
  print(await sumTop3ElfCalories());
}

Future<int> getHeaviestElf() async {
  int result = 0;
  int elfCapacity = 0;

  List lines = await File('calorie_input.txt').readAsLines();

  lines.forEach((element) {
    if (element.isNotEmpty) {
      elfCapacity += int.parse(element);
    } else {
      if (elfCapacity > result) {
        result = elfCapacity;
      }
      elfCapacity = 0;
    }
  });

  return result;
}

Future<List> groupElfByCalories() async {
  List result = [];
  int elfCapacity = 0;

  List lines = await File('calorie_input.txt').readAsLines();

  lines.forEach((element) {
    if (element.isNotEmpty) {
      elfCapacity += int.parse(element);
    } else {
      result.add(elfCapacity);
      elfCapacity = 0;
    }
  });
  result.sort((b, a) => a.compareTo(b));
  return result;
}

Future<int> sumTop3ElfCalories() async {
  final ascendingElfs = await groupElfByCalories();
  final top3 = ascendingElfs.take(3);
  int result = 0;
  top3.forEach((element) {
    result += element as int;
  });
  return result;
}
