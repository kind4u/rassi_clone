import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:rassi_clone/models/hot_issue_model.dart';

/// 색상 pair (배경색 + 텍스트색)
class BubbleColorPair {
  final Color background;
  final Color text;

  const BubbleColorPair({required this.background, required this.text});
}

/// 위치가 계산된 버블 데이터
class PositionedBubble {
  final String label;
  final double radius;
  final Color color;
  final Color textColor;
  double x;
  double y;

  PositionedBubble({
    required this.label,
    required this.radius,
    required this.color,
    required this.textColor,
    this.x = 0,
    this.y = 0,
  });
}

/// Circle Packing 알고리즘
///
/// [colorPalette] 양수 값에 적용할 색상 목록 (낮음→높음 순서)
/// [zeroColor]    value == 0 인 버블 색상
/// [negativeColor] value < 0 인 버블 색상
class BubbleCloudPacker {
  final double width;
  final double height;
  final double minRadius;
  final double maxRadius;
  final List<BubbleColorPair> colorPalette;
  final BubbleColorPair zeroColor;
  final BubbleColorPair negativeColor;
  final double spacing;

  const BubbleCloudPacker({
    required this.width,
    required this.height,
    this.minRadius = 25,
    this.maxRadius = 55,
    required this.colorPalette,
    required this.zeroColor,
    required this.negativeColor,
    this.spacing = 2,
  });

  List<PositionedBubble> pack(List<HotIssueItem> items) {
    if (items.isEmpty) return [];

    final sortedItems = List<HotIssueItem>.from(items)
      ..sort((a, b) => b.value.compareTo(a.value));

    final positiveItems = sortedItems.where((item) => item.value > 0).toList();
    final maxValue = positiveItems.isNotEmpty ? positiveItems.first.value : 1;
    final minValue = positiveItems.isNotEmpty ? positiveItems.last.value : 1;
    final valueRange = maxValue - minValue;

    final bubbles = <PositionedBubble>[];
    final centerX = width / 2;
    final centerY = height / 2;

    for (var i = 0; i < sortedItems.length; i++) {
      final item = sortedItems[i];

      double radius;
      Color bgColor;
      Color txtColor;

      if (item.value < 0) {
        radius = minRadius;
        bgColor = negativeColor.background;
        txtColor = negativeColor.text;
      } else if (item.value == 0) {
        radius = minRadius;
        bgColor = zeroColor.background;
        txtColor = zeroColor.text;
      } else {
        final normalizedValue = valueRange > 0
            ? (item.value - minValue) / valueRange
            : 0.5;
        radius = minRadius + (maxRadius - minRadius) * normalizedValue;

        final colorIndex = (normalizedValue * (colorPalette.length - 1))
            .round();
        final colorPair = colorPalette[colorPalette.length - 1 - colorIndex];
        bgColor = colorPair.background;
        txtColor = colorPair.text;
      }

      final bubble = PositionedBubble(
        label: item.label,
        radius: radius,
        color: bgColor,
        textColor: txtColor,
      );

      if (i == 0) {
        bubble.x = centerX;
        bubble.y = centerY;
      } else {
        _findPosition(bubble, bubbles, centerX, centerY);
      }

      bubbles.add(bubble);
    }

    return bubbles;
  }

  void _findPosition(
    PositionedBubble bubble,
    List<PositionedBubble> existing,
    double centerX,
    double centerY,
  ) {
    double angle = 0;
    double distance = 0;
    const double angleStep = 0.3;
    const double distanceStep = 3;
    const int maxAttempts = 2000;

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final x = centerX + distance * math.cos(angle);
      final y = centerY + distance * math.sin(angle);

      final margin = bubble.radius;
      if (x - margin < 0 ||
          x + margin > width ||
          y - margin < 0 ||
          y + margin > height) {
        angle += angleStep;
        distance += distanceStep * 0.1;
        continue;
      }

      bool hasCollision = false;
      for (final other in existing) {
        final dx = x - other.x;
        final dy = y - other.y;
        final dist = math.sqrt(dx * dx + dy * dy);
        if (dist < bubble.radius + other.radius + spacing) {
          hasCollision = true;
          break;
        }
      }

      if (!hasCollision) {
        bubble.x = x;
        bubble.y = y;
        return;
      }

      angle += angleStep;
      distance += distanceStep * 0.1;
    }

    // 자리를 찾지 못하면 중앙에 배치
    bubble.x = centerX;
    bubble.y = centerY;
  }
}
