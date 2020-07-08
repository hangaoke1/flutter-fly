import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/src/empty_widget.dart';
import 'package:loading_more_list_library/loading_more_list_library.dart';

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget(
    this.status, {
    this.tryAgain,
    this.text,
    this.backgroundColor,
    this.isSliver = false,
    this.emptyWidget,
  });

  ///Status of indicator
  final IndicatorStatus status;

  ///call back of loading failed
  final Function tryAgain;

  ///text to show
  final String text;

  ///background color
  final Color backgroundColor;

  ///whether it need sliver as container
  final bool isSliver;

  ///emppty widget
  final Widget emptyWidget;
  @override
  @override
  Widget build(BuildContext context) {
    Widget widget;
    switch (status) {
      case IndicatorStatus.none:
        widget = Container(height: 0.0);
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 5.0),
              height: 15.0,
              width: 15.0,
              child: getIndicator(context),
            ),
            Text(text ?? 'loading...')
          ],
        );
        widget = _setbackground(false, widget, 35.0);
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 0.0),
              height: 30.0,
              width: 30.0,
              child: getIndicator(context),
            ),
            Text(text ?? 'loading...')
          ],
        );
        widget = _setbackground(true, widget, double.infinity);
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
      case IndicatorStatus.error:
        widget = Text(
          text ?? 'load failed,try again.',
        );
        widget = _setbackground(false, widget, 35.0);
        if (tryAgain != null) {
          widget = GestureDetector(
            onTap: () {
              tryAgain();
            },
            child: widget,
          );
        }
        break;
      case IndicatorStatus.fullScreenError:
        widget = Text(
          text ?? 'load failed,try again.',
        );
        widget = _setbackground(true, widget, double.infinity);
        if (tryAgain != null) {
          widget = GestureDetector(
            onTap: () {
              tryAgain();
            },
            child: widget,
          );
        }
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
      case IndicatorStatus.noMoreLoad:
        widget = Text(text ?? 'No more items.');
        widget = _setbackground(false, widget, 35.0);
        break;
      case IndicatorStatus.empty:
        widget = EmptyWidget(
          text ?? 'nothing here',
          emptyWidget: emptyWidget,
        );
        widget = _setbackground(true, widget, double.infinity);
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
    }
    return widget;
  }

  Widget _setbackground(bool full, Widget widget, double height) {
    widget = Container(
        width: double.infinity,
        height: height,
        child: widget,
        color: backgroundColor ?? Colors.grey[200],
        alignment: Alignment.center);
    return widget;
  }

  Widget getIndicator(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.platform == TargetPlatform.iOS
        ? const CupertinoActivityIndicator(
            animating: true,
            radius: 16.0,
          )
        : CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
          );
  }
}
