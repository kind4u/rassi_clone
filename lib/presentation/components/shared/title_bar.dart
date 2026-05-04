import 'package:flutter/material.dart';

/// 재사용 가능한 타이틀 바 컴포넌트
/// 좌측에 bold 글씨체의 title, 우측에 선택 가능한 detail text
class TitleBar extends StatelessWidget {
  final String title;
  final String? detailText;
  final double? titleSize;
  final VoidCallback? onDetailTap;
  final Color? titleColor;
  final Color? detailColor;
  final IconData? detailIcon;
  final Color? detailIconColor;
  final double? detailTextSize;
  final double? detailIconSize;

  const TitleBar({
    super.key,
    required this.title,
    this.detailText,
    this.onDetailTap,
    this.titleColor,
    this.detailColor,
    this.titleSize,
    this.detailIcon,
    this.detailIconColor,
    this.detailTextSize,
    this.detailIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleSize ?? 18,
            fontWeight: FontWeight.bold,
            color: titleColor ?? Colors.black,
          ),
        ),
        if (detailText != null || detailIcon != null)
          GestureDetector(
            onTap: onDetailTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (detailIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(
                      detailIcon,
                      size: detailIconSize ?? 16,
                      color: detailIconColor ?? Colors.grey[400],
                    ),
                  ),
                if (detailText != null)
                  Text(
                    detailText!,
                    style: TextStyle(
                      fontSize: detailTextSize ?? 14,
                      color: detailColor ?? Colors.grey[400],
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
