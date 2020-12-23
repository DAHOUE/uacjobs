import 'package:flutter/material.dart';
import 'package:uac_mcf_project/constante/TextWithStyle.dart';

import 'package:webfeed/webfeed.dart';

import 'constante/date_convertisseur.dart';





// ignore: must_be_immutable
class DetailActuality extends StatelessWidget {
  RssItem rssItem;

  DetailActuality(RssItem rssItem){
    this.rssItem  = rssItem;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Détails sur l\'actualité'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: new SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 60.0,),
              new TextWithStyle(rssItem.title, fontSize: 30.0,),
              SizedBox(height: 30.0,),
              new Card(
                elevation: 10.0,
                child: new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: new Image.network(rssItem.enclosure.url, fit: BoxFit.fill,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Text(new DateConvertisseur().convertirDate(rssItem.pubDate.toString()), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              new TextWithStyle(rssItem.description)
            ],
          ),
        ),
      ),
    );
  }

}