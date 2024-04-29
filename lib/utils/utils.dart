import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

Future<File> convertUint8ListToFile({ 
    required Uint8List bytesData, 
    String? fileNameFormat = "file.png",
  }) async {
    String tempDir = (await getTemporaryDirectory()).path;   // "/data/user/0/com.example.app/cache"

    File convertedFiles = File('$tempDir/$fileNameFormat');
    await convertedFiles.writeAsBytes(bytesData);
    return convertedFiles;
}

Future<String?> saveUint8ListToImageFile({
    required Uint8List bytesData,
    required String fileName,
  }) async {
    File tempFile = await convertUint8ListToFile(
      bytesData: bytesData, 
      fileNameFormat: "$fileName.png"
    );
    String? filePath = await FlutterFileDialog.saveFile(
      params: SaveFileDialogParams(sourceFilePath: tempFile.path)
    );
    
    return filePath;
}
