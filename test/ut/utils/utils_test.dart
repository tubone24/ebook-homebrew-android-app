import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'dart:io';
import 'package:ebook_homebrew_flutter/src/utils/utils.dart';

class MockFile extends Mock implements File {}
class MockDatetime extends Mock implements DateTime {}

void main() {
  Utils target = new Utils();
  test('Utils Test convertContentType', (){
    Map<String, String> testCase = {
      'jpg': 'image/jpeg',
      'png': 'image/png',
      'gif': 'image/gif'};
    testCase.forEach((String input, String expected){
      String actual = target.convertContentType(input);
      expect(actual, expected);
    });
  });

  test('Utils test writeFile', (){
    File mockFile = new MockFile();
    when(mockFile.writeAsBytesSync([1]));
    target.writeFile('test', [1]);
  });
}