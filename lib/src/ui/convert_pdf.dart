import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:ebook_homebrew_flutter/src/logics/call_api.dart';
import 'package:ebook_homebrew_flutter/src/logics/convert_base64.dart';
import 'package:ebook_homebrew_flutter/src/utils/utils.dart';
import 'dart:io';
import 'package:ebook_homebrew_flutter/src/utils/file_io.dart';

const String BASEURL = 'https://ebook-homebrew.herokuapp.com';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  String _contentType;
  String _uploadId;
  CallApi callApi = new CallApi(BASEURL);
  Utils utils = new Utils();

  void _openFileExplorer() async {
    try {
      _paths = await FilePicker.getMultiFilePath(
          type: FileType.IMAGE, fileExtension: _extension);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;

    setState(() {
      _fileName = _paths != null ? _paths.keys.toString() : '...';
    });
  }

  void _uploadData() async {
    ConvertBase64 convertbase64 = new ConvertBase64();
    List<String> imagesList =
        convertbase64.createImageb64List(_paths.values.toList());
    _contentType = utils.convertContentType(_extension);
    _uploadId = await callApi.uploadData(_contentType, imagesList);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Complete'),
            content: Text('Upload Complete!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(0),
              ),
            ],
          );
        });
  }

  void _downloadPdf() async {
    await callApi.convertPdf(_contentType, _uploadId);
    List<int> result =
        await callApi.downloadPdfWaiting(_contentType, _uploadId);
    String nowTimestamp = utils.nowDate();
    File file = File('/storage/emulated/0/Download/ebook$nowTimestamp.pdf');
    FileIO fileIO = new FileIO(file);
    fileIO.writeFile(result);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Download Complete'),
            content: Text('filename: $nowTimestamp.pdf'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(0),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Ebook-Homebrew'),
        ),
        body: new Center(
            child: new Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: new DropdownButton(
                      hint: new Text('LOAD PATH FROM'),
                      value: _extension,
                      items: <DropdownMenuItem>[
                        new DropdownMenuItem(
                            child: new Text('FROM  JPEG'), value: 'jpg'),
                        new DropdownMenuItem(
                            child: new Text('FROM PNG'), value: 'png'),
                        new DropdownMenuItem(
                            child: new Text('FROM GIF'), value: 'gif'),
                      ],
                      onChanged: (value) => setState(() {
                            _extension = value;
                          })),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: new RaisedButton(
                    onPressed: () => _openFileExplorer(),
                    child: new Text('Open file picker'),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: new RaisedButton(
                    onPressed: () => _uploadData(),
                    child: new Text('Upload Files'),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: new RaisedButton(
                    onPressed: () => _downloadPdf(),
                    child: new Text('Download PDF'),
                  ),
                ),
                new Builder(
                  builder: (BuildContext context) =>
                      _path != null || _paths != null
                          ? new Container(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: new Scrollbar(
                                  child: new ListView.separated(
                                itemCount: _paths != null && _paths.isNotEmpty
                                    ? _paths.length
                                    : 1,
                                itemBuilder: (BuildContext context, int index) {
                                  final bool isMultiPath =
                                      _paths != null && _paths.isNotEmpty;
                                  final String name = 'File $index: ' +
                                      (isMultiPath
                                          ? _paths.keys.toList()[index]
                                          : _fileName ?? '...');
                                  final path = isMultiPath
                                      ? _paths.values.toList()[index].toString()
                                      : _path;

                                  return new ListTile(
                                    title: new Text(
                                      name,
                                    ),
                                    subtitle: new Text(path),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        new Divider(),
                              )),
                            )
                          : new Container(),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
