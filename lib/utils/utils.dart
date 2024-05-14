import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';


/*
 * Fungsi ini digunakan untuk menconvert gambar dari format Uint8List
 * ke bentuk File. file process dilakukan di cache da akan dihapus secara otomatis. 
 */
Future<File> convertUint8ListToFile({
  required Uint8List bytesData,
  String? fileNameFormat = "image_file.png",
}) async {
  String tempDir = (await getTemporaryDirectory()).path;
  File convertedFiles = File('$tempDir/$fileNameFormat');
  await convertedFiles.writeAsBytes(bytesData);
  return convertedFiles;
}

/*
 * Fungsi ini digunakan untuk menyimpan file gambar secara langsung 
 * ke directory download tanpa menggunakan muncul popup file dialog. 
 * Jika download directory tidak dapat di akses oleh platform,
 * makan file akan disimpan ke folder download milik aplikasi.
 */
Future<File> saveImageFileToApplicationDownloadDirectory({
  required Uint8List bytesImageData,
  required String fileName,
}) async {
  String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

  /* get application download directory */
  String downloadDir = (await getDownloadsDirectory())!.path;
  String imagePath = '$downloadDir/${timeStamp}_$fileName.png';

  File imageFile = File(imagePath);
  await imageFile.writeAsBytes(bytesImageData);
  return imageFile;
}

/*
 * Fungsi ini digunakan untuk menyimpan file gambar ke directory 
 * dengan memunculkan popup file dialog untuk menentukan lokasi file penyimpanan. 
 */
Future<String?> saveImageFileWithFileDialog({
  required Uint8List bytesData,
  required String fileName,
}) async {
  String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

  File tempFile = await convertUint8ListToFile(
    bytesData: bytesData, 
    fileNameFormat: "${timeStamp}_$fileName.png"
  );

  String? filePath = await FlutterFileDialog.saveFile(
    params: SaveFileDialogParams(sourceFilePath: tempFile.path)
  );

  return filePath;
}
