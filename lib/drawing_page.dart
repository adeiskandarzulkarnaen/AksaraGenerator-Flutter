import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import 'package:aksaragen/utils/utils.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  late final SignatureController _signatureController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text("Drawing Page"),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 246,
              child: Text("label"),
            ),
            Container(
              width: 246,
              height: 246,
              decoration: BoxDecoration(
                border: Border.all(width: 1)
              ),
              child: Signature(
                controller: _signatureController,
                width: 244.0,
                height: 244.0,
                backgroundColor: Colors.lightBlue[100]!,
              ),
            ),
            Container(
              width: 246,
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _signatureController.clear();
                      });
                    }, 
                    icon: const Icon(Icons.undo_outlined), 
                    label: const Text("clear")
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton.icon(
                    onPressed: () async {
                      Uint8List? canvasImage = await _signatureController.toPngBytes(
                        width: 244, height: 244,
                      );
                      
                      if(canvasImage != null) {
                        String? res = await saveUint8ListToImageFile(
                          bytesData: canvasImage, 
                          fileName: "image"
                        );
                        if(res != null) showSnackbar();
                      }
                    }, 
                    icon: const Icon(Icons.save), 
                    label: const Text("save")
                  ),
                ],
              ),
            )
          ],
        )
      ),
      
    );
  }

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 3.0,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      exportPenColor: Colors.black,
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('save success!!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}