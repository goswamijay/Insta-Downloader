import 'package:flutter/material.dart';
import 'package:instagram_reels_download/HomePage.dart';
import 'package:provider/provider.dart';

import 'Download File/Controller/getDownloadFile.dart';
import 'Reels/Controller/instatolink.dart';
import 'Sparce_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InstaToLink()),
        ChangeNotifierProvider(create: (_) => getStatusProvider()),

      ],
      child:  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Sparce_screen(),
    ),);
  }
}
