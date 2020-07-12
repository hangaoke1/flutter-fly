import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fly/components/g_photo_view/index.dart';
import 'package:flutter_fly/utils/fly.dart';
import 'package:flutter_fly/utils/theme.dart';
import 'package:route_transitions/route_transitions.dart';

import 'g_icon/index.dart';

// 用户动态
// ignore: must_be_immutable
class UserDynamic extends StatefulWidget {
  UserDynamic({Key key, this.id}) : super(key: key);

  int id;
  @override
  _UserDynamicState createState() => _UserDynamicState();
}

const mockImage = [
  'http://img.alicdn.com/bao/uploaded/i3/TB17fLDFVXXXXbAXXXXXXXXXXXX_!!0-item_pic.jpg_350x350q90.jpg',
  'http://img.alicdn.com/bao/uploaded/i1/TB1JePFKFXXXXaYXVXXXXXXXXXX_!!0-item_pic.jpg_350x350q90.jpg',
  'http://img.alicdn.com/tfscom/i4/654230132/O1CN011CqUjXBxyNTXTMy_!!654230132.jpg_360x360xzq90.jpg'
];

class _UserDynamicState extends State<UserDynamic> {
  void renderImage(index, images) {
    Navigator.of(context).push(PageRouteTransition(
      animationType: AnimationType.scale,
      builder: (context) => PhotoViewGalleryScreen(
        images: images,
        index: index,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = Theme.of(context).cardColor;
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    TextStyle subTextStyle = Theme.of(context).textTheme.subtitle1;
    return Container(
      decoration: BoxDecoration(color: cardColor),
      padding: EdgeInsets.all(rpx(30)),
      margin: EdgeInsets.only(bottom: rpx(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: rpx(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(rpx(100)),
                  child: CachedNetworkImage(
                    imageUrl:
                        'http://wwc.alicdn.com/avatar/getAvatar.do?userNick=&width=150&height=150&type=sns&_input_charset=UTF-8',
                    width: rpx(100),
                    height: rpx(100),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: rpx(10),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '小王爱喝',
                        style: textStyle.copyWith(
                          fontSize: rpx(32),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: rpx(10)),
                        child: GIcon(
                          type: 0xe644,
                          size: rpx(30),
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: rpx(4),
                  ),
                  Text(
                    '今天 20:17',
                    style: subTextStyle.copyWith(
                      fontSize: rpx(22),
                    ),
                  )
                ],
              )
            ],
          ),
          Container(
            height: rpx(20),
          ),
          Text('当舞蹈生好难啊当舞蹈生好难啊当舞蹈生好难啊当舞蹈生好难啊当舞蹈生好难啊~'),
          Container(
            height: rpx(20),
          ),
          Wrap(
            children: <Widget>[
              ...mockImage.asMap().keys.map(
                    (index) => GestureDetector(
                      onTap: () {
                        renderImage(index, mockImage);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(right: rpx(20), bottom: rpx(20)),
                        child: CachedNetworkImage(
                          imageUrl: mockImage[index],
                          width: rpx(210),
                          height: rpx(210),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
            ],
          ),
          Container(
            height: rpx(20),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GIcon(
                      type: 0xe7aa,
                      size: rpx(32),
                      color: Colors.pink,
                    ),
                    Container(
                      width: rpx(10),
                    ),
                    Text(
                      '100',
                      style: subTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GIcon(
                      type: 0xe7f6,
                      size: rpx(32),
                      color: Colors.blue[200],
                    ),
                    Container(
                      width: rpx(10),
                    ),
                    Text(
                      '100',
                      style: subTextStyle,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
