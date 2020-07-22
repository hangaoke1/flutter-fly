import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_fly/utils/theme.dart';

class RefreshUtil {
  static getHeader(BuildContext context) {
    bool isDark = ThemeUtil.isDark(context);
    return ClassicalHeader(
      textColor: isDark ? Colors.white : Colors.black,
      infoColor: isDark ? Colors.white70 : Colors.black87,
      refreshText: '下拉可以刷新',
      refreshReadyText: '松开立即刷新',
      refreshingText: '正在刷新...',
      refreshedText: '已刷新',
      refreshFailedText: '刷新失败',
      noMoreText: '没有更多数据',
      infoText: '最后更新 %T',
    );
  }

  static getFooter(BuildContext context) {
    bool isDark = ThemeUtil.isDark(context);
    return ClassicalFooter(
      textColor: isDark ? Colors.white : Colors.black,
      infoColor: isDark ? Colors.white70 : Colors.black87,
      loadText: '拉动加载',
      loadReadyText: '释放加载',
      loadingText: '正在加载...',
      loadedText: '加载完成',
      loadFailedText: '加载失败',
      noMoreText: '没有更多数据',
      showInfo: false,
    );
  }
}
