import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/const/_const.dart';
import 'package:flutter_app/page/word_list/word_list_page.dart';
  
final GlobalKey<ScaffoldState> favListKey = new GlobalKey<ScaffoldState>();

class FavouriteList extends StatefulWidget {
  Function clearFavourite;
  Set<WordPair> favList;

  FavouriteList(Set<WordPair> favouriteList, this.clearFavourite): favList = favouriteList;

  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  
  @override
  Widget build(BuildContext context) {
    var tiles = <Widget>[...widget.favList.map(
              (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: PageStyle.BODY_TEXT,
                  ),
                );
              },
            )];
 
          var divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          if(divided.length == 0) {
            
            divided = ListTile.divideTiles(
              context: context,
              tiles: [
                  ListTile(
                    title: Text(
                      'No favourites!',
                      style: PageStyle.BODY_TEXT,
                    ),
                  ),
                ]
            ).toList();
          }

          return Scaffold(
            key: favListKey,
            appBar: AppBar(
            title: Text(
              'Favourites',
              style: PageStyle.HEADER_TEXT
            ),
            centerTitle: true,
            backgroundColor: BLUE,
            actions: [
              IconButton(
                icon: Icon(Icons.clear_all), 
                onPressed: () {
                  
                  if(widget.favList.length > 0){

                       return showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Clear all favourites?"),
                                titleTextStyle: PageStyle.DIALOG_TITLE,
                                titlePadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                                content: Text("Click YES to continue.\n"
                                              "\n"
                                              "Click NO to cancel."),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                contentTextStyle: PageStyle.BODY_TEXT,
                                actions: <Widget>[
                                  FlatButton(
                                      child: Text(
                                        "NO",
                                        style: TextStyle(color: WHITE),
                                      ),
                                      color: RED,
                                      onPressed: () {
            
                                      final snackBarNo =  SnackBar( 
                                           backgroundColor: RED, 
                                           content: Row(
                                             children: <Widget>[                       
                                               Icon(
                                                 Icons.warning,
                                                 color: WHITE,
                                               ),
                                               Text(
                                                 'Action cancelled!',
                                                 style: PageStyle.SNACKBAR_TEXT,
                                               ),
                                             ],
                                           ),
                                          duration: Duration(milliseconds: 5000),
                                        );

                                        favListKey.currentState.showSnackBar(snackBarNo);
                                        Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                      child: Text(
                                        "YES",
                                        style: TextStyle(color: WHITE),
                                      ),
                                      color: BLUE,
                                      onPressed: () {
          
                                        setState((){
                                          widget.favList.clear();
                                        });

                                        widget.clearFavourite();

                                        final snackBarYes =  SnackBar( 
                                                  backgroundColor: BLUE, 
                                                  content: Row(
                                                    children: <Widget>[                       
                                                      Icon(
                                                        Icons.info,
                                                        color: WHITE,
                                                      ),
                                                      Text(
                                                        'Removed all favourites!',
                                                        style: PageStyle.SNACKBAR_TEXT,
                                                      ),
                                                    ],
                                                  ),
                                          duration: Duration(milliseconds: 5000),
                                        );

                                        favListKey.currentState.showSnackBar(snackBarYes);
                                        Navigator.pop(context);
                                      },
                                  ),
                                ],
                                backgroundColor: WHITE,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                              ); 
                              },
                            );
                  }  else {

                    final snackBarNoFav =  SnackBar( 
                               backgroundColor: RED, 
                               content: Row(
                                 children: <Widget>[                       
                                   Icon(
                                     Icons.info,
                                     color: WHITE,
                                   ),
                                   Text(
                                     'No favourites!',
                                     style: PageStyle.SNACKBAR_TEXT,
                                   ),
                                 ],
                               ),
                        duration: Duration(milliseconds: 5000),
                      );

                    favListKey.currentState.showSnackBar(snackBarNoFav);
                  }
                },
              ),
            ],
          ),
          body: ListView(children: divided),
        );
  }
}