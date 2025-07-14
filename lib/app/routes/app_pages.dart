import 'package:get/get_navigation/get_navigation.dart';
import 'package:wyy_flutter/app/routes/app_routes.dart';

import 'package:wyy_flutter/modules/splash/splash_binding.dart';
import 'package:wyy_flutter/modules/splash/splash_view.dart';

import 'package:wyy_flutter/modules/home/home_page.dart';
import 'package:wyy_flutter/modules/home/home_bindings.dart';

class Routes {
  static final List<GetPage<dynamic>> getPages = [
    // 启动页
    GetPage(
      name: AppRoutes.SPLASH,
      page: ()=> const SplashPage(),
      binding: SplashBindings(),
    ),
    // 首页
    GetPage(
      name: AppRoutes.HOME,
      page: ()=> const HomePage(),
      binding: HomeBindings(),
    ),
  ];
}