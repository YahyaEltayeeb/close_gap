import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Future<void> saveAndOpenPdf(Uint8List bytes) async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/cv.pdf");

    await file.writeAsBytes(bytes);

    final result = await OpenFile.open(file.path);
    print("OpenFile result: ${result.type}");
  } catch (e) {
    print("Error saving or opening PDF: $e");
  }
}
