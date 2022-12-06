import 'dart:async';
import 'dart:io';

void main() async {
  print("AMDG");
  String input = await readFile();
  print(getIndexOfUniqueSequence(input, 4));
  print(getIndexOfUniqueSequence(input, 14));
}

Future<String> readFile() async {
  return await File('6_input.txt').readAsString();
}

int getIndexOfUniqueSequence(String input, int index) {
  String fourContainer = "";
  bool uniqueSequence = false;
  for (var i = 0; i < input.length; i++) {
    if (fourContainer.length < index) {
      fourContainer = fourContainer + input[i];
    }
    if (fourContainer.length == index) {
      String temporaryContainer = "";
      for (var j = 0; j < fourContainer.length; j++) {
        uniqueSequence = !temporaryContainer.contains(fourContainer[j]);
        if (!uniqueSequence) {
          break;
        }
        temporaryContainer = temporaryContainer + fourContainer[j];
      }
      uniqueSequence = temporaryContainer.length == index;
      if (uniqueSequence) {
        return i + 1;
      }
    }
    if (fourContainer.length == index && !uniqueSequence) {
      fourContainer = fourContainer.substring(1);
    }
  }
  return 0;
}
