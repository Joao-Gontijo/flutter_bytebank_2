import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  const TransactionAuthDialog({Key? key}) : super(key: key);

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: TextField(
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 64,
          letterSpacing: 32,
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

  void _actionButtonCancel() => print('Cancel');

  void _actionButtonConfirm() => print('Confirm');
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
