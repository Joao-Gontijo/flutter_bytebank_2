import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData? icon;
  final double iconSize = 64;

  CenteredMessage(this.message, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            child: Icon(
              icon,
              size: iconSize,
            ),
            visible: icon != null,
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
