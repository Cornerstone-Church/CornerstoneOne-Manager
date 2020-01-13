// Required imports
import 'package:flutter/material.dart';

// Main constructor
void main() => runApp(ManagerApp());

// App
class ManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Cornerstone One Manager')),
      ),
    );
  }
}
