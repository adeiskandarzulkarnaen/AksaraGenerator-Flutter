
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aksaragen/config_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    
    return MaterialApp(
      title: 'Aksara Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          toolbarHeight: 80,
        ),
      ),
      home: const ConfigPage()
    );
  }
}

