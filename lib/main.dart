
import 'package:aksaragen/page/aboutapp_page.dart';
import 'package:aksaragen/page/drawing_page.dart';
import 'package:aksaragen/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aksaragen/page/configuration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final preferences = await SharedPreferences.getInstance();
  final Storage storage = Storage(preferences);
  runApp(MyApp(storage: storage));
}

class MyApp extends StatelessWidget {
  final Storage storage;
  const MyApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      title: 'Aksara Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          )
        ),
      ),
      initialRoute: _getInitialRoute(),
      routes: {
        '/about' : (context) => const AboutAppPage(),
        '/canvas': (context) => DrawingPage(storage: storage),
        '/config': (context) => ConfigurationPage(storage: storage),
      },
    );
  }

  String _getInitialRoute() {
    return  storage.getCanvasHeight() == null || 
            storage.getCanvasWidth()  == null ||
            storage.getImageName() == null    ||
            storage.getImageName() == null
        ? '/config'
        : '/canvas';
  }
}

