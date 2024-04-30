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
                      icon: const Icon(Icons.undo_outlined), 
                      label: const Text("clear")
                    ),
                    const SizedBox(width: 24),
                    ElevatedButton.icon(
                      onPressed: () async {
                        Uint8List? canvasImage = await _signatureController.toPngBytes(
                          width: widget.canvasWidth.toInt(), 
                          height: widget.canvasHeight.toInt(),
                        );
                        if(canvasImage != null) {
                          String? res = await saveUint8ListToImageFile(
                            bytesData: canvasImage, 
                            fileName: widget.canvasImageLable,
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
      ),
      
    );
  }

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

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('save success!!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
