/// 핫이슈 도메인 엔티티 - label과 value(중요도)
class HotIssueItem {
  final String label;
  final int value; // 양수: 크기 변동, 0: 회색 최소, 음수: 파란색 최소

  const HotIssueItem({required this.label, required this.value});
}
