import 'dart:developer';

import 'package:flutter/material.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drawing Page"),
      ),
      body: const Center(
        child: Text("some code")
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          log("Image Saved");
        }, 
        label: const Text("Save Image"),
        icon: const Icon(Icons.save),
        backgroundColor: Colors.deepPurple,
      )
    );
  }
}