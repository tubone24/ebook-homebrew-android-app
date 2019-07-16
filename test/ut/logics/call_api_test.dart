import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';

import 'package:ebook_homebrew_flutter/src/logics/call_api.dart';

void main() {
  CallApi target = new CallApi('http://127.0.0.1:80');
  MockWebServer _server = new MockWebServer(port: 80);
  setUp(() async {
    await _server.start();
  });
  tearDown(() {
    _server.shutdown();
  });

  test("uploadData()", () async {
    _server.enqueue(body: '{"upload_id":"test"}');
    String actual = await target.uploadData('image/jpeg', ['test']);
    expect(actual, 'test');
    StoredRequest request = _server.takeRequest();
    expect(request.uri.path, '/data/upload');
    expect(request.headers['accept'], 'application/json');
    expect(request.body, '{"contentType":"image/jpeg","images":["test"]}');
  });

  test("uploadData Exception", () async {
    _server.enqueue(httpCode: 500);
    expect(() async => await target.uploadData('image/jpeg', ['test']), isInstanceOf<Error>());
  });
}

