import 'package:flutter/material.dart';
import 'today_issue_card.dart';

class TodayIssueComponent extends StatelessWidget {
  static const int cardCount = 10;

  const TodayIssueComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 2 / 3 + 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: cardCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index < cardCount - 1 ? 12 : 0),
            child: TodayIssueCard(number: index + 1),
          );
        },
      ),
    );
  }
}
