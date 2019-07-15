import 'dart:convert';

class EbookHomebrewUploadImages{
  String contentType;
  List<String> images;

  EbookHomebrewUploadImages(this.contentType, this.images);

  String convertJson(){
    return jsonEncode({'contentType': this.contentType, 'images': this.images});
  }
}

class EbookHomebrewRequestToUploadId{
  String contentType;
  String uploadId;

  EbookHomebrewRequestToUploadId(this.contentType, this.uploadId);

  String convertJson(){
    return jsonEncode({'contentType': this.contentType, 'uploadId': this.uploadId});
  }
}