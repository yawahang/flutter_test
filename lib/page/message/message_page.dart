import "package:flutter/material.dart";
import 'package:flutter_app/const/_const.dart';

final GlobalKey<ScaffoldState> messageKey = new GlobalKey<ScaffoldState>();

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: messageKey,
      appBar: AppBar(
      title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[Text(PageName.MESSAGE,style: PageStyle.HEADER_TEXT),]
            ),
      centerTitle: true,
      backgroundColor: RED,
      ),
      body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Hello world!',style: PageStyle.BODY_TEXT),
        ),
    );
  }
}
