// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:flutter_app/const/_const.dart';
import 'package:flutter_app/page/_page.dart';
import 'package:flutter_app/util/_util.dart';
 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primaryColor: RED,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        PageName.WORD_LIST: (context) => WordListPage(),
        PageName.MESSAGE: (context) => MessagePage(),
      },
    );
  }
}