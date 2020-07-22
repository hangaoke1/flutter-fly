import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class GPhotoView extends StatefulWidget {
  final List images;
  final int index;
  final String heroTag;
  PageController controller;

  GPhotoView({
    Key key,
    @required this.images,
    this.index = 0,
    this.controller,
    this.heroTag,
  }) : super(key: key) {
    controller = PageController(initialPage: index);
  }

  @override
  _GPhotoViewState createState() => _GPhotoViewState();
}

class _GPhotoViewState extends State<GPhotoView> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              // TODO: 支持视频
              child: PhotoViewGallery.builder(
                backgroundDecoration: BoxDecoration(color: Colors.black),
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    minScale: 1.0,
                    maxScale: 3.0,
                    // imageProvider: NetworkImage(widget.images[index]),
                    imageProvider:
                        CachedNetworkImageProvider(widget.images[index]),
                    heroAttributes:
                        widget.heroTag != null && widget.heroTag.isNotEmpty
                            ? PhotoViewHeroAttributes(tag: widget.heroTag)
                            : null,
                  );
                },
                itemCount: widget.images.length,
                loadingBuilder: null,
                pageController: widget.controller,
                enableRotation: false,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                "${currentIndex + 1}/${widget.images.length}",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
