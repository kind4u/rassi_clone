/// 오늘의 이슈 신호 타입
enum IssueSignalType { up, neutral, down }

/// 오늘의 이슈 도메인 엔티티
class TodayIssue {
  final String category;
  final String title;
  final String content;
  final IssueSignalType signalType;
  final List<String> tags;

  const TodayIssue({
    required this.category,
    required this.title,
    required this.content,
    required this.signalType,
    required this.tags,
  });
}
