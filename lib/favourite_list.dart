import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/main.dart';

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
                    style: bodyTextStyle,
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
                      style: bodyTextStyle,
                    ),
                  ),
                ]
            ).toList();
          }

          return Scaffold(
              appBar: AppBar(
              title: Text(
                'Favourites',
                style: appHeaderTextStyle
              ),
              centerTitle: true,
              backgroundColor: Colors.blue,
              actions: [
                IconButton(
                  icon: Icon(Icons.clear_all), 
                  onPressed: () {
                    setState((){
                      widget.favList.clear();
                    });
                    widget.clearFavourite();
                  },
                ),
              ],
            ),
            body: ListView(children: divided),
        );
  }
}