import 'dart:convert';
import 'dart:io';

class ConvertBase64{

  List<String> createImageb64List(List<String> fileslist) {
    print(fileslist);
    List<String> imagesList = [];
    fileslist.forEach((String file){
      String fileb64 = convertBase64(openFile(file));
      imagesList.add(fileb64);
    });
    return imagesList;
    }

  List<int> openFile(String filename) {
    List<int> contents;
    File file = new File(filename);
    contents =  file.readAsBytesSync();
    return contents;
  }

  String convertBase64(List<int> image) {
    String _base64;
    _base64 = base64Encode(image);
    return _base64;
  }
}