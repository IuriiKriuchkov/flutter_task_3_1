import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/login.txt');
  }

  Future<String> readLogin() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 'nothing';
    }
  }

  Future<File> writeLogin(String counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(counter);
  }
}