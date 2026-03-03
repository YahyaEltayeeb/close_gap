import 'dart:io';
import 'package:file_picker/file_picker.dart';

Future<File?> pickCvFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'], // عشان CV PDF بس
  );

  if (result != null && result.files.single.path != null) {
    return File(result.files.single.path!);
  }

  return null;
}