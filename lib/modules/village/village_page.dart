import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './village_controller.dart';

class VillagePage extends GetView<VillageController> {
  const VillagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VillagePage')),
      body: Center(child: const Text("漫游")),
    );
  }
}
