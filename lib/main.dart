import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'game/cake_clicker_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Hive ready for mobile/web/desktop
  await Hive.openBox('gameData'); // Open your save box

  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoloMania',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const CakeClickerGame(),
    );
  }
}