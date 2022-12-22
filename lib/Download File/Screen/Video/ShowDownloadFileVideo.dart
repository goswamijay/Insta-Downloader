import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'VideoView.dart';
import '../../Controller/getDownloadFile.dart';

class ShowDownloadFileVideo extends StatefulWidget {
  const ShowDownloadFileVideo({Key? key}) : super(key: key);

  @override
  State<ShowDownloadFileVideo> createState() => _ShowDownloadFileVideoState();
}

class _ShowDownloadFileVideoState extends State<ShowDownloadFileVideo> {
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.pink, Colors.blueAccent],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
        child:Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<getStatusProvider>(builder: (context, file, child) {
          if (_isFetched == false) {
            file.getStatus(".mp4");
            Future.delayed(Duration(microseconds: 1));
            _isFetched = true;
          }
          return file.isWhatsappAvailable == false ? const Center(
            child: Text("Whatsapp not Available"),
          ):file.getVideos.isEmpty ? const Center(
            child: Text("No Video avaliable"),
          ):Container(
            padding: const EdgeInsets.all(20),
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                children: List.generate(file.getVideos.length, (index) {
                  final data = file.getVideos[index];
                  return FutureBuilder<String?>(
                      future: getThumbnail(data.path),
                      builder: (context, snapshot) {
                        return  snapshot.hasData ? GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (_) =>  VideoView(VideoPath: data.path,)),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(snapshot.data!)),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ):const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                  );
                })),
          );
        }))));
  }
  Future<String?> getThumbnail(String path)async{
    String? thumb = await VideoThumbnail.thumbnailFile(video: path);
    return thumb;
  }
}