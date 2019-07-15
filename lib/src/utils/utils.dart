import 'dart:io';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  String convertContentType(String extension) {
    String contentType;
    if (extension == 'jpg') {
      contentType = 'image/jpeg';
    } else if (extension == 'png') {
      contentType = 'image/png';
    } else if (extension == 'gif') {
      contentType = 'image/gif';
    }
    return contentType;
  }

  void writeFile(String filename, List<int> bodyBytes) async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    File file = new File(filename);
    file.writeAsBytesSync(bodyBytes);
  }

  String nowDate(){
    DateTime now = new DateTime.now();
    return new DateFormat('dd-MM-yyyy-hh:mm:ss').format(now);
  }
}
