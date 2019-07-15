import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ebook_homebrew_flutter/src/app.dart';

void main() {
  testWidgets('Ebook-homebrew app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());
    await tester.pump();
    expect(find.text('LOAD PATH FROM'), findsOneWidget);
    expect(find.text('Open file picker'), findsOneWidget);
    expect(find.text('Upload Files'), findsOneWidget);
    expect(find.text('Download PDF'), findsOneWidget);
    
    tester.tap(find.widgetWithText(DropdownButton, 'LOAD PATH FROM').first);
  });
}
