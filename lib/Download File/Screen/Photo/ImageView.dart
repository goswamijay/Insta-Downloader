import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageView extends StatefulWidget {
  final String? ImagePath;
  const ImageView({required this.ImagePath, Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  List<Widget> buttomList = [
    const Icon(Icons.share),
  ];

  List<String> imagePaths = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
                fit: BoxFit.contain,
                image: FileImage(File(widget.ImagePath!)))),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(
            buttomList.length,
                (index) {
              return FloatingActionButton(
                  onPressed: () async {

                        log('Share image');
                        imagePaths.add(widget.ImagePath!);
                        Share.shareFiles(imagePaths);
                    },
                  child: buttomList[index]);
            },
          ),
        ),
      ),
    );
  }
}