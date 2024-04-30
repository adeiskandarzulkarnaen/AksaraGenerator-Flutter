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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aksara Generator",
              style: TextStyle(
                fontSize: 24.0
              ),
            ),
            SizedBox(height: 8),
            Text("© 2024 adeiskandarzulkarnaen"),
          ],
        )
      ),
    );
  }
}