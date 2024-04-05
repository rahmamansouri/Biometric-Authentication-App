//The import of flutter/material.dart for Flutter widgets.
import 'package:flutter/material.dart';

//The import of flutter/material.dart package for Flutter widgets.
import 'auth_screen.dart';

//This is the entry point of the application. It calls the runApp() function to start the Flutter application and renders the MyApp widget.

void main() {
  runApp(const MyApp());
}
//Defines a stateful widget MyApp that represents the root of the application. It extends StatefulWidget and provides an implementation for creating the state object _MyAppState.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

//Defines the state class _MyAppState, which manages the state of the MyApp widget. It overrides the build() method to construct the UI of the application. It returns a MaterialApp widget with the AuthScreen widget as the home screen.
class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  AuthScreen()
    );
  }
}

