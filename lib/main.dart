// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/favourite_list.dart';

final GlobalKey<ScaffoldState> favScaffoldKey = new GlobalKey<ScaffoldState>();

final appTitle = 'My App';
final appTheme = ThemeData(
        primaryColor: Colors.red,
      );
const appHeaderTextStyle = TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
              );
final bodyTextStyle = TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.grey[800],
                fontFamily: 'IndieFlower',
              );

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: appTheme,
      home: CardList(),
    );
  }
}

class CardList extends StatefulWidget {
  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {

  final _suggestions = <WordPair>[];
  var favourite = Set<WordPair>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: favScaffoldKey,
      appBar: AppBar(
        title: Text(
            'App Title',
            style: appHeaderTextStyle,
          ),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.list), 
            onPressed: () => _addFav(),
          ),
        ],
      ),
      body: _buildCards(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {

              print('button clicked!');
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.red
        ),
    );
  }

  Widget _buildCards() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {

          if (i.isOdd) return Divider(); 

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));  
          }
          return _buildCardContent(_suggestions[index]);
    });
  }

  Widget _buildCardContent(WordPair pair) {    

    final alreadyFavourite = favourite.contains(pair); 
    return ListTile(
        leading: Image(
            image: AssetImage('assets/images/icon-blue-bg.png'),
            fit: BoxFit.cover,
          ),
        //  Image.asset(
        //   'assets/images/icon-blue-bg.png',
        //   fit: BoxFit.cover,
        // ),
        // Image(
        //   image: NetworkImage('https://cdn.auth0.com/blog/illustrations/flutter.png'),
        //   fit: BoxFit.cover,
        // ),
        title: Text(
          pair.asPascalCase,
          style: bodyTextStyle,
        ),
        trailing: Icon(
          alreadyFavourite ? Icons.favorite : Icons.favorite_border,
          color: alreadyFavourite ? Colors.red : null,
        ), 
        onTap: () {
        setState(() {

          if (alreadyFavourite) {       
            favourite.remove(pair);
          } else { 
            favourite.add(pair); 
          }
        });
      },
    );
  }

  _clearFavourite(){
    setState((){
      favourite.clear();
    });
  }

  void _addFav() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => FavouriteList(favourite, _clearFavourite)));   
  }
}