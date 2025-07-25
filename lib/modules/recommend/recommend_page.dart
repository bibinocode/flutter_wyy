import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './recommend_controller.dart';

class RecommendPage extends GetView<RecommendController> {
  const RecommendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RecommendPage')),
      body: Center(child: const Text("推荐页面")),
    );
  }
}
