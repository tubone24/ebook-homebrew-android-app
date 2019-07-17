import 'package:intl/intl.dart';

class Utils {
  DateTime now;

  Utils(): now = new DateTime.now();
  Utils.now(this.now);

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

  String nowDate(){
    return new DateFormat('dd-MM-yyyy-hh:mm:ss').format(this.now);
  }
}
