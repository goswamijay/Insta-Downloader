import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Download File/DownloadHomePage.dart';
import '../Profile Download/ImageView.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  bool _expanded = false;

  TextEditingController instaLink = TextEditingController();
  bool pressed = false;
  String username = " ";
  String? followers = " ", following, bio, website;
  String profileimage = "";

  //get data from api
  Future printDetails(String username) async {
    FlutterInsta flutterInsta = FlutterInsta();

    await flutterInsta.getProfileData(username);
    setState(() {
      username = flutterInsta.username; //username
      followers = flutterInsta.followers; //number of followers
      following = flutterInsta.following; // number of following
      website = flutterInsta.website; // bio link
      bio = flutterInsta.bio; // Bio
      profileimage = flutterInsta.imgurl; // Profile picture URL
      print(followers);
    });
  }

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
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: TextField(
                      controller: instaLink,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Enter Account User Name Ex:-viratkohli',
                          contentPadding: const EdgeInsets.all(30),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onChanged: (value) async {
                        pasteValue = value;
                        print(pasteValue);
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height / 85,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            pressed = true;
                          });

                          printDetails(instaLink.text); //get Data
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
                  pressed
                      ? SingleChildScrollView(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              child: Container(
                                margin: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(builder: (_) => ImageView(
                                    ImagePath: profileimage,
                                  )),
                                ),child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        "$profileimage",
                                        width: 150,
                                      ),
                                    ),),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                                    Text(
                                      username,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "$followers\nFollowers",
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "$following\nFollowing",
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                                    Text(
                                      "$bio",
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      "$website",
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
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
                                            "Enter The Instagram Username",
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
                                                      "Enter The instagram username like  username is :-mahi7781,and Click on Download Button and and show all details like Profile Picture, Followers , Following , Bio and Website of the account....",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
