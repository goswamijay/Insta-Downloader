import 'package:flutter/cupertino.dart';
import 'package:flutter_insta/flutter_insta.dart';


class InstaToLink with ChangeNotifier{

 //static String reelsDownloadLink = "https://scontent.cdninstagram.com/v/t66.30100-16/318709276_195701076350950_5989385882155318428_n.mp4?_nc_ht=scontent.cdninstagram.com&_nc_cat=110&_nc_ohc=hmJ0K1J-lCAAX-lcWfN&edm=AJBgZrYBAAAA&ccb=7-5&oh=00_AfAtvB8fSa4fRzc0p7ApSMpAX6qCVWeWAfa-d4ZxtY1p6Q&oe=639F3E49&_nc_sid=78c662";

  static String reelsDownloadLink = "";
  void videotolink(String url) async {
    FlutterInsta flutterInsta = FlutterInsta();
    reelsDownloadLink = await flutterInsta.downloadReels(url); //URL
    print("reelsDownloadLink: $reelsDownloadLink");
    notifyListeners();
  }
}