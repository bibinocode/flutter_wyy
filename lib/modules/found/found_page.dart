import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './found_controller.dart';

class FoundPage extends GetView<FoundController> {
  const FoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FoundPage')),
      body: Center(child: const Text("发现页")),
    );
  }
}
