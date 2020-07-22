import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_fly/pages/chat/chat_emoji.dart';
import 'package:flutter_fly/pages/chat/chat_func.dart';
import 'package:flutter_fly/utils/fly.dart';

import 'chat_enum.dart';

class ChatInput extends StatefulWidget {
  ChatInput({Key key, this.scrollToBottom, this.sendText}) : super(key: key);

  final scrollToBottom;
  final sendText;

  @override
  ChatInputState createState() => ChatInputState();
}

class ChatInputState extends State<ChatInput> with WidgetsBindingObserver {
  FocusNode _focusNode = FocusNode();
  TextEditingController _editController = TextEditingController();
  ShowType _showType = ShowType.none;
  double _keyboardHeight = 200;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    final mediaQueryData = MediaQueryData.fromWindow(ui.window);
    final keyHeight = mediaQueryData?.viewInsets?.bottom;
    if (keyHeight != 0) {
      // 键盘展开
      if (mounted) {
        setState(() {
          _showType = ShowType.keyboard;
          _keyboardHeight = keyHeight;
        });
        _scrollToBottom();
      }
    } else {
      // 键盘收起
      if (mounted) {
        setState(() {
          if (_showType == ShowType.keyboard) {
            _showType = ShowType.none;
          }
        });
      }
    }
  }

  // 失去焦点
  doBlur() {
    if (_focusNode.hasFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  // 修改底部功能菜单显示类型
  setShowType(ShowType showType) {
    setState(() {
      _showType = showType;
    });
  }

  // 触发滚动到底部
  _scrollToBottom() {
    widget.scrollToBottom();
  }

  // 发送文本内容
  _handleSendText(String text) {
    _editController.clear();
    FocusScope.of(context).requestFocus(_focusNode);
    widget.sendText(text);
  }

  // 获取底部扩展组件
  Widget _genExpand() {
    if (_showType == ShowType.emoji) {
      return ChatEmoji();
    }
    if (_showType == ShowType.func) {
      return ChatFunc();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  height: rpx(70),
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    focusNode: _focusNode,
                    controller: _editController,
                    onSubmitted: _handleSendText,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 16),
                      hintText: "请输入内容...",
                      contentPadding: EdgeInsets.fromLTRB(
                          rpx(30), rpx(10), rpx(10), rpx(10)),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(rpx(50)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {
                  setState(() {
                    _focusNode.unfocus();
                    _showType = ShowType.emoji;
                    _scrollToBottom();
                  })
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Icon(Icons.insert_emoticon),
                ),
              ),
              GestureDetector(
                onTap: () => {
                  setState(() {
                    _focusNode.unfocus();
                    _showType = ShowType.func;
                    _scrollToBottom();
                  })
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
          Container(
            height: _showType == ShowType.keyboard ? _keyboardHeight : 0,
            child: Text(''),
          ),
          _genExpand(),
        ],
      ),
    );
  }
}
