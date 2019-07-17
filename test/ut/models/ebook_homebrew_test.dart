import 'package:flutter_test/flutter_test.dart';

import 'package:ebook_homebrew_flutter/src/models/ebook_homebrew.dart';

void main() {
  test('Unit test EbookHomebrewUploadImages', (){
    EbookHomebrewUploadImages ebookHomebrewUploadImages = new EbookHomebrewUploadImages('image/jpeg', ['test']);
    String actual = ebookHomebrewUploadImages.convertJson();
    expect(actual, '{"contentType":"image/jpeg","images":["test"]}');
  });

  test('Unit test EbookHomebrewRequestToUploadId', (){
    EbookHomebrewRequestToUploadId ebookHomebrewRequestToUploadId = new EbookHomebrewRequestToUploadId('image/jpeg', 'test');
    String actual = ebookHomebrewRequestToUploadId.convertJson();
    expect(actual, '{"contentType":"image/jpeg","uploadId":"test"}');
  });
}