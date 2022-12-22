import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_reels_download/MainActivity.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Account Details/Account_info.dart';
import 'Profile Download/Profile_download.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

/*
 void initializeDownloader() async{
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug : true);
  }
*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permission();
    initPlatformState();
   //initializeDownloader();
  }

  void _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  void permission() async{
    Map<Permission, PermissionStatus> status = await [
    Permission.storage,
      Permission.manageExternalStorage,

      //add more permission to request here.
    ].request();

    if (status[Permission.storage] == PermissionStatus.denied &&
        status[Permission.manageExternalStorage] ==
            PermissionStatus.denied) {
      Permission.storage.request();
    Permission.manageExternalStorage.request();
    log("Permission Denied");
    return;
    }else{
      Directory? directory = await getExternalStorageDirectory();
      String? path = directory?.path;
      Directory newDirectory = Directory('/storage/emulated/0/Insta Downloader');
      await newDirectory.create();
      print(newDirectory.path);
    }
  }
  String _platformVersion = 'Unknown';

  Future<void> initPlatformState() async {
    String? loadMediaMessage = " ";
    try {
      loadMediaMessage = await MediaScanner.loadMedia(
          path: "/storage/emulated/0/Insta Downloader");
    } on PlatformException {
      loadMediaMessage = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _platformVersion = loadMediaMessage!;
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOption = <Widget>[
      const MainActivity(),
      const ProfileDownload(),
      const AccountInfo(),
    ];
    return WillPopScope(
      onWillPop: () {
       return _onWillPop();
      },
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Center(
                child: _widgetOption.elementAt(_selectedIndex),
              ),
              Container(
                height: 80,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.video,
                  size: 19,
                ),
                label: 'Reels'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.photo,
                  size: 19,
                ),
                label: 'Profile Download'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.info_outline,
                  size: 19,
                ),
                label: 'Account Details')
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => exit(0),
        )) ??
        false;
  }
}
