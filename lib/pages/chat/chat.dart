import 'dart:async';
import 'package:extended_list/extended_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fly/pages/chat/chat_enum.dart';
import 'package:flutter_fly/pages/chat/chat_input.dart';
import 'package:flutter_fly/utils/fly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_fly/pages/chat/chat_message.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> chatList = [];
  bool _loading = false;
  bool get hasMore => chatList.length < 100;
  ScrollController _scroller = ScrollController();
  GlobalKey<ChatInputState> _chatInputRef = GlobalKey();

  void initState() {
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
    addItems2(text);
  }

  // 加载历史消息loading组件
  Widget _genIndicator() {
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
                  // 失去焦点
                  _chatInputRef.currentState.doBlur();
                  // 重置底部显示菜单
                  _chatInputRef.currentState.setShowType(ShowType.none);
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
                        return _genIndicator();
                      }
                      return ChatMessage(
                        isSelf: true,
                        child: Text('我是服务器拉取的消息${chatList[index]}'),
                      );
                    }),
              ),
            ),
            ChatInput(
              key: _chatInputRef,
              scrollToBottom: _scrollToBottom,
              sendText: _handleSendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
