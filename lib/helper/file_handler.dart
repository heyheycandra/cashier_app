import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';

class DownloadHandler {
  Future<Directory> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      var strDir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      return Directory(strDir);
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  static Future<Directory> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory
    Directory _appDocDir;
    if (Platform.isAndroid) {
      List<String> extStorage = await ExternalPath.getExternalStorageDirectories();
      _appDocDir = Directory(extStorage[0]);
    } else {
      _appDocDir = await getApplicationDocumentsDirectory();
    }

    //App Document Directory + folder name
    final Directory _appDocDirFolder = Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder;
    }
  }
}
