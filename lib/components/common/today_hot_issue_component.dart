import 'package:flutter/material.dart';
import 'package:rassi_clone/models/hot_issue_model.dart';

import 'en_hot_issue_component.dart';
import 'kr_hot_issue_component.dart';

/// 오늘의 핫이슈 컴포넌트
///
/// [country]와 [timeGroup]을 받아 데이터를 조회한 뒤,
/// KR이면 [KrHotIssueComponent], 그 외에는 [EnHotIssueComponent]에 위임합니다.
/// KR인 경우 [KrHotIssueComponent] 내부 타임라인 슬라이더에서 받은 timeGroup으로
/// 데이터를 다시 조회해 전달합니다.
class TodayHotIssueComponent extends StatefulWidget {
  final String country;
  final int timeGroup;

  const TodayHotIssueComponent({
    super.key,
    this.country = 'KR',
    this.timeGroup = 0,
  });

  @override
  State<TodayHotIssueComponent> createState() =>
      _TodayHotIssueComponentState();
}

class _TodayHotIssueComponentState extends State<TodayHotIssueComponent> {
  // KR 슬라이더 초기값: 15:30 (timeGroup 7)
  int _currentTimeGroup = 7;

  @override
  Widget build(BuildContext context) {
    final timeGroup =
        widget.country == 'KR' ? _currentTimeGroup : widget.timeGroup;
    final items = HotIssueData.getItems(
      country: widget.country,
      timeGroup: timeGroup,
    );

    if (widget.country == 'KR') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: KrHotIssueComponent(
          items: items,
          timeGroup: _currentTimeGroup,
          onTimeGroupChanged: (newTimeGroup) {
            setState(() {
              _currentTimeGroup = newTimeGroup;
            });
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: EnHotIssueComponent(
        key: ValueKey('en_${widget.timeGroup}'),
        items: items,
      ),
    );
  }
}
