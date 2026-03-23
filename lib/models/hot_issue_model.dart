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
    return {'label': label, 'value': value};
  }
}

/// 핫이슈 데이터 저장소
class HotIssueData {
  // country별, timeGroup별 데이터
  static const Map<String, Map<int, List<Map<String, dynamic>>>> _data = {
    'KR': {
      // 09:00 장 초반 - 전날 외인 매수 영향, 반도체·금융 강세
      0: [
        {'label': '반도체', 'value': 90},
        {'label': '은행', 'value': 80},
        {'label': '증권', 'value': 72},
        {'label': '2차전지', 'value': 68},
        {'label': 'HBM', 'value': 65},
        {'label': '지주회사', 'value': 60},
        {'label': '보험', 'value': 58},
        {'label': '자동차', 'value': 55},
        {'label': '방산', 'value': 52},
        {'label': '제약\n바이오', 'value': 48},
        {'label': '음식료', 'value': 45},
        {'label': '석유화학', 'value': 0},
        {'label': '냉각\n솔루션', 'value': -8},
      ],
      1: [
        {'label': '석유화학', 'value': 88},
        {'label': '반도체', 'value': 82},
        {'label': '은행', 'value': 75},
        {'label': '2차전지', 'value': 70},
        {'label': '냉각\n솔루션', 'value': 68},
        {'label': 'HBM', 'value': 62},
        {'label': '지주회사', 'value': 60},
        {'label': '증권', 'value': 55},
        {'label': '자동차', 'value': 52},
        {'label': '우크라\n재건', 'value': 48},
        {'label': '방산', 'value': 50},
        {'label': '보험', 'value': 0},
        {'label': '음식료', 'value': -5},
      ],
      2: [
        {'label': '석유화학', 'value': 92},
        {'label': '우크라\n재건', 'value': 85},
        {'label': '초전도체', 'value': 78},
        {'label': '반도체', 'value': 72},
        {'label': '냉각\n솔루션', 'value': 70},
        {'label': '은행', 'value': 65},
        {'label': '2차전지', 'value': 62},
        {'label': 'HBM', 'value': 58},
        {'label': '방산', 'value': 55},
        {'label': '지주회사', 'value': 50},
        {'label': '자동차', 'value': 48},
        {'label': '음식료', 'value': 42},
        {'label': '증권', 'value': 0},
        {'label': '보험', 'value': -6},
      ],
      3: [
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
      4: [
        {'label': '제약\n바이오', 'value': 93},
        {'label': '석유화학', 'value': 80},
        {'label': '냉각\n솔루션', 'value': 75},
        {'label': '초전도체', 'value': 70},
        {'label': '우크라\n재건', 'value': 65},
        {'label': 'HBM', 'value': 60},
        {'label': '음식료', 'value': 58},
        {'label': '방산', 'value': 55},
        {'label': '지주회사', 'value': 50},
        {'label': '자동차', 'value': 48},
        {'label': '2차전지', 'value': 42},
        {'label': '반도체', 'value': 38},
        {'label': '은행', 'value': 0},
        {'label': '증권', 'value': -12},
      ],
      5: [
        {'label': '방산', 'value': 96},
        {'label': '우크라\n재건', 'value': 88},
        {'label': '제약\n바이오', 'value': 78},
        {'label': '석유화학', 'value': 72},
        {'label': '냉각\n솔루션', 'value': 65},
        {'label': '초전도체', 'value': 62},
        {'label': 'HBM', 'value': 58},
        {'label': '음식료', 'value': 55},
        {'label': '지주회사', 'value': 50},
        {'label': '자동차', 'value': 45},
        {'label': '보험', 'value': 40},
        {'label': '2차전지', 'value': 0},
        {'label': '반도체', 'value': -8},
        {'label': '은행', 'value': -15},
      ],
      6: [
        {'label': '반도체', 'value': 94},
        {'label': '방산', 'value': 85},
        {'label': '2차전지', 'value': 80},
        {'label': '우크라\n재건', 'value': 72},
        {'label': 'HBM', 'value': 68},
        {'label': '냉각\n솔루션', 'value': 65},
        {'label': '제약\n바이오', 'value': 60},
        {'label': '초전도체', 'value': 58},
        {'label': '자동차', 'value': 55},
        {'label': '지주회사', 'value': 50},
        {'label': '음식료', 'value': 45},
        {'label': '석유화학', 'value': 42},
        {'label': '보험', 'value': 0},
        {'label': '증권', 'value': -9},
      ],
      7: [
        {'label': '반도체', 'value': 98},
        {'label': '방산', 'value': 90},
        {'label': '2차전지', 'value': 82},
        {'label': 'HBM', 'value': 75},
        {'label': '우크라\n재건', 'value': 70},
        {'label': '냉각\n솔루션', 'value': 65},
        {'label': '자동차', 'value': 60},
        {'label': '초전도체', 'value': 58},
        {'label': '제약\n바이오', 'value': 55},
        {'label': '지주회사', 'value': 50},
        {'label': '음식료', 'value': 45},
        {'label': '석유화학', 'value': 40},
        {'label': '은행', 'value': 0},
        {'label': '보험', 'value': -7},
        {'label': '증권', 'value': -14},
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
