// 주식 정보를 담는 모델
class Stock {
  final String name;
  final String price;
  final String change;
  final bool isUp; // true면 상승(빨강), false면 하락(파랑)

  const Stock({
    required this.name,
    required this.price,
    required this.change,
    required this.isUp,
  });
}

// 뉴스 정보를 담는 모델
class NewsItem {
  final String title;
  final String time;

  const NewsItem({required this.title, required this.time});
}

// 시장 지수 정보를 담는 모델
class MarketIndex {
  final String name;
  final String value;
  final String change;
  final bool isUp;

  const MarketIndex({
    required this.name,
    required this.value,
    required this.change,
    required this.isUp,
  });
}

// AI 신호 정보를 담는 모델
class AISignal {
  final String stockName;
  final String signal; // 매수, 매도, 보유
  final String description;
  final SignalType type;

  const AISignal({
    required this.stockName,
    required this.signal,
    required this.description,
    required this.type,
  });
}

enum SignalType { buy, sell, hold }

// 오늘의 이슈 신호 타입
enum IssueSignalType { up, neutral, down }

// 오늘의 이슈 정보를 담는 모델
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
