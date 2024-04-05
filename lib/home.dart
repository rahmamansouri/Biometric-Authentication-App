//The import of flutter/material.dart for Flutter widgets.
import 'package:flutter/material.dart';

//Defines a stateful widget Home that represents the home screen of the application. It extends StatefulWidget and provides an implementation for creating the state object _HomeState.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


//Defines the state class _HomeState, which manages the state of the Home widget. It overrides the build() method to construct the UI of the home screen. The home screen consists of an AppBar with the title "Home" and a Center widget containing a text widget with the message "Authentication successful".

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text(
          'Authentication successful :)'
        ),
      ),
    );
  }
}
