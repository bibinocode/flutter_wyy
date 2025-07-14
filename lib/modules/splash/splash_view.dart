import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wyy_flutter/config/themes/app_themes.dart';
import 'package:wyy_flutter/core/utils/image_util.dart';
import 'splash_controller.dart';
import 'package:wyy_flutter/core/utils/adapt.dart';

class SplashPage extends GetView<SplashController> {

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 初始化屏幕宽高比
    Adapt.initContext(context);
    return Scaffold(
      backgroundColor: AppThemes.appMain,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          padding: EdgeInsets.only(top: controller.isFirst ? 100 : 255),
          width: Adapt.screenW(),
          height: Adapt.screenH(),
          child: Column(
            children: [buildContent()],
          ),
        ),
      ),
    );
  }

  Widget buildContent(){
    if(controller.isFirst){
      return Image.asset('assets/anim/cif.webp');
    }else{
      return Image.asset(ImageUtil.getImagePath('erq'),
        height: 94,
        width: 94,);
    }
  }
}