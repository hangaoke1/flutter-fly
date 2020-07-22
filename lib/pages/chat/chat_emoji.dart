import 'package:flutter/material.dart';
import 'package:flutter_fly/utils/fly.dart';

class ChatEmoji extends StatefulWidget {
  ChatEmoji({Key key}) : super(key: key);

  @override
  _ChatEmojiState createState() => _ChatEmojiState();
}

class _ChatEmojiState extends State<ChatEmoji> {
  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      color: scaffoldBackgroundColor,
      width: rpx(750),
      height: rpx(400),
      child: Text('emoji'),
    );
  }
}
