import 'package:flutter/material.dart';
class HelloPathScreen extends StatelessWidget {
  const HelloPathScreen({Key? key, required this.login}) : super(key: key);
  final String login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Path provider",
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          "$login, добро пожаловать в систему!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
