import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fly/utils/fly.dart';

const mockImage = [
  'http://img.alicdn.com/bao/uploaded/i3/TB17fLDFVXXXXbAXXXXXXXXXXXX_!!0-item_pic.jpg_350x350q90.jpg',
  'https://gw.alicdn.com/tfs/TB1hJ2KX6ihSKJjy0FlXXadEXXa-254-318.png',
  'http://img.alicdn.com/bao/uploaded/i1/132110009/TB2hKq3jVXXXXblXpXXXXXXXXXX_!!132110009.jpg_350x350q90.jpg'
];

// ignore: must_be_immutable
class UProductCard extends StatefulWidget {
  UProductCard({Key key, this.index}) : super(key: key);

  int index;
  @override
  _UProductCardState createState() => _UProductCardState();
}

class _UProductCardState extends State<UProductCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(rpx(10)),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: widget.index % 2 == 0 ? mockImage[0] : mockImage[1],
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.all(rpx(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Givenchy 纪梵希 轻盈无痕明星死色散粉 1号色'),
                  Container(
                    height: rpx(10),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '¥',
                        style: TextStyle(color: Colors.red, fontSize: rpx(28)),
                      ),
                      Container(
                        width: rpx(10),
                      ),
                      Text(
                        '240',
                        style: TextStyle(color: Colors.red, fontSize: rpx(32)),
                      ),
                    ],
                  ),
                  Container(
                    height: rpx(10),
                  ),
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(rpx(40)),
                        child: CachedNetworkImage(
                          imageUrl: mockImage[0],
                          fit: BoxFit.fill,
                          width: rpx(40),
                          height: rpx(40),
                        ),
                      ),
                      Container(
                        width: rpx(10),
                      ),
                      Text('小天台你')
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
