import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aboutapp"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 165,
              child: AspectRatio(
                aspectRatio: 1/ 1,
                child: Image.asset(
                  'assets/handwriting.png',
                ),
              ),
            ),
            const Text(
              "Aksara Generator",
              style: TextStyle(
                fontSize: 24.0
              ),
            ),
            const SizedBox(height: 8),
            const Text("© 2024 adeiskandarzulkarnaen"),
          ],
        )
      ),
    );
  }
}