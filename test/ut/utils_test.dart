import 'package:flutter_test/flutter_test.dart';

import 'package:ebook_homebrew_flutter/src/utils/utils.dart';

void main() {
  test('Utils Test convertContentType', (){
    Utils target = new Utils();
    Map<String, String> testCase = {
      'jpg': 'image/jpeg',
      'png': 'image/png',
      'gif': 'image/gif'};
    testCase.forEach((String input, String expected){
      String actual = target.convertContentType(input);
      expect(actual, expected);
    });
  });
}