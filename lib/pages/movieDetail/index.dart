import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({
    Key key,
    this.id,
  }) : super(key: key);

  final String id;

  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  String id;
  @override
  void initState() {
    id = widget.id;
    super.initState();
    print('hello 韩高钶');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('电影详情'), elevation: 0.5),
      body: Center(
        child: Container(
          child: Text('电影' + id),
        ),
      ),
    );
  }
}
