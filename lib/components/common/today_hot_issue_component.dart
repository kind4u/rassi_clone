import 'package:flutter/material.dart';
import 'package:rassi_clone/models/hot_issue_model.dart';

import 'en_hot_issue_component.dart';
import 'kr_hot_issue_component.dart';

/// 오늘의 핫이슈 컴포넌트
///
/// [country]와 [timeGroup]을 받아 데이터를 조회한 뒤,
/// KR이면 [KrHotIssueComponent], 그 외에는 [EnHotIssueComponent]에 위임합니다.
class TodayHotIssueComponent extends StatelessWidget {
  final String country;
  final int timeGroup;

  const TodayHotIssueComponent({
    super.key,
    this.country = 'KR',
    this.timeGroup = 0,
  });

  @override
  Widget build(BuildContext context) {
    final items = HotIssueData.getItems(country: country, timeGroup: timeGroup);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: country == 'KR'
          ? KrHotIssueComponent(key: ValueKey('kr_$timeGroup'), items: items)
          : EnHotIssueComponent(key: ValueKey('en_$timeGroup'), items: items),
    );
  }
}
