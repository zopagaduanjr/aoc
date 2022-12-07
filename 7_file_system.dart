import 'dart:async';
import 'dart:io';

void main() async {
  print("AMDG");
  final inputs = await readFile();
  final directory = commandsToDirectory(inputs);
  final result = getDirectoriesUnderSize(directory, 100000);
  print(result);
  int totalDiskSpace = 70000000;
  int minUpdateRequiredSpace = 30000000;
  int remainingDiskSpace = totalDiskSpace - directory.fileSize;
  int diskSpaceToFree = minUpdateRequiredSpace - remainingDiskSpace;
  final result2 = getDirectoriesToFree(directory, diskSpaceToFree);
  print(result2);
}

Future<List> readFile() async {
  return await File('7_input.txt').readAsLines();
}

Directory commandsToDirectory(List inputs) {
  Directory? dir;
  Directory? currentDir;
  inputs.forEach(
    (command) {
      List<String> commands = command.split(" ");
      if (commands[0] == "\$") {}

      if (commands[0] == "\$") {
        if (commands[1] == "cd" && commands[2] != "..") {
          if (dir == null) {
            dir = Directory(name: commands[2], items: []);
            currentDir = dir;
          } else {
            currentDir = currentDir?.items.firstWhere((element) =>
                element.runtimeType == Directory &&
                (element as Directory).name == commands[2]);
          }
        } else if (commands[1] == "cd") {
          currentDir = currentDir?.parent;
        }
      } else {
        if (commands[0] == "dir") {
          currentDir?.items
              .add(Directory(name: commands[1], items: [], parent: currentDir));
        } else {
          currentDir?.items
              .add(Item(name: commands[1], fileSize: int.parse(commands[0])));
        }
      }
    },
  );
  return dir ?? Directory(name: "/", items: []);
}

int getDirectoriesUnderSize(Directory directory, int size) {
  int fileSizes = 0;
  void getDepth(Directory directory) {
    directory.items.forEach((element) {
      if (element.runtimeType == Directory) {
        if (element.fileSize <= size) {
          fileSizes += element.fileSize as int;
        }
        getDepth(element);
      }
    });
  }

  getDepth(directory);
  return fileSizes;
}

Directory getDirectoriesToFree(Directory directory, int size) {
  List<Directory> directories = [];
  void getDepth(Directory directory) {
    directory.items.forEach((element) {
      if (element.runtimeType == Directory) {
        if (element.fileSize >= size) {
          directories.add(element);
        }
        getDepth(element);
      }
    });
  }

  getDepth(directory);
  return directories.reduce(
      (value, element) => value.fileSize < element.fileSize ? value : element);
}

class Directory {
  String name;
  List items;
  Directory? parent;

  Directory({
    required this.name,
    required this.items,
    this.parent,
  });
  toString() {
    return "Directory $name, Parent ${parent?.name} , Items ${items.length}, file Size: $fileSize";
  }

  int get fileSize {
    if (items.isNotEmpty) {
      int size = 0;
      items.forEach((element) {
        size += element.fileSize as int;
      });
      return size;
    }
    return 0;
  }
}

class Item {
  String name;
  int fileSize;

  Item({
    required this.name,
    required this.fileSize,
  });
  toString() {
    return "Item $name, fileSize $fileSize";
  }
}
