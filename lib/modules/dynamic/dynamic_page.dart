import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './dynamic_controller.dart';

class DynamicPage extends GetView<DynamicController> {
  const DynamicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DynamicPage')),
      body: Center(child: const Text("动态页")),
    );
  }
}
