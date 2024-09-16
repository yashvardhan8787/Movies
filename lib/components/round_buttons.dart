import 'package:flutter/material.dart';

class RoundButtons extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  final MaterialColor color;
  final IconData? icon; // Changed String to IconData

  const RoundButtons({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPress,
    required this.color,
    this.icon, // Allow icon to be nullable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPress, // Disable button press when loading
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.49,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(icon, color: Colors.black), // Use icon if provided
              SizedBox(width: 8), // Add space between icon and text
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
