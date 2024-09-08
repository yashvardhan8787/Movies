import 'package:flutter/material.dart';

class ScreenFourView extends StatefulWidget {
  const ScreenFourView({super.key});

  @override
  State<ScreenFourView> createState() => _ScreenFourViewState();
}

class _ScreenFourViewState extends State<ScreenFourView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("fourth screen"),
      ),
    );
  }
}
