import 'package:flutter/material.dart';
import 'package:flutter_app/const/_const.dart';
import 'album_model.dart';

class AlbumDetails extends StatefulWidget {

  final Album curAlbum;
  AlbumDetails({@required this.curAlbum});

  @override
  _AlbumDetailsState createState() => _AlbumDetailsState();
}

class _AlbumDetailsState extends State<AlbumDetails> {
  
  
  goToDetailsPage(BuildContext context, Album album) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => AlbumDetails(
              curAlbum: album,
            ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: "image${widget.curAlbum.id}",
              child: FadeInImage.assetNetwork(
                placeholder: PageImage.NO_IMAGE,
                image: widget.curAlbum.url,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            OutlineButton(
              child: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}