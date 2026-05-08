import 'package:rassi_clone/domain/entities/market_stock_item.dart';
import 'package:rassi_clone/domain/entities/today_issue.dart';
import 'package:rassi_clone/domain/repositories/market_repository_protocol.dart';

/// MarketRepositoryProtocol의 구체 구현체
/// mainTab: 0=상승종목, 1=하위종목 / subTab: 0=코스피, 1=코스닥
class MarketRepository implements MarketRepositoryProtocol {
  // 상승종목 - 코스피
  static const List<MarketStockItem> _upKospi = [
    MarketStockItem(stockName: '주성코퍼레이션', stockCode: '109070', rate: '+29.97'),
    MarketStockItem(stockName: '티엠씨', stockCode: '217590', rate: '+29.96'),
    MarketStockItem(stockName: '한솔테크닉스', stockCode: '004710', rate: '+29.94'),
    MarketStockItem(stockName: '남선알미늄', stockCode: '008350', rate: '+29.93'),
    MarketStockItem(stockName: '광전자', stockCode: '017900', rate: '+29.91'),
  ];

  // 상승종목 - 코스닥
  static const List<MarketStockItem> _upKosdaq = [
    MarketStockItem(stockName: '우리넷', stockCode: '115440', rate: '+30.00'),
    MarketStockItem(stockName: '아이씨에이치', stockCode: '368600', rate: '+30.00'),
    MarketStockItem(stockName: '서울전자통신', stockCode: '027040', rate: '+29.98'),
    MarketStockItem(stockName: '알엔투테크놀로지', stockCode: '148250', rate: '+29.97'),
    MarketStockItem(stockName: '웨이브일렉트로', stockCode: '095270', rate: '+29.96'),
  ];

  // 하위종목 - 코스피
  static const List<MarketStockItem> _downKospi = [
    MarketStockItem(stockName: '태영건설우', stockCode: '009415', rate: '-13.78'),
    MarketStockItem(stockName: '삼익THK', stockCode: '004380', rate: '-9.21'),
    MarketStockItem(stockName: '에이프로젠', stockCode: '007460', rate: '-7.57'),
    MarketStockItem(stockName: '대한해운', stockCode: '005880', rate: '-7.44'),
    MarketStockItem(stockName: '미원화학', stockCode: '134380', rate: '-7.25'),
  ];

  // 하위종목 - 코스닥
  static const List<MarketStockItem> _downKosdaq = [
    MarketStockItem(stockName: '썸에이지', stockCode: '208640', rate: '-18.30'),
    MarketStockItem(stockName: 'ISC', stockCode: '095340', rate: '-15.92'),
    MarketStockItem(stockName: '코이즈', stockCode: '121850', rate: '-15.03'),
    MarketStockItem(stockName: '모아라이프플러스', stockCode: '142760', rate: '-9.72'),
    MarketStockItem(stockName: '한울반도체', stockCode: '320000', rate: '-9.18'),
  ];

  static const List<TodayIssue> _todayIssues = [
    TodayIssue(
      category: "전선",
      title: "AI • 전기차發 구리 슈퍼사이클 •••ETF•선물시장도 '과열 경고등'",
      content:
          "인공지능 (AI) 데이터센터와 전기차, 재생에너지 확산이 '구리 슈퍼사이클'을 이끌고 있다. 일각에서는 이번 상승을 단순한 호황으로 볼 것이 아니라, 금융상품으로 쏠린 자금과 산업 전반의 비용 부담 그리고 장기 투자 위축이 맞물려 경기 불안을 키울 수 있다는 지적이다.",
      signalType: IssueSignalType.up,
      tags: ["LS마린솔루", "대원전선", "가온전선"],
    ),
    TodayIssue(
      category: "로봇",
      title: "'로봇도 현대차'정의선의 승부수, 연 3만대 찍는 공장 띄웠다",
      content:
          "현대자동차그룹이 차세대 승부수로 '로봇 카드'를 빼들었다. 11일 자동차업계에 따르면 현대차 그룹은 2028년 가동을 목표로 미국 조지아나 엘라배마주 인근에 휴머노이드 로봇 전용 공장 설립을 추진 중이다. 연간 생산 규모는 3만대 안팎이다.",
      signalType: IssueSignalType.up,
      tags: ["클로봇", "TPC", "서진오토모티"],
    ),
    TodayIssue(
      category: "보험",
      title: "삼성화재, 장 막판 28% 급등... 주문 실수인가 리밸런싱인가",
      content:
          "삼성화재(000810) 주가가 장 마감 직전 돌연 28% 급등했다. 삼성화재 주가는 최근 1년여 간 줄곧 55만원 이하를 유지했지만 이날 오후3시 20분에 갑작스레 상한가 가까이 치솟으며 63만원에 장을 마쳤다. 정규장 이후 이어지는 넥스트레이드(NXT) 애프터마켓에서는 전 거래일 종가 대비 7% 가량 높은 52만 원 대에 손바뀜 되는 중이다.",
      signalType: IssueSignalType.neutral,
      tags: ["코리안리", "한화생명", "한화손해보험"],
    ),
    TodayIssue(
      category: "반도체",
      title: "브로드컴, 또 어닝 서프라이즈... \"AI 칩 매출, 두 배 늘 것\"",
      content:
          "브로드컴이 11일(현지시간) 시장 전망을 웃도는 4분기 실적을 발표하고, 인공지능(AI) 수요 확대를 반영한 강한 분기 전망을 제시했다. 회사 측은 현재 분기 AI칩 매출이 전년 대비 두 배 수준으로 늘어날 것이라고 밝혔다.",
      signalType: IssueSignalType.down,
      tags: ["와이제이링크", "넥스트칩", "엠디바이스"],
    ),
    TodayIssue(
      category: "제약 바이오",
      title: "할로자임, MSD 이어 알테오젠 '정조준' 美서 핵심 특허 무효화 공세",
      content:
          "글로벌 피하주사(SC) 제형 변경 기술 시장을 둘러싼 특허 전쟁이 난타전 양상으로 치닫고 있다. 미국 머크(이하 MSD)가 SC 제형 변경 분야의 선두 주자인 할로자임 테라퓨틱스(Halozyme Therapeutics, 이하 할로자임)의 특허 장벽을 허물기 위해 전방위 공세를 펼침",
      signalType: IssueSignalType.down,
      tags: ["소룩스", "에임드바이오", "삼성에피스홀"],
    ),
  ];

  @override
  List<MarketStockItem> getStocks({
    required int mainTab,
    required int subTab,
  }) {
    return switch ((mainTab, subTab)) {
      (0, 0) => _upKospi,
      (0, 1) => _upKosdaq,
      (1, 0) => _downKospi,
      (1, _) => _downKosdaq,
      _ => [],
    };
  }

  @override
  List<TodayIssue> getTodayIssues() => _todayIssues;
}
