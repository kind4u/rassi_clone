class FilterStock {
  final String stockName;
  final String stockCode;
  final String descriptionName;
  final String descriptionDetail;

  const FilterStock({
    required this.stockName,
    required this.stockCode,
    required this.descriptionName,
    required this.descriptionDetail,
  });
}

// 샘플 데이터: 최근 3일 매수 종목
final List<FilterStock> recentPurchaseStocks = [
  FilterStock(
    stockName: '롯데에너지머티리',
    stockCode: '020150',
    descriptionName: '수익률',
    descriptionDetail: '+18.42%',
  ),
  FilterStock(
    stockName: '신성이엔지',
    stockCode: '011930',
    descriptionName: '수익률',
    descriptionDetail: '+14.59%',
  ),
  FilterStock(
    stockName: '얼라인드',
    stockCode: '238120',
    descriptionName: '수익률',
    descriptionDetail: '+14.25%',
  ),
  FilterStock(
    stockName: '삼일제약',
    stockCode: '000520',
    descriptionName: '수익률',
    descriptionDetail: '+13.67%',
  ),
  FilterStock(
    stockName: '알파칩스',
    stockCode: '117670',
    descriptionName: '수익률',
    descriptionDetail: '+12.37%',
  ),
  FilterStock(
    stockName: '제이티',
    stockCode: '089790',
    descriptionName: '수익률',
    descriptionDetail: '+10.87%',
  ),
  FilterStock(
    stockName: '넥센타이어',
    stockCode: '002350',
    descriptionName: '수익률',
    descriptionDetail: '+10.11%',
  ),
];

// 샘플 데이터: 평균보유기간이 짧은 종목
final List<FilterStock> shortHoldingStocks = [
  FilterStock(
    stockName: '금양',
    stockCode: '001570',
    descriptionName: '평균 보유기간',
    descriptionDetail: '5일',
  ),
  FilterStock(
    stockName: '형지I&C',
    stockCode: '011080',
    descriptionName: '평균 보유기간',
    descriptionDetail: '2일',
  ),
  FilterStock(
    stockName: '위세아이텍',
    stockCode: '065370',
    descriptionName: '평균 보유기간',
    descriptionDetail: '3일',
  ),
  FilterStock(
    stockName: '엑시온그룹',
    stockCode: '069920',
    descriptionName: '평균 보유기간',
    descriptionDetail: '3일',
  ),
  FilterStock(
    stockName: '상지건설',
    stockCode: '042940',
    descriptionName: '평균 보유기간',
    descriptionDetail: '4일',
  ),
  FilterStock(
    stockName: '자이글',
    stockCode: '234920',
    descriptionName: '평균 보유기간',
    descriptionDetail: '3일',
  ),
];

// 샘플 데이터: 주간 토픽 중 최근 매수 종목
final List<FilterStock> weeklyTopicStocks = [
  FilterStock(
    stockName: '현대건설',
    stockCode: '000720',
    descriptionName: '매수가',
    descriptionDetail: '113,300원',
  ),
  FilterStock(
    stockName: '하이브',
    stockCode: '352820',
    descriptionName: '매수가',
    descriptionDetail: '363,000원',
  ),
  FilterStock(
    stockName: '와이지엔터테인먼',
    stockCode: '122870',
    descriptionName: '매수가',
    descriptionDetail: '71,700원',
  ),
  FilterStock(
    stockName: '코스모신소재',
    stockCode: '005070',
    descriptionName: '매수가',
    descriptionDetail: '52,700원',
  ),
  FilterStock(
    stockName: '솔브레인홀딩스',
    stockCode: '036830',
    descriptionName: '매수가',
    descriptionDetail: '51,500원',
  ),
  FilterStock(
    stockName: '현대엘리베이터',
    stockCode: '017800',
    descriptionName: '매수가',
    descriptionDetail: '91,000원',
  ),
];
