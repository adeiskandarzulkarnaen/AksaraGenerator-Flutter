// import 'dart:io';

import 'dart:typed_data';
import 'package:aksaragen/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import 'package:aksaragen/utils/utils.dart';

class DrawingPage extends StatefulWidget {
  final Storage storage;
  const DrawingPage({super.key, required this.storage});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  late final SignatureController _signatureController;
  late double canvasWidth;
  late double canvasHeight;
  late double penStrokeWidth;
  late String canvasImageName;

  @override
  void initState() {
    super.initState();
    _loadConfiguration();
    _signatureController = SignatureController(
      penStrokeWidth: penStrokeWidth,
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
          child: Text("AksaraGenerator"),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 24.0,),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/config');
              }, 
              icon: const Icon(Icons.settings)
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              /* image name */
              SizedBox(
                width: canvasWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    canvasImageName,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              /* canvas */
              Container(
                width: canvasWidth,
                height: canvasHeight,
                decoration: BoxDecoration(
                  border: Border.all(width: 1)
                ),
                child: Signature(
                  controller: _signatureController,
                  width: canvasWidth,
                  height: canvasHeight,
                  backgroundColor: Colors.lightBlue[100]!,
                ),
              ),

              /* button */
              Container(
                width: double.infinity,
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
                      icon: const Icon(Icons.delete_outline), 
                      label: const Text("clear")
                    ),
                    const SizedBox(width: 14),
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
          ),
        ),
      ),
    );
  }

  void _loadConfiguration() {
    canvasWidth = widget.storage.getCanvasWidth() ?? 28;
    canvasHeight = widget.storage.getCanvasHeight() ?? 28;
    penStrokeWidth = widget.storage.getPenStrokeWidth() ?? 1;
    canvasImageName = widget.storage.getImageName() ?? "img";
  }

  Future<void> saveSignature() async {
    Uint8List? exportedCanvasImage = await _signatureController.toPngBytes(
      width: canvasWidth.toInt(), 
      height: canvasHeight.toInt(),
    );
    if (exportedCanvasImage == null) return;

    // todo: save image
    // String path = await saveImageFile(
    String? path = await saveImageFileWithFileDialog(
      bytesData: exportedCanvasImage,
      fileName: canvasImageName,
    );
    if(path != null) showSnackbar('Save success: $path');
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message)
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
