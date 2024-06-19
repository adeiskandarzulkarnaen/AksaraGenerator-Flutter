
import 'package:flutter/material.dart';
import '../utils/storage.dart';

class ConfigurationPage extends StatefulWidget {
  final Storage storage;
  const ConfigurationPage({ super.key, required this.storage });

  @override
  State<ConfigurationPage> createState() => _ConfigPageSurationtate();
}

class _ConfigPageSurationtate extends State<ConfigurationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _imageWidthCtrl;
  late final TextEditingController _imageHeightCtrl;
  late final TextEditingController _imageNameCtrl;
  late final TextEditingController _imagePenStrokeWidthCtrl;

  @override
  void initState() {
    super.initState();
    _imageWidthCtrl = TextEditingController(text: widget.storage.getCanvasWidth()?.toString());
    _imageHeightCtrl = TextEditingController(text: widget.storage.getCanvasHeight()?.toString());
    _imageNameCtrl = TextEditingController(text: widget.storage.getImageName());
    _imagePenStrokeWidthCtrl = TextEditingController(text: widget.storage.getPenStrokeWidth()?.toString());
  }

  @override
  void dispose() {
    _imageWidthCtrl.dispose();
    _imageHeightCtrl.dispose();
    _imageNameCtrl.dispose();
    _imagePenStrokeWidthCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxCanvasWidth  = MediaQuery.of(context).size.width - 20;    // overflow horizontal = 8
    double maxCanvasHeight = MediaQuery.of(context).size.height - 200;  // overflow vertikal = 160

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text("Canvas Configuration"),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 24.0,),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
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
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const InputHeader(),
                InputCanvasWidthForm(imageWidthCtrl: _imageWidthCtrl, maxCanvasWidth: maxCanvasWidth),
                InputCanvasHeightForm(imageHeightCtrl: _imageHeightCtrl, maxCanvasHeight: maxCanvasHeight),
                InputPenStrokeWidthForm(imagePenStrokeWidthCtrl: _imagePenStrokeWidthCtrl),
                InputImageNameForm(imageNameCtrl: _imageNameCtrl),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await widget.storage.setCanvasWidth(canvasWidth: double.parse(_imageWidthCtrl.text));
            await widget.storage.setCanvasHeight(canvasHeight: double.parse(_imageHeightCtrl.text));
            await widget.storage.setPenStrokeWidth(penStrokeWidth: double.parse(_imagePenStrokeWidthCtrl.text));
            await widget.storage.setImageName(imageName: _imageNameCtrl.text);

            if(!context.mounted) return;
            await Navigator.pushReplacementNamed(context, '/canvas');
          }
        }, 
        label: const Text("Create Canvas"),
        icon: const Icon(Icons.draw_outlined),
        backgroundColor: Colors.amber,
      ),
    );
  }
}

class InputHeader extends StatelessWidget {
  const InputHeader({ super.key, });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Text("Aksara Generator"),
      ],
    );
  }
}

class InputCanvasHeightForm extends StatelessWidget {
  final TextEditingController _imageHeightCtrl;
  final double maxCanvasHeight;

  const InputCanvasHeightForm({
    super.key,
    required TextEditingController imageHeightCtrl,
    required this.maxCanvasHeight,
  }) : _imageHeightCtrl = imageHeightCtrl;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: TextFormField(
        controller: _imageHeightCtrl,
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
          if (double.tryParse(value) == null) return "canvas height must be a number type";
          if (double.parse(value) < 28) return "canvasheight not allowed less than 28 pixel)";
          if (double.parse(value) > maxCanvasHeight.toInt()) return "canvasheight not allowed more than screenheight (${maxCanvasHeight.toInt()} pixel)";
          return null;  
        },
      ),
    );
  }
}

class InputCanvasWidthForm extends StatelessWidget {
  final TextEditingController _imageWidthCtrl;
  final double maxCanvasWidth;

  const InputCanvasWidthForm({
    super.key,
    required TextEditingController imageWidthCtrl,
    required this.maxCanvasWidth,
  }) : _imageWidthCtrl = imageWidthCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: TextFormField(
        controller: _imageWidthCtrl,
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
          if (double.tryParse(value) == null) return "canvas width must be a number type";
          if (double.parse(value) < 28) return "canvaswidth not allowed less than 28 pixel";
          if (double.parse(value) > maxCanvasWidth.toInt()) return "canvaswidth not allowed more than screenwidth (${maxCanvasWidth.toInt()} pixel)";
          return null;
        },
      ),
    );
  }
}

class InputPenStrokeWidthForm extends StatelessWidget {
  final TextEditingController _imagePenStrokeWidthCtrl;

  const InputPenStrokeWidthForm({
    super.key,
    required TextEditingController imagePenStrokeWidthCtrl,
  }) : _imagePenStrokeWidthCtrl = imagePenStrokeWidthCtrl;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: TextFormField(
        controller: _imagePenStrokeWidthCtrl,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: const InputDecoration(
          labelText: "Pencil Stroke Width",
          hintText: "input penstroke width",
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (String? value) {
          if (value!.isEmpty) return "please fill out this field";
          if (double.tryParse(value) == null) return "penwidth must be a number type";
          if (double.parse(value) < 1) return "penwidth not allowed less than 1 pixel";
          if (double.parse(value) > 24) return "penwidth not allowed more than 24 pixel";
          return null;
        },
      ),
    );
  }
}

class InputImageNameForm extends StatelessWidget {
  final TextEditingController _imageNameCtrl;

  const InputImageNameForm({
    super.key,
    required TextEditingController imageNameCtrl,
  }) : _imageNameCtrl = imageNameCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: TextFormField(
        controller: _imageNameCtrl,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: const InputDecoration(
          labelText: "Image Name",
          hintText: "Input image",
          border: OutlineInputBorder(),
        ),
        validator: (String? value) {
          if (value!.isEmpty) return "please fill out this field";
          if (value.length > 60) return "imagelabel not allowed more than 60 characters";
          return null;
        },
      ),
    );
  }
}

