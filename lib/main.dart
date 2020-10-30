// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

const _appHeaderTextStyle = TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
              );

final _bodyTextStyle = TextStyle(
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
      title: 'My App',
      theme: ThemeData( // overall app theme
        primaryColor: Colors.red,
      ),
      home: RandomWords(),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  
  final _suggestions = <WordPair>[];
  var _favourite = Set<WordPair>();
  
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {

          if (i.isOdd) return Divider(); 

          final index = i ~/ 2;
          if (index >= _suggestions.length) {

            _suggestions.addAll(generateWordPairs().take(10));  
          }
          return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {    

    final alreadyFavourite = _favourite.contains(pair); 
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
          style: _bodyTextStyle,
        ),
        trailing: Icon(
          alreadyFavourite ? Icons.favorite : Icons.favorite_border,
          color: alreadyFavourite ? Colors.red : null,
        ), 
        onTap: () {
        setState(() {

          if (alreadyFavourite) {

            _favourite.remove(pair);
          } else { 

            _favourite.add(pair); 
          }
        });
      },
    );
  }

  void _pushFavourite() {
    Navigator.of(context).push(
      MaterialPageRoute<void>( 
        builder: (BuildContext context) {
           
          var tiles = _favourite.map(
              (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _bodyTextStyle,
                  ),
                );
              },
            );
 
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
                      style: _bodyTextStyle,
                    ),
                  ),
                ]
            ).toList();
          }

        _clearFavourite(BuildContext context) {

            _favourite = Set<WordPair>();
            print('Snackbar closed!');
            final snackBar =  SnackBar( 
              backgroundColor: Colors.red, 
              content: Row(
                children: <Widget>[                       
                  Icon(
                    Icons.warning,
                    color: Colors.white,
                  ),
                  Text(
                    'Removed all favourites!',
                    style: _bodyTextStyle,
                  ),
                ],
              ),
            action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                        
                        print('Snackbar closed!');
                      },
                    ),
              duration: Duration(milliseconds: 1500),
          );

          Scaffold.of(context).showSnackBar(snackBar);
        }

          return Scaffold(
              appBar: AppBar(
              title: Text(
                'Favourites',
                style: _appHeaderTextStyle
              ),
              centerTitle: true,
              backgroundColor: Colors.blue,
              actions: [
                IconButton(
                  icon: Icon(Icons.clear_all), 
                  onPressed: () => _clearFavourite(context),
                ),
              ],
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'App Title',
            style: _appHeaderTextStyle,
          ),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushFavourite),
        ],
      ),
      body: _buildSuggestions(),
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
}

class RandomWords extends StatefulWidget {
  @override
  State<RandomWords> createState() => _RandomWordsState();
}