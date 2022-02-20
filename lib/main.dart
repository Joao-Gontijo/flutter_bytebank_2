import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Column(
          children: [
            Image.asset('images/bytebank_logo.png'),
            Container(
              height: 100,
              width: 150,
              color: Colors.green[900],
              child: Column(
                children: const [
                  Icon(Icons.people),
                  Text('Contacts'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
