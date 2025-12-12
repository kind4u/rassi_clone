import 'package:flutter/material.dart';
import '../../models/stock_models.dart';

class TodayIssueCard extends StatelessWidget {
  final TodayIssue issue;
  static const double cardHeight = 250.0;

  const TodayIssueCard({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 2 / 3;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 3,
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 신호 타입 표시
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      issue.category,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    _buildSignalIndicator(issue.signalType),
                  ],
                ),

                SizedBox(height: 12),

                // 타이틀
                Text(
                  issue.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),

                // 컨텐츠
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        issue.content,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 8),
                      // 태그
                      Wrap(
                        spacing: 6,
                        children: issue.tags
                            .map(
                              (tag) => Text(
                                '#$tag',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6665FD),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignalIndicator(IssueSignalType signalType) {
    Color color;
    String text;
    String symbolIcon;

    switch (signalType) {
      case IssueSignalType.up:
        color = Colors.red;
        text = '상승중';
        symbolIcon = '▲';
        break;
      case IssueSignalType.neutral:
        color = Colors.grey.withAlpha(128);
        text = '0.00%';
        symbolIcon = '-';
        break;
      case IssueSignalType.down:
        color = Colors.blue;
        text = '하락중';
        symbolIcon = '▼';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // icon
          Text(
            symbolIcon,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 4),

          // text
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
