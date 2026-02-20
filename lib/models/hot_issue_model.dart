/// 핫이슈 데이터 모델 - label과 value(중요도)
class HotIssueItem {
  final String label;
  final int value; // 양수: 크기 변동, 0: 회색 최소, 음수: 파란색 최소

  const HotIssueItem({required this.label, required this.value});

  factory HotIssueItem.fromJson(Map<String, dynamic> json) {
    return HotIssueItem(
      label: json['label'] as String,
      value: json['value'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }
}

/// 핫이슈 데이터 저장소
class HotIssueData {
  // country별, timeGroup별 데이터
  static const Map<String, Map<int, List<Map<String, dynamic>>>> _data = {
    'KR': {
      0: [
        {'label': '석유화학', 'value': 95},
        {'label': '은행', 'value': 85},
        {'label': '증권', 'value': 70},
        {'label': '보험', 'value': 65},
        {'label': '지주회사', 'value': 68},
        {'label': '2차전지', 'value': 65},
        {'label': '냉각\n솔루션', 'value': 68},
        {'label': '초전도체', 'value': 62},
        {'label': 'HBM', 'value': 58},
        {'label': '자동차', 'value': 48},
        {'label': '우크라\n재건', 'value': 52},
        {'label': '제약\n바이오', 'value': 48},
        {'label': '음식료', 'value': 50},
        {'label': '반도체', 'value': 0},
        {'label': '방산', 'value': -10},
      ],
    },
    'EN': {
      0: [
        {'label': 'AI', 'value': 98},
        {'label': 'Tech', 'value': 90},
        {'label': 'EV', 'value': 75},
        {'label': 'Semi\nconductor', 'value': 72},
        {'label': 'Cloud', 'value': 68},
        {'label': 'Fintech', 'value': 65},
        {'label': 'Biotech', 'value': 60},
        {'label': 'Energy', 'value': 55},
        {'label': 'Defense', 'value': 52},
        {'label': 'Retail', 'value': 48},
        {'label': 'Real\nEstate', 'value': 45},
        {'label': 'Bank', 'value': 0},
        {'label': 'Telecom', 'value': -5},
      ],
    },
  };

  /// country와 timeGroup으로 핫이슈 데이터를 가져옴
  static List<HotIssueItem> getItems({
    required String country,
    required int timeGroup,
  }) {
    final countryData = _data[country];
    if (countryData == null) return [];

    final groupData = countryData[timeGroup];
    if (groupData == null) return [];

    return groupData.map((json) => HotIssueItem.fromJson(json)).toList();
  }

  /// 사용 가능한 country 목록
  static List<String> get availableCountries => _data.keys.toList();

  /// 특정 country의 사용 가능한 timeGroup 목록
  static List<int> getAvailableTimeGroups(String country) {
    return _data[country]?.keys.toList() ?? [];
  }
}
