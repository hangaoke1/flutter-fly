import 'package:fluro/fluro.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String pageAbout = "/about";
  static String pageHelp = "/help";
  static String pageMovieDetail = "/movieDetail";
  static String singleListDemo = "/singleListDemo";
  static String tabListDemo = "/tabListDemo";
  static String tabList2Demo = "/tabList2Demo";

  static void configureRoutes(Router router) {
    router.notFoundHandler = notFoundHandler;
    router.define(root, handler: rootHandler);
    router.define(pageAbout, handler: aboutHandler);
    router.define(pageHelp,
        handler: helpHandler, transitionType: TransitionType.inFromLeft);
    router.define(pageMovieDetail, handler: movieDetailHandler);
    router.define(singleListDemo, handler: singleListDemoHandler);
    router.define(tabListDemo, handler: tabListDemoHandler);
    router.define(tabList2Demo, handler: tabList2DemoHandler);
  }
}