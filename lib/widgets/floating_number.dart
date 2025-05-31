import 'package:flutter/material.dart';

class FloatingNumber extends StatefulWidget {
  final double value;
  final double top;
  final double left;
  final VoidCallback onFinished;

  const FloatingNumber({
    super.key,
    required this.value,
    required this.top,
    required this.left,
    required this.onFinished,
  });

  @override
  State<FloatingNumber> createState() => _FloatingNumberState();
}

class _FloatingNumberState extends State<FloatingNumber>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _offsetY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _opacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _offsetY = Tween<double>(begin: 0, end: -40).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward().whenComplete(() => widget.onFinished());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Positioned(
    top: widget.top,
    left: widget.left,
    child: AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(0, _offsetY.value),
            child: Stack(
              children: [
                // Border (stroke)
                Text(
                  "+${widget.value.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontFamily: 'PressStart2P',
                    fontSize: 12,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = Colors.black,
                  ),
                ),
                // Fill
                Text(
                  "+${widget.value.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontFamily: 'PressStart2P',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
    }