import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class FileIO{
  File file;
  FileIO(this.file);

  void writeFile(List<int> bodyBytes) async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    file.writeAsBytesSync(bodyBytes);
  }
}