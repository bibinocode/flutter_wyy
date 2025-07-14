import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
    const HomePage({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('HomePage'),),
            body: Column(
              children: [
                const Text('HomePage'),
              ],
            ),
        );
    }
}