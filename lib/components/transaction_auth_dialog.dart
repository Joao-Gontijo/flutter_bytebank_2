import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionAuthDialog({required this.onConfirm});

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: TextField(
        controller: _passwordController,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 64,
          letterSpacing: 24,
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
      actions: [
        ActionTextButton('Cancel', _actionButtonCancel),
        ActionTextButton('Confirm', _actionButtonConfirm),
      ],
    );
  }

  void _actionButtonCancel() => Navigator.pop(context);

  void _actionButtonConfirm() {
    widget.onConfirm(_passwordController.text);
    Navigator.pop(context);
  }
}

class ActionTextButton extends StatelessWidget {
  final String text;
  Function onClick;

  ActionTextButton(this.text, this.onClick);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onClick();
      },
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
