import 'package:flutter/material.dart';


/// 路由观察器
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

/// 路由观察器
/// 可以用来监听路由跳转，做用户行为统计，页面停留统计，登录拦截，清除缓存，暂停播放等操作
class AppRouteObserver {
  static final RouteObserver<ModalRoute<void>> _routeObserver =
      RouteObserver<ModalRoute>();

  // 单例
  static final AppRouteObserver _appRouteObserver =
      AppRouteObserver._internal();

  AppRouteObserver._internal();
  //通过单例的get方法轻松获取路由监听器
  RouteObserver<ModalRoute<void>> get routeObserver {
    return _routeObserver;
  }

  factory AppRouteObserver() {
    return _appRouteObserver;
  }

  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    /// 页面进入时
    _routeObserver.didPush(route, previousRoute);
  }

  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    /// 页面退出时
    _routeObserver.didPop(route, previousRoute);
  }
}
