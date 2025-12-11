import 'package:flutter/material.dart';
import '../../models/stock_models.dart';
import 'today_issue_card.dart';

class TodayIssueComponent extends StatelessWidget {
  final List<TodayIssue> issues;

  const TodayIssueComponent({super.key, required this.issues});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 상단 notice text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '12:11 목요일 KST 기준',
                style: TextStyle(color: Colors.grey),
              ),
              _buildIssueCountText(),
            ],
          ),
        ),

        // 가로 스크롤 카드 리스트
        SizedBox(
          height: TodayIssueCard.cardHeight + 20,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: issues.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < issues.length - 1 ? 12 : 0,
                ),
                child: TodayIssueCard(issue: issues[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  /// 이슈 개수를 표시하는 텍스트 위젯 (숫자만 bold)
  Widget _buildIssueCountText() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 14),
        children: [
          const TextSpan(text: '오늘 선정된 이슈 총 '),
          TextSpan(
            text: '${issues.length}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: '개'),
        ],
      ),
    );
  }
}
