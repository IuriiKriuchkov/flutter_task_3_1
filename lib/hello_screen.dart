import 'package:flutter/material.dart';

class HelloScreen extends StatelessWidget {
  HelloScreen({Key? key, required this.login});
  final String login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shared preferences",
        ),
        backgroundColor: Colors.green,
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
