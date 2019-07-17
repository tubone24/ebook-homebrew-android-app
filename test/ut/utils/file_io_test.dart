import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:ebook_homebrew_flutter/src/utils/file_io.dart';

class MockFile extends Mock implements File {}

void main() {
  test('Utils Test WriteFile', () async{
    MockFile mockFile = new MockFile();
    FileIO target = new FileIO(mockFile);
    when(mockFile.writeAsBytesSync([1]));
    target.writeFile([1]);
  });
}