import 'package:flutter/material.dart';
import 'package:flutter_task_3_1/hello_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textController = TextEditingController();
  String savedText = '';

  Future<bool> _saveText() async {
    String text = textController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('savedText', text);
  }

  Future<String?> _getText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('savedText');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Вход в систему'),
      ),
      body: Center(
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
                ElevatedButton(
                  child: const Text('Сохранить',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    await _saveText();
                  },
                ),
                const SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                    child: const Text('Продолжить',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      savedText = await _getText() ?? ' ';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HelloScreen(login: savedText)),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
