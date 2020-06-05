import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fly/router/application.dart';

class Movie extends StatefulWidget {
  Movie({Key key}) : super(key: key);

  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            alignment: Alignment.center,
            child: Text('电影', style: TextStyle(fontSize: 22))),
        onTap: () {
          Application.router.navigateTo(context, '/movieDetail?id=111', transition: TransitionType.native);
        });
  }
}
