import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './mine_controller.dart';

class MinePage extends GetView<MineController> {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MinePage')),
      body: Center(child: const Text("我的")),
    );
  }
}
