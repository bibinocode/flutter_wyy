import 'package:get/get_navigation/get_navigation.dart';
import 'package:wyy_flutter/app/routes/app_routes.dart';
import 'package:wyy_flutter/modules/login/login_bindings.dart';
import 'package:wyy_flutter/modules/login/login_page.dart';

import 'package:wyy_flutter/modules/splash/splash_binding.dart';
import 'package:wyy_flutter/modules/splash/splash_view.dart';

import 'package:wyy_flutter/modules/home/home_view.dart';
import 'package:wyy_flutter/modules/home/home_bindings.dart';

class Routes {
  static final List<GetPage<dynamic>> getPages = [
    // 启动页
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
    // 首页
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBindings(),
    ),
    // 登录
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBindings(),
    ),
  ];
}
