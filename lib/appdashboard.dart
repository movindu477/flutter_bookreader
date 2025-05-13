import 'package:flutter/material.dart';

class AppDashboard extends StatelessWidget {
  const AppDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Dashboard'),
        backgroundColor: Colors.blue[900],
      ),
      body: const Center(
        child: Text(
          'Welcome to the Dashboard!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
