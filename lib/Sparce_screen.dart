import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomePage.dart';

class Sparce_screen extends StatefulWidget {
  const Sparce_screen({Key? key}) : super(key: key);

  @override
  State<Sparce_screen> createState() => _Sparce_screenState();
}

class _Sparce_screenState extends State<Sparce_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Navigate();
  }

  void Navigate() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (_) => const HomePage()),
              (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        colors: [Colors.red, Colors.pink, Colors.blueAccent],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
    ),
    ),
    child:Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                height: 200,
                  width: 200,
                  image: AssetImage(
                      'assets/insta.png')),
               Padding(
                padding: const EdgeInsets.only(top: 20),
                child:   Text(
                  "Instagram Downloader",
                  style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
      ),
    ),
    );
  }
}