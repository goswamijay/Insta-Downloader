

import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:instagram_reels_download/Download%20File/Screen/Video/ShowDownloadFileVideo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:username_gen/username_gen.dart';
import 'package:video_player/video_player.dart';

import '../../Download File/DownloadHomePage.dart';


class VideoPlay extends StatefulWidget {
  final String? VideoPath;

  const VideoPlay({required this.VideoPath, Key? key}) : super(key: key);

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  Future<void>? _initializeVideoPlayerFuture;

  List<Widget> buttomList = [
    const Icon(Icons.download),
    const Icon(Icons.share),
  ];

  List<String> videoPaths = [];

  ChewieController? _ChewieController;
  double value = 0;
  bool press = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ChewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(widget.VideoPath!),
        autoInitialize: true,
        autoPlay: true,
        looping: true,
        aspectRatio: 9 / 16,
        errorBuilder: (context, error) {
          return Center(
            child: Text(error),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ChewieController!.pause();
    _ChewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: press == false ? FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Chewie(controller: _ChewieController!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ): Center(child: CircularProgressIndicator(value: value * 100 )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                        if (status[Permission.storage] == PermissionStatus.granted &&
                            status[Permission.manageExternalStorage] ==
                                PermissionStatus.granted) {
                          var dir =
                              "/storage/emulated/0";
                          if (dir != null) {
                            final username = UsernameGen().generate(); // sharpened-whiskey87
                            Directory? directory = await getExternalStorageDirectory();
                            String? path = directory?.path;
                            Directory newDirectory = Directory('/storage/emulated/0/Insta Downloader');
                            String savename = "$username.mp4";
                            String savePath = "${newDirectory.path}/$savename";
                            print(savePath);
                            //output:  /storage/emulated/0/Download/banner.png

                            try {
                              await Dio().download(widget.VideoPath!, savePath,
                                  onReceiveProgress: (received, total) {

                                    if (total != -1) {
                                  print("${(received / total * 100)
                                          .toStringAsFixed(0)}%");
                                  CircularProgressIndicator(value: received/total * 100,strokeWidth: 4.0,);
                                  setState(() {
                                    press = true;
                                    value = received/total;
                                  });
                                }else{
                                      setState(() {
                                        press = false;
                                        value = received/total;
                                      });
                                    }
                                  });
                              print("File is saved in Insta Downloader Folder");
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text("File is saved in Insta Downloader Folder")));
                              CupertinoPageRoute(
                                  builder: (_) => const ShowDownloadFileVideo());
                            } on DioError catch (e) {
                              print(e.message);
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text("No permission to read and write.")));
                        }
                        break;
                      case 1:
                        log('Share image');
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text("Please Download File First")));
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

  void download() async{
    FlutterInsta flutterInsta = FlutterInsta();
    await FlutterDownloader.enqueue(
      url: widget.VideoPath!,
      savedDir: '/storage/emulated/0/',
      showNotification: true,
     openFileFromNotification: true,

    ).whenComplete(() {
      print("Print");
    });
  }
}
