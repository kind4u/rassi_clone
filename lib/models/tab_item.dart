import 'package:flutter/material.dart';

enum TabBottomShape {
  rounded,    // 둥근 사다리꼴 모양
  rectangle,  // 직사각형 모양
}

class TabItem {
  final String label;
  final Widget content;
  
  const TabItem({
    required this.label,
    required this.content,
  });
  
  Widget getTabContent() => content;
  
  TabItem copyWith({
    String? label,
    Widget? content,
  }) {
    return TabItem(
      label: label ?? this.label,
      content: content ?? this.content,
    );
  }
}