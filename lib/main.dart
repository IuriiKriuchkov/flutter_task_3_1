import 'package:flutter/material.dart';
import 'package:flutter_task_3_1/login_screen.dart';
import 'package:flutter_task_3_1/module/local_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(
        storage: LocalStorage(),
      ),
    );
  }
}
