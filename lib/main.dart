import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:incredibleapp/FlutterMap.dart';
import 'package:incredibleapp/HomePage.dart';
import 'package:incredibleapp/PolyLinePage.dart';

import 'CustomMarkerInfoWindowState.dart';
import 'colors.dart';
import 'onBoard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      color: AppColors.mainColor,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OnBoard(),
    );
  }
}
