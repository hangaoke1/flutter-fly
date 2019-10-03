import 'package:flutter/material.dart';

class Story extends StatefulWidget {
  Story({Key key}) : super(key: key);

  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('小说', style: TextStyle(fontSize: 22)),
    );
  }
}
