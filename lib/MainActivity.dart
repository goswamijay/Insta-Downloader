import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:provider/provider.dart';

import 'Download File/DownloadHomePage.dart';
import 'Reels/Controller/instatolink.dart';
import 'Reels/VideoPlayer/VideoPlay.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

String? pasteValue;
bool downloading = false;

class _MainActivityState extends State<MainActivity> {
  bool _expanded = false;
  bool _expanded1 = false;
  bool _expanded2 = false;
  bool _expanded3 = false;


  TextEditingController instaLink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String pasteValue = '';
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.pink, Colors.blueAccent],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                    onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => const DownloadHomePage()),
                        ),
                    child: const Icon(
                      Icons.download,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Text(
                    "Instagram Downloader",
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height / 25,
                  ),
                  Consumer<InstaToLink>(
                    builder: (context, videotolink, child) => (Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        controller: instaLink,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Paste A Link',
                            contentPadding: const EdgeInsets.all(30),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onChanged: (value) async {
                          pasteValue = value;
                          print(pasteValue);
                          videotolink.videotolink(pasteValue);
                        },
                      ),
                    )),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          downloadReels();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(243, 244, 246, 1),
                          onPrimary: Colors.black,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                        child: Text(
                          "Paste A Link",
                          style:
                              GoogleFonts.ubuntu(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 85,
                  ),
                  Consumer<InstaToLink>(
                    builder: (context, videotolink, child) => Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            print(InstaToLink.reelsDownloadLink);
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => VideoPlay(
                                        VideoPath:
                                            InstaToLink.reelsDownloadLink,
                                      )),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                          child: Text(
                            "Download",
                            style:
                                GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: SizedBox(
                      width: size.width,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ExpansionPanelList(
                              animationDuration:
                                  const Duration(milliseconds: 1000),
                              dividerColor: Colors.red,
                              elevation: 0,
                              children: [
                                ExpansionPanel(
                                    headerBuilder: (context, isExpanded) {
                                      return ListTile(
                                        title: Center(
                                          child: Text(
                                            "Copy the URL",
                                            style: GoogleFonts.ubuntu(
                                                color: const Color.fromRGBO(
                                                    157, 23, 77, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                        ),
                                      );
                                    },
                                    body: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.0, right: 15.0),
                                          child: Divider(
                                            thickness: 2.0,
                                            endIndent: 2.0,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                child: Center(
                                                  child: Text(
                                                      "Open the Instagram application or website, and copy the URL of the reels.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.ubuntu(
                                                        color: const Color
                                                                .fromRGBO(
                                                            157, 23, 77, 1),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Image(
                                                    height: size.height / 5,
                                                    image: const AssetImage(
                                                        'assets/a1.jpg'))),
                                          ],
                                        ),
                                      ],
                                    ),
                                    isExpanded: _expanded,
                                    canTapOnHeader: true,
                                    backgroundColor: Colors.white),
                              ],
                              expansionCallback: (panelIndex, isExpanded) {
                                _expanded = !_expanded;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: SizedBox(
                      width: size.width,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ExpansionPanelList(
                              animationDuration:
                                  const Duration(milliseconds: 1000),
                              dividerColor: Colors.red,
                              elevation: 0,
                              children: [
                                ExpansionPanel(
                                    headerBuilder: (context, isExpanded) {
                                      return ListTile(
                                        title: Center(
                                          child: Text(
                                            "Paste the link",
                                            style: GoogleFonts.ubuntu(
                                                color: const Color.fromRGBO(
                                                    157, 23, 77, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                        ),
                                      );
                                    },
                                    body: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.0, right: 15.0),
                                          child: Divider(
                                            thickness: 2.0,
                                            endIndent: 2.0,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                child: Center(
                                                  child: Text(
                                                      "Go back to App, paste the link into the field and click the Download button.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.ubuntu(
                                                        color: const Color
                                                                .fromRGBO(
                                                            157, 23, 77, 1),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Image(
                                                    height: size.height / 5,
                                                    image: const AssetImage(
                                                        'assets/a2.jpg'))),
                                          ],
                                        ),
                                      ],
                                    ),
                                    isExpanded: _expanded1,
                                    canTapOnHeader: true,
                                    backgroundColor: Colors.white),
                              ],
                              expansionCallback: (panelIndex, isExpanded) {
                                _expanded1 = !_expanded1;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: SizedBox(
                      width: size.width,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ExpansionPanelList(
                              animationDuration:
                                  const Duration(milliseconds: 1000),
                              dividerColor: Colors.red,
                              elevation: 0,
                              children: [
                                ExpansionPanel(
                                    headerBuilder: (context, isExpanded) {
                                      return ListTile(
                                        title: Center(
                                          child: Text(
                                            "Download Reels Video",
                                            style: GoogleFonts.ubuntu(
                                                color: const Color.fromRGBO(
                                                    157, 23, 77, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                        ),
                                      );
                                    },
                                    body: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.0, right: 15.0),
                                          child: Divider(
                                            thickness: 2.0,
                                            endIndent: 2.0,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                child: Center(
                                                  child: Text(
                                                      "Quickly you will get the results with several quality options. Download what fits your needs.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.ubuntu(
                                                        color: const Color
                                                                .fromRGBO(
                                                            157, 23, 77, 1),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Image(
                                                    height: size.height / 5,
                                                    image: const AssetImage(
                                                        'assets/a2.jpg'))),
                                          ],
                                        ),
                                      ],
                                    ),
                                    isExpanded: _expanded2,
                                    canTapOnHeader: true,
                                    backgroundColor: Colors.white),
                              ],
                              expansionCallback: (panelIndex, isExpanded) {
                                _expanded2 = !_expanded2;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: SizedBox(
                      width: size.width,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ExpansionPanelList(
                              animationDuration:
                              const Duration(milliseconds: 1000),
                              dividerColor: Colors.red,
                              elevation: 0,
                              children: [
                                ExpansionPanel(
                                    headerBuilder: (context, isExpanded) {
                                      return ListTile(
                                        title: Center(
                                          child: Text(
                                            "IG Downloader ❤😍",
                                            style: GoogleFonts.ubuntu(
                                                color: const Color.fromRGBO(
                                                    157, 23, 77, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                        ),
                                      );
                                    },
                                    body: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.0, right: 15.0),
                                          child: Divider(
                                            thickness: 2.0,
                                            endIndent: 2.0,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                child: Center(
                                                  child: Text(
                                                      "Hi Everyone,\n I am Jay Goswami from Gujarat, India. I am a Flutter Junior developer.",
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: GoogleFonts.ubuntu(
                                                        color: const Color
                                                            .fromRGBO(
                                                            157, 23, 77, 1),
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.w700,
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Image(
                                                    height: size.height / 5,
                                                    image: const AssetImage(
                                                        'assets/insta.png'))),
                                          ],
                                        ),
                                      ],
                                    ),
                                    isExpanded: _expanded3,
                                    canTapOnHeader: true,
                                    backgroundColor: Colors.white),
                              ],
                              expansionCallback: (panelIndex, isExpanded) {
                                _expanded3 = !_expanded3;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? taskId;

  void downloadReels() async {
    print("Reels link: $pasteValue");
    FlutterInsta flutterInsta = FlutterInsta();
    String reelsDownloadLink =
        await flutterInsta.downloadReels(instaLink.text); //URL
    print("reelsDownloadLink: " + reelsDownloadLink!);
  }
}
