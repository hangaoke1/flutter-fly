import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

CancelFunc showLoading({String text = ''}) {
  var close = BotToast.showCustomLoading(toastBuilder: (cancel) {
    return Card(
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(375),
              margin: EdgeInsets.only(
                bottom: ScreenUtil().setWidth(10),
              ),
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  });
  return close;
}

CancelFunc showText({String text = ''}) {
  return BotToast.showText(text: text, align: Alignment(0, 0));
}

var showSimpleNotification = BotToast.showSimpleNotification;

void cleanAll() {
  BotToast.cleanAll();
}
