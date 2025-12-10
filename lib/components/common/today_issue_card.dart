import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

/// 오늘의 이슈 카드 컴포넌트
class TodayIssueCard extends StatelessWidget {
  final int number;

  const TodayIssueCard({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 2 / 3;
    final cardHeight = cardWidth * 2 / 3;

    return Card(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Center(
          child: Text(
            'testText$number',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
