import 'dart:async';
import 'dart:ui' as ui;
import 'package:extended_list/extended_list.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_fly/pages/chat/chat_message.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  List<String> chatList = [];
  bool _loading = false;
  FocusNode _focusNode = FocusNode(); // 初始化一个FocusNode控件

  TextEditingController mEditController = TextEditingController();
  ScrollController _scroller = ScrollController();

  bool showEmoji = false;
  bool _showKeyBoard = false;
  double _keyboardHeight = 200;

  bool get hasMore => chatList.length < 100;

  void initState() {
    WidgetsBinding.instance.addObserver(this);

    // 滚动处理
    _scroller.addListener(() {
      if (!_scroller.hasClients) {
        return;
      }
      // 用户滚动距离
      final double offset = _scroller.position.pixels;
      // 顶部距离
      final double max = _scroller.position.maxScrollExtent;

      // 触发历史消息加载
      if (offset - max == 0 && !_loading && hasMore) {
        _loadHistory();
      } else {
        // print('>>> 不满足');
      }
    });
    _initChatList();
    super.initState();
  }

  @override
  void didChangeMetrics() {
    final mediaQueryData = MediaQueryData.fromWindow(ui.window);
    final keyHeight = mediaQueryData?.viewInsets?.bottom;
    if (keyHeight != 0) {
      if (mounted) {
        setState(() {
          _showKeyBoard = true;
          _keyboardHeight = keyHeight;
          showEmoji = false;
        });
        _scrollToBottom();
      }
    } else {
      if (mounted) {
        setState(() {
          _showKeyBoard = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    // 移除滚动监听器
    _scroller.dispose();
  }

  _initChatList() {
    setState(() {
      chatList = List<String>.generate(3, (i) => (i + 1).toString());
    });
  }

  Future<void> _loadHistory() async {
    if (!_loading) {}
    setState(() {
      _loading = true;
    });
    HapticFeedback.mediumImpact();
    Timer(
      const Duration(milliseconds: 1000),
      () {
        if (mounted) {
          addItems();
          setState(() {
            _loading = false;
          });
        }
      },
    );
    return;
  }

  void addItems() {
    setState(() {
      final List<String> a = <String>[];
      for (var i = 0; i < 30; i++) {
        a.add((-chatList.length - i).toString());
      }
      chatList.addAll(a);
    });
  }

  void addItems2(String text) {
    setState(() {
      chatList.insert(0, text);
    });
    _scrollToBottom();
  }

  void _scrollToBottom({double offset = 0, int milliseconds = 300}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroller.hasClients) {
        return;
      }
      if (milliseconds == 0) {
        _scroller.jumpTo(
          0,
        );
      } else {
        _scroller.animateTo(
          0,
          curve: Curves.easeOut,
          duration: Duration(milliseconds: milliseconds),
        );
      }
    });
  }

  _handleSendMessage(String text) {
    mEditController.clear();
    addItems2(text);
    FocusScope.of(context).requestFocus(_focusNode);
  }

  // 生成底部输入框
  Widget _buildInputTextComposer() {
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Icon(Icons.settings_voice),
              ),
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.send,
                  focusNode: _focusNode,
                  controller: mEditController,
                  onSubmitted: _handleSendMessage,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 16),
                    hintText: "请输入内容...",
                    contentPadding: EdgeInsets.all(5.0),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {
                  setState(() {
                    _focusNode.unfocus();
                    _showKeyBoard = false;
                    showEmoji = true;
                    _scrollToBottom();
                  })
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Icon(Icons.insert_emoticon),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Icon(Icons.add),
              ),
            ],
          ),
          Container(
            height: _showKeyBoard ? _keyboardHeight : 0,
            child: Text(''),
          ),
          showEmoji
              ? Container(
                  color: scaffoldBackgroundColor,
                  width: rpx(750),
                  height: rpx(400),
                  child: Text('emoji表情'),
                )
              : Container()
        ],
      ),
    );
  }

  rpx(double value) {
    return ScreenUtil.getInstance().getWidth(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('ChatList'),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTapUp: (TapUpDetails fd) {
                  if (_focusNode.hasFocus) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                  setState(() {
                    showEmoji = false;
                  });
                },
                child: ExtendedListView.builder(
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    controller: _scroller,
                    reverse: true,
                    extendedListDelegate: const ExtendedListDelegate(
                      closeToTrailing: true,
                    ),
                    itemCount: chatList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == chatList.length) {
                        return Container(
                          padding: EdgeInsets.all(rpx(40)),
                          child: _loading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SpinKitFadingCircle(
                                      color: Colors.black,
                                      size: 20.0,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: rpx(10)),
                                      child: Text('加载中'),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Text(hasMore ? '下拉加载更多消息' : '没有更多啦~'),
                                ),
                        );
                      }
                      return ChatMessage(
                        isSelf: true,
                        child: Html(
                          data: """<span>${chatList[index]}</span>""",
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
                    }),
              ),
            ),
            _buildInputTextComposer(),
          ],
        ),
      ),
    );
  }
}
