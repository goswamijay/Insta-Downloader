import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:instagram_reels_download/Download%20File/Screen/Photo/showDownloadFilePhoto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:username_gen/username_gen.dart';

import '../Download File/DownloadHomePage.dart';

class ImageView extends StatefulWidget {
  final ImagePath;
  const ImageView({this.ImagePath, Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  List<Widget> buttomList = [
    const Icon(Icons.download),
  ];

  List<String> imagePaths = [];
  String profileimage = "";

  double value = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printDetails(widget.ImagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(widget.ImagePath))),
            ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(
            buttomList.length,
            (index) {
              return FloatingActionButton(
                  heroTag: "$index",
                  onPressed: () async {
                    switch (index) {
                      case 0:
                        log('download image');
                        Map<Permission, PermissionStatus> status = await [
                          Permission.storage,
                          Permission.manageExternalStorage,
                        ].request();

                        if (status[Permission.storage] ==
                                PermissionStatus.granted &&
                            status[Permission.manageExternalStorage] ==
                                PermissionStatus.granted) {
                          var dir = "/storage/emulated/0";
                          if (dir != null) {
                            final username =
                                UsernameGen().generate(); // sharpened-whiskey87
                            Directory? directory =
                                await getExternalStorageDirectory();
                            String? path = directory?.path;
                            Directory newDirectory = Directory(
                                '/storage/emulated/0/Insta Downloader');
                            String savename = "$username.jpg";
                            String savePath = newDirectory.path + "/$savename";
                            print(savePath);
                            //output:  /storage/emulated/0/Download/banner.png

                            try {
                              await Dio().download(widget.ImagePath!, savePath,
                                  onReceiveProgress: (received, total) {
                                if (total != -1) {
                                  print(
                                      "${(received / total * 100).toStringAsFixed(0)}%");
                                }
                              });
                              print("File is saved in Insta Downloader Folder");
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text("File is saved in Insta Downloader Folder")));
                              CupertinoPageRoute(
                                  builder: (_) => const showDownloadFilePhoto());
                            } on DioError catch (e) {
                              print(e.message);
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "No permission to read and write.")));
                        }
                        break;
                    }
                  },
                  child: buttomList[index]);
            },
          ),
        ),
      ),
    );
  }

  //get data from api
  Future printDetails(String username) async {
    try {
      FlutterInsta flutterInsta = FlutterInsta();

      await flutterInsta.getProfileData(username);
      setState(() {
        username = flutterInsta.username; //username
        profileimage = flutterInsta.imgurl; // Profile picture URL
        print(username);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
