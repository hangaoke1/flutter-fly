import 'package:fluro/fluro.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String login = "/login";
  static String user = "/user";
  static String setting = "/setting";
  static String pageMovieDetail = "/movieDetail";
  static String pageHelp = "/help";
  static String singleListDemo = "/singleListDemo";
  static String tabListDemo = "/tabListDemo";
  static String tabList2Demo = "/tabList2Demo";
  static String tabList3Demo = "/tabList3Demo";

  static void configureRoutes(Router router) {
    router.notFoundHandler = notFoundHandler;
    router.define(login, handler: loginHandler);
    router.define(root, handler: rootHandler);
    router.define(user, handler: userHandler);
    router.define(setting, handler: settingHandler);
    router.define(pageMovieDetail, handler: movieDetailHandler);
    router.define(singleListDemo, handler: singleListDemoHandler);
    router.define(tabListDemo, handler: tabListDemoHandler);
    router.define(tabList2Demo, handler: tabList2DemoHandler);
    router.define(tabList3Demo, handler: tabList3DemoHandler);
  }
}
