import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_fly/pages/chat/chat_message.dart';

/// customer + centerKey解决方案
/// 存在问题：
/// 1. 首次进入页面时候无法立即滚动到底部，当前解决方案，通过hack首发，在首次滚动的时候增加
/// 一个弹窗
/// 2. 键盘拉起，滚动到列表底部，会存在回弹效果
/// 3. 当查看历史消息过多时候，滚动到底部存在性能问题
/// 解决问题：
/// 1. 历史消息查看不会闪屏
/// 2. 新消息添加不会影响历史消息查看
/// 3. 首条消息不会显示在底部

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  List<String> top = [];
  List<String> bottom = [];
  bool _loading = false;
  bool _nomore = false;
  FocusNode _focusNode = FocusNode(); // 初始化一个FocusNode控件

  TextEditingController mEditController = TextEditingController();
  ScrollController _scroller = ScrollController();

  bool mBottomLayoutShow = false;
  bool _initLoading = true;
  double _keyboardHeight = 200;

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
      final double min = _scroller.position.minScrollExtent;

      // 触发历史消息加载
      if (offset - min == 0 && !_loading && !_nomore) {
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
          mBottomLayoutShow = true;
          _keyboardHeight = keyHeight;
        });
        _scrollToBottom(milliseconds: 0);
      }
    } else {
      if (mounted) {
        setState(() {
          mBottomLayoutShow = false;
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
      bottom = List<String>.generate(20, (i) => (i + 1).toString());
    });
    _scrollToBottom(milliseconds: 0);
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        _initLoading = false;
      });
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
        a.add((-top.length - i).toString());
      }
      top.addAll(a);
    });
  }

  void addItems2(String text) {
    setState(() {
      bottom.add(text);
    });
    _scrollToBottom();
  }

  void _scrollToBottom({double offset = 0, int milliseconds = 300}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroller.hasClients) {
        return;
      }
      double max = _scroller.position.maxScrollExtent;
      if (milliseconds == 0) {
        _scroller.jumpTo(
          max,
        );
      } else {
        _scroller.animateTo(
          max,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Icon(Icons.insert_emoticon),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Icon(Icons.add),
              ),
            ],
          ),
          Container(
            height: mBottomLayoutShow ? _keyboardHeight : 0,
            child: Text(''),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    const Key centerKey = ValueKey('second-sliver-list');
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
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      CustomScrollView(
                        controller: _scroller,
                        physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        center: centerKey,
                        slivers: <Widget>[
                          SliverToBoxAdapter(
                            child: Container(
                              alignment: Alignment.center,
                              height: 100.0,
                              child: SpinKitSquareCircle(
                                color: primaryColor,
                                size: 50.0,
                              ),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return ChatMessage(
                                  isSelf: index % 4 == 0,
                                  child: Text(
                                    top[index],
                                    softWrap: true,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              },
                              childCount: top.length,
                            ),
                          ),
                          SliverList(
                            key: centerKey,
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return ChatMessage(
                                  isSelf: index % 2 == 0,
                                  child: index % 3 == 0
                                      ? Image(
                                          image: NetworkImage(
                                              "https://hgkcdn.oss-cn-shanghai.aliyuncs.com/image/APP_promo.png"),
                                          width: 100.0,
                                          height: 1337 / 750 * 100,
                                        )
                                      : Text(
                                          bottom[index],
                                          softWrap: true,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                );
                              },
                              childCount: bottom.length,
                            ),
                          ),
                        ],
                      ),
                      _initLoading
                          ? Positioned(
                              left: 0,
                              top: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: scaffoldBackgroundColor,
                                ),
                                child: Center(child: Text('正在加载')),
                              ),
                            )
                          : Container(),
                    ],
                  )),
            ),
            _buildInputTextComposer(),
          ],
        ),
      ),
    );
  }
}
