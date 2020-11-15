import "package:flutter/material.dart";
import 'package:flutter_app/const/_const.dart';
import 'package:flutter_app/util/_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
 
  Widget _item(context, index) {
    return InkWell(
      child: Card(
        child: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(PAGE_ITEMS[index]["img"]),
                  fit: BoxFit.cover,
                ),
              ),
          ),
          Center(
            child: Text(
              PAGE_ITEMS[index]["title"],
              style: TextStyle(
                  color: RED,
                  fontSize: TEXT_LARGE,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      )),
      onTap: () {
        Navigator.pushNamed(context, PAGE_ITEMS[index]["click"]);
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    SizeUtil.getInstance(key: SizeKeyConst.DEVICE_KEY).logicSize =
    MediaQuery.of(context).size;
    SizeUtil.initDesignSize();
    return Scaffold(
      appBar: AppBar(
         leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
                  image: AssetImage(PageImage.FLUTTER_ICON_LOGO),
                  fit: BoxFit.cover,
                ),
        ),
        title: Text('Home'),
      ),
      body: GridView.builder(
        itemCount: PAGE_ITEMS.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 2),
        itemBuilder: (context, index) {
          return _item(context, index);
        },
      ),
    );
  }
}