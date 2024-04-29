import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aboutapp"),
      ),
      body: const Center(
        child: Text("Aksara Generator")
      ),
    );
  }
}