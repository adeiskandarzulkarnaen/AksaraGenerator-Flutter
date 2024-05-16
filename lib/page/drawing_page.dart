// import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import 'package:aksaragen/utils/utils.dart';

class DrawingPage extends StatefulWidget {
  final double canvasWidth;
  final double canvasHeight;
  final double penStrokeWidth;
  final String canvasImageLable;

  const DrawingPage({
    super.key, 
    required this.canvasWidth,
    required this.canvasHeight, 
    required this.penStrokeWidth, 
    required this.canvasImageLable,
  });

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  late final SignatureController _signatureController;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: widget.penStrokeWidth,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text("Drawing Page"),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: widget.canvasWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.canvasImageLable,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                width: widget.canvasWidth,
                height: widget.canvasHeight,
                decoration: BoxDecoration(
                  border: Border.all(width: 1)
                ),
                child: Signature(
                  controller: _signatureController,
                  width: widget.canvasWidth,
                  height: widget.canvasHeight,
                  backgroundColor: Colors.lightBlue[100]!,
                ),
              ),
              Container(
                width: widget.canvasWidth,
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
                      icon: const Icon(Icons.delete_sweep_outlined), 
                      label: const Text("clear")
                    ),
                    const SizedBox(width: 24),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await saveSignature();
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
      ),
    );
  }

  Future<void> saveSignature() async {
    Uint8List? exportedCanvasImage = await _signatureController.toPngBytes(
      width: widget.canvasWidth.toInt(), 
      height: widget.canvasHeight.toInt(),
    );
    if (exportedCanvasImage == null) return;

    // todo: save image
    // String path = await saveImageFile(
    String? path = await saveImageFileWithFileDialog(
      bytesData: exportedCanvasImage,
      fileName: widget.canvasImageLable,
    );
    if(path != null) showSnackbar('Save success: $path');
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message)
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
