import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackwelth/src/home_src.dart';


void main(){
  runZonedGuarded(() {
    runApp(const SlackNews());
  }, (e, s) {},);
}

class SlackNews extends StatelessWidget {
  const SlackNews({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomePage(),
    );
  }
}

