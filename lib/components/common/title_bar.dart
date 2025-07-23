import 'package:flutter/material.dart';

/// 재사용 가능한 타이틀 바 컴포넌트
/// 좌측에 bold 글씨체의 title, 우측에 선택 가능한 detail text
class TitleBar extends StatelessWidget {
  final String title;
  final String? detailText;
  final VoidCallback? onDetailTap;
  final Color? titleColor;
  final Color? detailColor;

  const TitleBar({
    super.key,
    required this.title,
    this.detailText,
    this.onDetailTap,
    this.titleColor,
    this.detailColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: titleColor ?? Colors.black,
          ),
        ),
        if (detailText != null)
          GestureDetector(
            onTap: onDetailTap,
            child: Text(
              detailText!,
              style: TextStyle(
                fontSize: 14,
                color: detailColor ?? Colors.grey[400], // lightGray로 변경
              ),
            ),
          ),
      ],
    );
  }
}