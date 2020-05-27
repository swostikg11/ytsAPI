import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/model.dart';
import 'moviescreen.dart';

class YTS extends StatefulWidget {
  @override
  _YTSState createState() => _YTSState();
}

class _YTSState extends State<YTS> {
  Future<User> futureMovies;

  @override
  void initState() {
    // TODO: implement initState
    futureMovies = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: Center(child: new Text('YTS API')),
        actions: <Widget>[],
        backgroundColor: Colors.black,
      ),
      body: new Container(
        child: new FutureBuilder(
          future: futureMovies,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: new Column(
                    children: <Widget>[
                      new SizedBox(height: 300),
                      new Center(
                        child: new Text('No Internet Connection'),
                      ),
                      new SizedBox(height: 20),
                      new Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Stack(
                children: <Widget>[
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
                  ),
                  new Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                  ListView.builder(
                      itemCount: snapshot.data.data.movies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => MocieScreen(
                                            snapshot.data.data.movies[index])));
                              },
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    ),
                                    child: new Image.network(
                                        '${snapshot.data.data.movies[index].largeCoverImage}'),
                                  ),
                                  new Divider(
                                    color: Colors.green,
                                    height: 40,
                                    thickness: 5,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

Future<User> fetchMovies() async {
  String apiUrl = 'https://yts.mx/api/v2/list_movies.json?limit=50';
  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load JSON');
  }
}
