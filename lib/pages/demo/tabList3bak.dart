import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_more_list/loading_more_list.dart';

class TabList3Demo extends StatefulWidget {
  @override
  _TabList3DemoState createState() => _TabList3DemoState();
}

class _TabList3DemoState extends State<TabList3Demo>
    with TickerProviderStateMixin {
  TabController primaryTC;
  final GlobalKey<NestedScrollViewState> _key =
      GlobalKey<NestedScrollViewState>();
  @override
  void initState() {
    primaryTC = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    primaryTC.dispose();
    super.dispose();
  }

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('refresh');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;
    return NestedScrollViewRefreshIndicator(
      onRefresh: _onRefresh,
      child: NestedScrollView(
        key: _key,
        headerSliverBuilder: (BuildContext c, bool f) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              title: const Text('load more list'),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Image.asset(
                  'images/dm1@2x.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverToBoxAdapter(child: Container(height: 200,child: Text('王老吉'),),),
            SliverToBoxAdapter(child: Container(height: 200,child: Text('加多宝'),),),
            SliverToBoxAdapter(child: Container(height: 200,child: Text('和其正'),),),
          ];
        },
        //1.[pinned sliver header issue](https://github.com/flutter/flutter/issues/22393)
        pinnedHeaderSliverHeightBuilder: () {
          return pinnedHeaderHeight;
        },
        //2.[inner scrollables in tabview sync issue](https://github.com/flutter/flutter/issues/21868)
        innerScrollPositionKeyBuilder: () {
          String index = 'Tab';

          index += primaryTC.index.toString();

          return Key(index);
        },
        body: Column(
          children: <Widget>[
            TabBar(
              controller: primaryTC,
              labelColor: Theme.of(context).primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2.0,
              labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              isScrollable: false,
              unselectedLabelColor: Colors.grey,
              tabs: const <Tab>[
                Tab(text: 'Tab0'),
                Tab(text: 'Tab1'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: primaryTC,
                children: const <Widget>[
                  TabViewItem(Key('Tab0')),
                  TabViewItem(Key('Tab1')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoadMoreListSource extends LoadingMoreBase<int> {
  bool _hasMore = true;
  @override
  bool get hasMore => _hasMore;
  @override
  Future<bool> loadData([bool isloadMoreAction = false]) {
    return Future<bool>.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < 10; i++) {
        this.add(Random().nextInt(400));
      }
      return true;
    });
  }
}

class TabViewItem extends StatefulWidget {
  const TabViewItem(this.tabKey);
  final Key tabKey;
  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem>
    with AutomaticKeepAliveClientMixin {
  LoadMoreListSource source;
  @override
  void initState() {
    source = LoadMoreListSource();
    super.initState();
  }

  @override
  void dispose() {
    source.dispose();
    super.dispose();
  }

  Widget _buildIndicator(BuildContext context, IndicatorStatus status) {
    Widget widget;
    switch (status) {
      case IndicatorStatus.fullScreenBusying:
        widget = SpinKitFadingCube(
          color: Theme.of(context).primaryColor,
          size: 40.0,
        );
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = SpinKitThreeBounce(
          color: Theme.of(context).primaryColor,
          size: 40.0,
        );
        break;
      default:
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final LoadingMoreList<int> child = LoadingMoreList<int>(
      ListConfig<int>(
        physics: const ClampingScrollPhysics(),
        indicatorBuilder: _buildIndicator,
        itemBuilder: (BuildContext c, int item, int index) {
          return GestureDetector(
            onTap: () {
              source.remove(item);
              source.setState();
            },
            child: Container(
              alignment: Alignment.center,
              height: 60.0,
              child: Text(
                  widget.tabKey.toString() + ': ListView${item.toString()}'),
            ),
          );
        },
        sourceList: source,
      ),
    );

    return NestedScrollViewInnerScrollPositionKeyWidget(widget.tabKey, child);
  }

  @override
  bool get wantKeepAlive => true;
}
