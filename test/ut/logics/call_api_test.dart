import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:mockito/mockito.dart';

import 'package:ebook_homebrew_flutter/src/logics/call_api.dart';

class MockCallApi extends Mock implements CallApi {}

void main() {
  CallApi target = new CallApi('http://127.0.0.1:8081');
  MockWebServer _server = new MockWebServer(port: 8081);
  setUp(() async {
    await _server.start();
  });
  tearDown(() {
    _server.shutdown();
  });

  test('uploadData', () async {
    _server.enqueue(body: '{"upload_id":"test"}');
    String actual = await target.uploadData('image/jpeg', ['test']);
    expect(actual, 'test');
    StoredRequest request = _server.takeRequest();
    expect(request.uri.path, '/data/upload');
    expect(request.headers['accept'], 'application/json');
    expect(request.body, '{"contentType":"image/jpeg","images":["test"]}');
  });

  test('convertPdf', () async {
    _server.enqueue(body: '{"upload_id":"test"}');
    String actual = await target.convertPdf('image/jpeg', 'test');
    expect(actual, '{"upload_id":"test"}');
    StoredRequest request = _server.takeRequest();
    expect(request.uri.path, '/convert/pdf');
    expect(request.headers['accept'], 'application/json');
    expect(request.body, '{"contentType":"image/jpeg","uploadId":"test"}');
  });

  test('downloadPdf', () async {
    ByteData bodyByte = new ByteData(10);
    _server.enqueue(body: bodyByte);
    Map<String, dynamic> actual = await target.downloadPdf('image/jpeg', 'test');
    expect(actual['statusCode'], 200);
    StoredRequest request = _server.takeRequest();
    expect(request.uri.path, '/convert/pdf/download');
    expect(request.headers['accept'], 'application/json');
    expect(request.body, '{"contentType":"image/jpeg","uploadId":"test"}');
  });
}

