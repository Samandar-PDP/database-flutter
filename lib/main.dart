import 'package:flutter/material.dart';
import 'package:sqflite_db/db/sql_helper.dart';

import 'main_screen.dart';

void main() {
  runApp(TeshaApp());
}
class TeshaApp extends StatelessWidget {
  const TeshaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MainScreen(),
    );
  }
}
