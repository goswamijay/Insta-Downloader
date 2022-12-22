import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_reels_download/Download%20File/Screen/Photo/showDownloadFilePhoto.dart';
import 'package:instagram_reels_download/HomePage.dart';

import 'Screen/Video/ShowDownloadFileVideo.dart';

class DownloadHomePage extends StatefulWidget {
  const DownloadHomePage({Key? key}) : super(key: key);

  @override
  State<DownloadHomePage> createState() => _DownloadHomePageState();
}

class _DownloadHomePageState extends State<DownloadHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOption = <Widget>[
      const ShowDownloadFileVideo(),
      const showDownloadFilePhoto(),
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
                label: 'Reels Downloaded'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.photo,
                  size: 19,
                ),
                label: 'Photo Downloaded'),

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
      builder: (context) => const HomePage(),
    )) ??
        false;
  }

}

