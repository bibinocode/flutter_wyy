import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyy_flutter/config/themes/app_themes.dart';
import 'package:wyy_flutter/core/utils/adapt.dart';
import 'package:wyy_flutter/core/utils/image_utils.dart';
import 'package:wyy_flutter/modules/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBottom extends StatefulWidget {
  const HomeBottom({super.key});

  @override
  State<HomeBottom> createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom>
    with SingleTickerProviderStateMixin {
  // 控制器
  final controller = Get.find<HomeController>();
  // 动画控制器
  late AnimationController _animationController;

  Widget _getBarIcon(int index, bool isActive) {
    String path;
    switch (index) {
      case 0:
        path = 'tab_recommend_prs';
        break;
      case 1:
        path = 'tab_discover_prs';
        break;
      case 2:
        path = 'tab_roam_prs';
        break;
      case 3:
        path = 'tab_icn_social';
        break;
      default:
        path = 'tab_icn_user';
    }

    return ClipOval(
      child: Container(
        width: 26,
        height: 26,
        padding: EdgeInsets.all(3),
        decoration: isActive
            ? const BoxDecoration(
                color: AppThemes.tabColor,
                shape: BoxShape.circle,
              )
            : const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
        child: Image.asset(
          ImageUtils.getImagePath(path),
          color: isActive
              ? Colors.white
              : Get.isDarkMode
              ? const Color.fromRGBO(187, 187, 188, 1.0)
              : AppThemes.tabGreyColor,
        ),
      ),
    );
  }

  Text _getBarText(int index) {
    switch (index) {
      case 0:
        return Text(
          '推荐',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        );
      case 1:
        return Text(
          '发现',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        );
      case 2:
        return Text(
          '漫游',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        );
      case 3:
        return Text(
          '动态',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        );
      default:
        return Text(
          '我的',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49 + Adapt.bottomPadding(),
      color: const Color.fromRGBO(146, 151, 161, 1.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 主轴最小化？做什么用？ 主轴是垂直方向，最小化就是最小高度
        children: [
          Obx(
            () => BottomBar(
              currnetIndex: controller.currentIndex.value,
              height: 49 + Adapt.bottomPadding(),
              focusColor: AppThemes.tabColor,
              unFocusColor: AppThemes.tabGreyColor,
              onTap: (index) {
                controller.changePage(index);
                _animationController.forward(); // 动画开始
              },
              items: List<BottomBarItem>.generate(
                5,
                (int index) => BottomBarItem(
                  icon: _getBarIcon(index, false),
                  title: _getBarText(index),
                  activeIcon: _getBarIcon(index, true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  /// 当前选中项
  final int currnetIndex;

  /// 高度
  final double height;

  /// 底部导航栏项
  final List<BottomBarItem> items;

  /// 选中颜色
  final Color focusColor;

  /// 未选中颜色
  final Color unFocusColor;

  /// 事件
  final ValueChanged<int> onTap;
  const BottomBar({
    super.key,
    this.currnetIndex = 0,
    this.items = const [],
    required this.height,
    required this.focusColor,
    required this.unFocusColor,
    required this.onTap,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Widget _createItem(int index) {
    final bottmItems = widget.items[index];
    final bool selected = index == widget.currnetIndex;

    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          color: Colors.transparent,
          child: InkResponse(
            onTap: () async {
              widget.onTap(index);
            },
            highlightShape: BoxShape.circle,
            radius: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                if (selected) bottmItems.activeIcon else bottmItems.icon,
                const SizedBox(height: 2),
                DefaultTextStyle.merge(
                  style: TextStyle(
                    color: selected ? widget.focusColor : widget.unFocusColor,
                  ),
                  child: bottmItems.title,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];

    for (int i = 0; i < widget.items.length; i++) {
      children.add(_createItem(i));
    }

    return SizedBox(
      height: widget.height,
      width: Adapt.screenW(),
      child: Stack(
        // 磨砂效果 模糊效果
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Get.isDarkMode
                      ? AppThemes.darkTabBgColor
                      : AppThemes.tabBgColor,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBarItem {
  final Widget icon;
  final Widget activeIcon;
  final Widget title;
  BottomBarItem({
    required this.icon,
    required this.activeIcon,
    required this.title,
  });
}
