import 'package:flutter/material.dart';
import 'dart:math';

class SettingsPage extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onReset;

  const SettingsPage({
    super.key,
    required this.onSave,
    required this.onReset,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: min(screenWidth * 0.035, 14),
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFF8D9D6),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Confirm Reset',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 14,
                      ),
                    ),
                    content: const Text(
                      'Are you sure you want to reset all your progress?\nThis cannot be undone.',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                        fontSize: 10,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel', style: TextStyle(fontFamily: 'PressStart2P')),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Reset', style: TextStyle(fontFamily: 'PressStart2P')),
                      ),
                    ],
                  ),
                );

                if (!context.mounted) return;

                if (confirm == true) {
                  widget.onReset();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Game reset!')),
                  );
                }
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
              child: Text(
                'Reset Game',
                style: TextStyle(
                  fontSize: min(screenWidth * 0.035, 14),
                  fontFamily: 'PressStart2P',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave();
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
              child: Text(
                'Save Game',
                style: TextStyle(
                  fontSize: min(screenWidth * 0.035, 14),
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