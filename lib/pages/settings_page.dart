import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onReset;

  const SettingsPage({super.key, required this.onSave, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFF8D9D6),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Hive.box('gameData').clear();
                onReset();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Game reset!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF8D9D6),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.black, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text(
                'Reset Game',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'PressStart2P',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onSave();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Game saved!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF8D9D6),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.black, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text(
                'Save Game',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'PressStart2P',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}