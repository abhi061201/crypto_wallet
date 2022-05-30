import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abhishek',
      home: Material(
        child: Scaffold(
          body: Center(
            child: Text("Hello"),
          ),
        ),
      ),
    );
  }
}
