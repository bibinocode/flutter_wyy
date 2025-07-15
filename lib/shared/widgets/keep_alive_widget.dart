import 'package:flutter/material.dart';

/// KeepAlive 包裹组件
class KeepAliveWidget extends StatefulWidget {
  final Widget child;
  const KeepAliveWidget({super.key, required this.child});

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWidget> 
with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
  
  @override
  bool get wantKeepAlive => true;
}
