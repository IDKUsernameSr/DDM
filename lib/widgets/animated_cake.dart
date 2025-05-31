import 'package:flutter/material.dart';

class AnimatedCake extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;
  final void Function(TapDownDetails) onPressed;

  const AnimatedCake({
    required this.imagePath,
    required this.width,
    required this.height,
    required this.onPressed,
    super.key,
  });

  @override
  State<AnimatedCake> createState() => _AnimatedCakeState();
}

class _AnimatedCakeState extends State<AnimatedCake> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() => _isPressed = true);
        widget.onPressed(details); // ✅ pass cursor position
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Image.asset(
          widget.imagePath,
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}