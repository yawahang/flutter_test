import "package:flutter/material.dart";
import 'package:flutter_app/const/_const.dart';

final GlobalKey<ScaffoldState> emptyPageKey = new GlobalKey<ScaffoldState>();

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: emptyPageKey,
      appBar: AppBar(
      title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[Text(PageName.EMPTY,style: PageStyle.HEADER_TEXT),]
            ),
      centerTitle: true,
      backgroundColor: RED,
      ),
      body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Quite empty here!',style: PageStyle.BODY_TEXT),
        ),
    );
  }
}
