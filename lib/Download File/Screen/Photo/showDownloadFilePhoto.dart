import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_reels_download/Download%20File/Screen/Photo/ImageView.dart';
import 'package:provider/provider.dart';

import '../../Controller/getDownloadFile.dart';

class showDownloadFilePhoto extends StatefulWidget {
  const showDownloadFilePhoto({Key? key}) : super(key: key);

  @override
  State<showDownloadFilePhoto> createState() => _showDownloadFilePhotoState();
}

class _showDownloadFilePhotoState extends State<showDownloadFilePhoto> {
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

        body:  Consumer<getStatusProvider>(builder: (context, file, child) {
          if (_isFetched == false) {
            file.getStatus(".jpg");
            Future.delayed(Duration(microseconds: 1));
            _isFetched = true;
          }
          return file.isWhatsappAvailable == false ? const Center(
            child: Text("Whatsapp not Available"),
          ):file.getImages.isEmpty ? const Center(
            child: Text("No Image avaliable"),
          ):Container(
            padding: const EdgeInsets.all(20),
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                children: List.generate(file.getImages.length, (index) {
                  final data = file.getImages[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (_) => ImageView(
                        ImagePath: data.path,
                      )),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(data.path)),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                })),
          );
        }))));
  }
}