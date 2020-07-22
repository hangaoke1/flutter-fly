import 'package:flutter/material.dart';
import 'package:flutter_fly/utils/fly.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class TplRichText extends StatefulWidget {
  TplRichText({Key key}) : super(key: key);

  @override
  _TplRichTextState createState() => _TplRichTextState();
}

class _TplRichTextState extends State<TplRichText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Html(
        data: """我是一直小猴子，可爱的表情哈哈""",
        shrinkWrap: true,
        style: {
          "html": Style(
            display: Display.INLINE,
            margin: EdgeInsets.all(0),
          ),
          "body": Style(
            display: Display.INLINE,
            margin: EdgeInsets.all(0),
          ),
          ".u-emoji": Style(
            width: rpx(50),
            height: rpx(50),
          ),
        },
      ),
    );
  }
}
