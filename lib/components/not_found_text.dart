import 'package:flutter/material.dart';

class NotFoundText extends StatelessWidget {
  final String message;

  NotFoundText(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
