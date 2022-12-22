import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'AppConstants.dart';

class getStatusProvider extends ChangeNotifier{


  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];
  bool _isWhatsappAvailable = false;

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  bool get isWhatsappAvailable => _isWhatsappAvailable;

  void getStatus(String ext) async {
    // final status = await Permission.storage.request();
    Map<Permission, PermissionStatus> status = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();
    Map<Permission, PermissionStatus> status1 = await [
      Permission.storage,
    ].request();


    Directory? directory = await getExternalStorageDirectory();
    String? path = directory?.path;
    Directory newDirectory = Directory('/storage/emulated/0/Insta Downloader');
    print(newDirectory);

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo info = await deviceInfo.androidInfo;

    print(info.version.sdkInt.toString());
    if (info.version.sdkInt > 30) {
      if (status[Permission.storage] == PermissionStatus.denied &&
          status[Permission.manageExternalStorage] == PermissionStatus.denied) {
        Permission.storage.request();
        Permission.manageExternalStorage.request();
        log("Permission Denied");
        return;
      }
      if (status[Permission.storage] == PermissionStatus.granted &&
          status[Permission.manageExternalStorage] ==
              PermissionStatus.granted) {
        //final directory = Directory(AppConstants.Whatsapp_path);

        if (newDirectory.existsSync()) {
          final items = newDirectory.listSync();

          if (ext == ".mp4") {
            _getVideos = items.where((element) => element.path.endsWith(".mp4"))
                .toList();
            notifyListeners();
          } else {
            _getImages = items.where((element) => element.path.endsWith(".jpg"))
                .toList();
            _getImages = items.where((element) => element.path.endsWith(".png"))
                .toList();
            notifyListeners();
          }

          _isWhatsappAvailable = true;
          notifyListeners();
          log(items.toString());
        } else {
          _isWhatsappAvailable = false;
          log("No whatsapp found");
          notifyListeners();
        }
        log(directory!.path);
      }
    } else {
      if (status1[Permission.storage] == PermissionStatus.denied) {
        Permission.storage.request();
        log("Permission Denied");
        return;
      }
      if (status[Permission.storage] == PermissionStatus.granted) {
        //final newDirectory = Directory(AppConstants.Whatsapp_path);


        Directory? directory = await getExternalStorageDirectory();
        String? path = directory?.path;
        Directory newDirectory = Directory('/storage/emulated/0/Insta Downloader');

        if (newDirectory.existsSync()) {
          final items = newDirectory.listSync();

          if (ext == ".mp4") {
            _getVideos = items.where((element) => element.path.endsWith(".mp4"))
                .toList();
            notifyListeners();
          } else {
            _getImages = items.where((element) => element.path.endsWith(".jpg"))
                .toList();
            notifyListeners();
          }

          _isWhatsappAvailable = true;
          notifyListeners();
          log(items.toString());
        } else {
          _isWhatsappAvailable = false;
          log("No whatsapp found");
          notifyListeners();
        }
        log(directory!.path);
      }
    }
  }
}