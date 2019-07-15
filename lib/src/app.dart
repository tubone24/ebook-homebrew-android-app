import 'package:flutter/material.dart';
import 'package:ebook_homebrew_flutter/src/ui/convert_pdf.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Ebook-homebrew',
      theme: new ThemeData(
        brightness:Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF212121),
        accentColor: const Color(0xFF64FFDA),
        canvasColor: const Color(0xFF303030),
        fontFamily: 'Roboto',
      ),
      home: new MyHomePage(),
    );
  }
}
