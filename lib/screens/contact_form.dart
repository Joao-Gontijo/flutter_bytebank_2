import 'package:flutter/material.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Full name'),
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Account number'),
              style: TextStyle(
                fontSize: 24,
              ),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                  ),
                  child: const Text('Create'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
