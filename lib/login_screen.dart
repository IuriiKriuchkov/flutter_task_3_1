import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_task_3_1/path_screen.dart';
import 'package:flutter_task_3_1/shared_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'module/local_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.storage}) : super(key: key);

  final LocalStorage storage;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textController = TextEditingController();
  String _textInShared = ''; //переменная для сохранения в shared_preferences
  String _textInPath = ''; //переменная для сохранения в path

  Future<bool> _saveText() async {
    String text = textController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('savedText', text);
  }

  Future<String?> _getText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('savedText');
  }

  Future<File> _saveTextLocalFile() {
    _textInPath = textController.text;
    return widget.storage.writeLogin(_textInPath);
  }

  void _readTextLocalFile() async {
    await widget.storage.readLogin().then((String value) {
      setState(() {
        _textInPath = value;
      });
    });
  }

  @override
  void initState() {
    _readTextLocalFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Вход в систему'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      hintText: 'Введите свой логин'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ElevatedButton(
                            child: const Text('Сохранить в shared',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () async {
                              await _saveText();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              child: const Text('Продолжить c shared',
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () async {
                                _textInShared = await _getText() ?? ' ';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HelloSharedScreen(login: _textInShared)),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),

                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          child: const Text('Сохранить в path',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            await _saveTextLocalFile();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            child: const Text('Продолжить c path',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              _readTextLocalFile();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HelloPathScreen(login: _textInPath)),
                              );
                            }),
                      ],
                    ),
                  ),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
