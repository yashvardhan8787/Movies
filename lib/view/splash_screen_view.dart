import 'dart:math';
import 'package:flutter/material.dart';


class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for a single run
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );

    // Tween for position (far to close)
    _positionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Tween for color transition (blue to red)
    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final position = _positionAnimation.value;
            final color = _colorAnimation.value;

            return Transform.translate(
              offset: Offset(0.0, -200 * (1 - position)), // Moves text from far to center
              child: Opacity(
                opacity: position, // Text fades in as it comes closer
                child: Text(
                  'Watch Movies',
                  style: TextStyle(
                    fontSize: 40 + 20 * position, // Text size increases as it gets closer
                    fontWeight: FontWeight.bold,
                    color: color, // Color changes when it reaches the center
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}