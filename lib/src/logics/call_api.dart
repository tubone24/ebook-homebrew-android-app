import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:ebook_homebrew_flutter/src/models/ebook_homebrew.dart';

class CallApi{
  String baseURL;
  CallApi(this.baseURL);
  Future<String> uploadData(String contentType, List<String> images) async {
    String body = new EbookHomebrewUploadImages(contentType, images).convertJson();
    http.Response response = await http.post(
        Uri.encodeFull('$baseURL/data/upload'),
        body: body,
        headers: {
          'Accept': 'application/json'
        }
    );
    int statusCode = response.statusCode;
    if (statusCode != 200){
      throw Error;
    }
    Map<String, dynamic> result = jsonDecode(response.body);
    return result['upload_id'];
  }

  Future<String> convertPdf(String contentType, String uploadId) async {
    String body = new EbookHomebrewRequestToUploadId(contentType, uploadId).convertJson();
    http.Response response = await http.post(
        Uri.encodeFull('$baseURL/convert/pdf'),
        body: body,
        headers: {
          'Accept': 'application/json'
        }
    );
    int statusCode = response.statusCode;
    if (statusCode != 200){
      throw Error;
    }
    return response.body;
  }

  Future<Map<String, dynamic>> downloadPdf(String contentType, String uploadId) async {
    String body = new EbookHomebrewRequestToUploadId(contentType, uploadId).convertJson();
    http.Response response = await http.post(
        Uri.encodeFull('$baseURL/convert/pdf/download'),
        body: body,
        headers: {
          'Accept': 'application/json'
        }
    );
    int statusCode = response.statusCode;
    print('Statuscode: $statusCode');
    return {'statusCode': statusCode, 'responseByte': response.bodyBytes};
  }

  Future<List<int>> downloadPdfWaiting(String contentType, String uploadId) async {
    Map<String, dynamic> result = await downloadPdf(contentType, uploadId);
    if (result['statusCode'] == 404){
      await downloadPdfWaiting(contentType, uploadId);
    }else if (result['statusCode'] == 200){
      return result['responseByte'];
    } else{
      print('Error');
    }
  }
}

