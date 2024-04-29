
import 'dart:developer';
import 'package:aksaragen/drawing_page.dart';
import 'package:flutter/material.dart';
import 'package:aksaragen/aboutapp_page.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({ super.key });

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late TextEditingController _imageHeightController;
  late TextEditingController _imageWidthController;

  final GlobalKey<FormState> _formConfigKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 12.0,),
          child: Text("Canvas Config"),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 24.0,),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) { 
                    return const AboutAppPage();
                  })
                );
              }, 
              icon: const Icon(Icons.info_outline)
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formConfigKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /* application logo */
              const FlutterLogo(
                size: 120,
                style: FlutterLogoStyle.horizontal,
              ),
              
              /* canvas height input */
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: TextFormField(
                  controller: _imageHeightController,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Canvas Height",
                    hintText: "Input tinggi canvas",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value!.isEmpty) return "form harus di isi";
                    if (double.tryParse(value) == null) return "Input width harus berupa angka";
                    if (double.parse(value) > deviceHeight) return 'tinggi canvas tidak boleh melebihi ${deviceHeight.toStringAsFixed(0)} pixel';
                    return null;
                  },
                ),
              ),

              /* canvas width input*/
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: TextFormField(
                  controller: _imageWidthController,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Canvas Width",
                    hintText: "Input lebar canvas",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value!.isEmpty) return "form harus di isi";
                    if (double.tryParse(value) == null) return "Input width harus berupa angka";
                    if (double.parse(value) > deviceWidth) return 'lebar canvas tidak boleh melebihi ${deviceWidth.toStringAsFixed(0)} pixel';
                    return null;
                  },
                ),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formConfigKey.currentState!.validate()) {
            // _formConfigKey.currentState!.save();
            log("validasi berhasil");
            log(_imageWidthController.text);

            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) {
                return const DrawingPage();
              },)
            );
          }
          log("done");
        }, 
        label: const Text("Create Canvas"),
        icon: const Icon(Icons.draw_outlined),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  @override
  void initState() {
    _imageHeightController = TextEditingController();
    _imageWidthController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _imageWidthController.dispose();
    _imageHeightController.dispose();
    super.dispose();
  }
}

