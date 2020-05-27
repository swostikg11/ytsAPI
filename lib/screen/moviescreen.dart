import 'package:flutter/material.dart';
import '../model/model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MocieScreen extends StatelessWidget {
  final Movie user;
  MocieScreen(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
          child: Text('${user.title}'),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: new ListView(children: <Widget>[
        new Column(children: <Widget>[
          new Image.network('${user.mediumCoverImage}'),
          new Divider(
            color: Colors.green,
            height: 40,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          new Text(
            '${user.synopsis}',
            style: TextStyle(
                fontSize: 13, fontStyle: FontStyle.italic, color: Colors.white),
          ),
          new Divider(
            color: Colors.green,
            height: 40,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          new Container(
            constraints: BoxConstraints.expand(height: 200.0),
            padding: EdgeInsets.all(10),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                color: Colors.green),
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    'Rating',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                  Row(
                    children: <Widget>[
                      new FaIcon(
                        FontAwesomeIcons.imdb,
                        color: Colors.yellow,
                        size: 40,
                      ),
                      new Text(
                        '   =   ${user.rating}',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                  new Center(
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          'Download',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        ),
                        new Row(children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new RaisedButton(
                                  child: Text(
                                    '720P',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.redAccent,
                                  onPressed: () async {
                                    String url = '${user.torrents[0].url}';
                                    if (await canLaunch(url)) {
                                      await launch(url, forceSafariVC: false);
                                    } else {
                                      throw Exception('No Internet Connection');
                                    }
                                  }),
                              new SizedBox(width: 210),
                              new RaisedButton(
                                  child: Text(
                                    '1080P',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.redAccent,
                                  onPressed: () async {
                                    String url = '${user.torrents[1].url}';
                                    if (await canLaunch(url)) {
                                      await launch(url, forceSafariVC: false);
                                    } else {
                                      throw Exception('No Internet Connection');
                                    }
                                  }),
                            ],
                          ),
                        ])
                      ],
                    ),
                  )
                ]),
          ),
        ])
      ]),
    );
  }
}
