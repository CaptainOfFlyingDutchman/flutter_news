import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  Directory dir = await getTemporaryDirectory();
  print('getTemporaryDirectory: ${dir.path}');

  dir = await getApplicationDocumentsDirectory();
  print('getApplicationDocumentsDirectory: ${dir.path}');

  dir = await getExternalStorageDirectory();
  print('getApplicationDocumentsDirectory: ${dir.path}');
}
