
import 'package:aksaragen/drawing_page.dart';
import 'package:flutter/material.dart';
import 'package:aksaragen/aboutapp_page.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({ super.key });

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late final TextEditingController _imageWidthForm;
  late final TextEditingController _imageHeightForm;
  late final TextEditingController _imagePenStrokeWidth;
  late final TextEditingController _imageLabelForm;

  final GlobalKey<FormState> _formConfigKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double maxCanvasWidth  = MediaQuery.of(context).size.width - 20;     // overflow horizontal = 8
    double maxCanvasHeight = MediaQuery.of(context).size.height - 200;  // overflow vertikal = 160

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 12.0),
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
      body: SingleChildScrollView(
        child: Padding(
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
                
                /* canvas Image Label input*/
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    controller: _imageLabelForm,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Image Label",
                      hintText: "input image label",
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) return "please fill out this field";
                      if (value.length > 60) return "imagelabel not allowed more than 60 characters";
                      return null;
                    },
                  ),
                ),
                
                /* canvas penStrokeWidth input*/
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    controller: _imagePenStrokeWidth,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Penstroke Width",
                      hintText: "input pen stroke width",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) return "please fill out this field";
                      if (int.tryParse(value) == null) return "penwidth must be a number type";
                      if (int.parse(value) > 40.0) return "penwidth not allowed more than 40 pixel";
                      return null;
                    },
                  ),
                ),
                
                /* canvas width input*/
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    controller: _imageWidthForm,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Canvas Width",
                      hintText: "input canvas width",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) return "please fill out this field";
                      if (int.tryParse(value) == null) return "canvas width must be a number type";
                      if (int.parse(value) > maxCanvasWidth.toInt()) return "canvaswidth not allowed more than ${maxCanvasWidth.toInt()} pixel";
                      return null;
                    },
                  ),
                ),
                
                /* canvas height input */
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
                    controller: _imageHeightForm,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Canvas Height",
                      hintText: "input canvas height",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) return "please fill out this field";
                      if (int.tryParse(value) == null) return "canvas height must be a number type";
                      if (int.parse(value) > maxCanvasHeight.toInt()) return "canvasheight not allowed more than ${maxCanvasHeight.toInt()} pixel";
                      return null;  
                    },
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formConfigKey.currentState!.validate()) {
            // _formConfigKey.currentState!.save();

            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) {
                return DrawingPage(
                  canvasWidth: double.parse(_imageWidthForm.text), 
                  canvasHeight: double.parse(_imageHeightForm.text), 
                  penStrokeWidth: double.parse(_imagePenStrokeWidth.text), 
                  canvasImageLable: _imageLabelForm.text,
                );
              },)
            );
          }
        }, 
        label: const Text("Create Canvas"),
        icon: const Icon(Icons.draw_outlined),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  @override
  void initState() {
    _imageWidthForm = TextEditingController();
    _imageHeightForm = TextEditingController();
    _imagePenStrokeWidth = TextEditingController();
    _imageLabelForm = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _imageWidthForm.dispose();
    _imageHeightForm.dispose();
    _imagePenStrokeWidth.dispose();
    _imageLabelForm.dispose();
    super.dispose();
  }
}

