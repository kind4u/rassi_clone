import 'package:flutter/material.dart';

/// PageTabView에서 사용할 정사각형 컴포넌트
class SquareComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? backgroundColor;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final VoidCallback? onTap;

  const SquareComponent({
    super.key,
    required this.title,
    required this.subtitle,
    this.backgroundColor,
    this.badgeColor,
    this.badgeTextColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.0, // 정사각형 비율
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2), // 살짝 아래쪽 그림자
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 0), // 전방향 그림자
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 배지
              if (badgeColor != null)
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      title.isNotEmpty ? title[0] : '',
                      style: TextStyle(
                        color: badgeTextColor ?? Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 4),
              
              // 하단 텍스트 영역 (SwiftUI VStack의 두 번째 요소)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}