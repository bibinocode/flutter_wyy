import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:wyy_flutter/app/routes/app_route_observer.dart';
import 'package:wyy_flutter/core/utils/adapt.dart';
import 'package:wyy_flutter/core/utils/common_util.dart';
import './home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 加入 KeepALive 组件
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with RouteAware, AutomaticKeepAliveClientMixin {
  final HomeController controller = Get.put<HomeController>(HomeController());

  @override
  bool get wantKeepAlive => true;

  Future<bool> _dialogExitApp(BuildContext context) async {
    // 在安卓端的时候，让系统认为用户想回到桌面，不会真正的退出应用 应用会被最小化到后台
    if (GetPlatform.isAndroid) {
      // 只在 Android 平台执行
      const intent = AndroidIntent(
        action: 'android.intent.action.MAIN', // 告诉系统这是主活动
        category: "android.intent.category.HOME", // 告诉系统这是桌面应用
      );
      await intent.launch(); // 启动桌面
    }
    return Future.value(false); // 阻止应用退出
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 在 didChangeDependencies 中订阅路由变化
    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    // 在 dispose 中取消订阅路由变化
    AppRouteObserver().routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PopScope(
      canPop: false, // 先拦截
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _dialogExitApp(context);
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: getSystemUiOverlayStyle(isDark: false),
        child: Scaffold(
          backgroundColor: Theme.of(context).hoverColor, // 背景色
          extendBodyBehindAppBar: true, // 让 AppBar 不占用空间,因为 我们用定位来实现
          resizeToAvoidBottomInset: false, // 防止身体内部的小部件被键盘遮盖。也就是关闭后，页面会自动上移
          extendBody: true, // 让 body 可以延伸到 AppBar 下面
          body: Stack(
            // Stack 相当于一个容器，可以包含多个子组件，子组件可以重叠，相当于 css中的 position: relative;
            children: [
              // Positioned.fill 相当于 css 中的 position: absolute; top: 0; left: 0; right: 0; bottom: 0;
              Positioned.fill(child: Container(color: Colors.red)),
              Positioned(
                top: 0,
                child: Container(
                  width: Adapt.screenW(),
                  height: Adapt.px(44),
                  margin: EdgeInsets.only(top: Adapt.topPadding()),
                  color: Colors.amber,
                  child: Row(
                    children: [
                      Text(
                        '左侧内容',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      // 撑开
                      Expanded(child: Container()),
                      Text(
                        '右侧内容',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
