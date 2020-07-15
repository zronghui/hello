import 'dart:convert';
import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'thingModel.dart';

downloadPath() async {
  var downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
  print('文档目录: ' + downloadsDirectory.path);
  return downloadsDirectory.path;
}

requestStoragePermission() async {
  if (await Permission.storage.request().isGranted) {
    print('request storage permission succeed!');
  }
}

localFile(path) async {
  var file = File('$path/things.json');
  print('json file:' + '$path/things.json');
  bool exists = await file.exists();
  if (!exists) {
    await requestStoragePermission();
    await file.create();
  }
  thingFile = file;
  return file;
}

File thingFile;
localPath() async {
  // var tempDir = await getTemporaryDirectory();
  // String tempPath = tempDir.path;

  var appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;

  // print('临时目录: ' + tempPath);
  print('文档目录: ' + appDocPath);
  return appDocPath;
}

writeJSON(obj) async {
  print('-----write json start-----');
  final file = await localFile(await downloadPath());
  // if (obj.things.length != 0)
  // if (status != PermissionStatus.granted)
  //   await new Future.delayed(new Duration(milliseconds: 10000));
  // await new Future.delayed(new Duration(milliseconds: 2000));
  file.writeAsString(json.encode(obj));
  print('-----write json end-----');
}

readJSON() async {
  print('-----read json start-----');
  await requestStoragePermission();
  final file = await localFile(await downloadPath());
  String str = await file.readAsString();
  // return json.decode(str);
  if (str == '') {
    return [];
  }
  print(json.decode(str));
  print('-----read json end-----');
  return mapToThinglist(json.decode(str)['things']);
}
