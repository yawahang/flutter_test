

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/page/_favourite_list.dart';
import 'package:flutter_app/const/_const.dart';

final GlobalKey<ScaffoldState> wordListKey = new GlobalKey<ScaffoldState>();

class WordListPage extends StatefulWidget {
  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {

  final _suggestions = <WordPair>[];
  var favourite = Set<WordPair>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: wordListKey,
      appBar: AppBar(
        title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[Text(PageName.WORD_LIST,style: PageStyle.HEADER_TEXT),]
              ),
        centerTitle: true,
        backgroundColor: RED,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite), 
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
          backgroundColor: RED
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
            image: AssetImage(PageImage.FLUTTER_ICON_LOGO),
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
          style: PageStyle.BODY_TEXT,
        ),
        trailing: Icon(
          alreadyFavourite ? Icons.favorite : Icons.favorite_border,
          color: alreadyFavourite ? RED : null,
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