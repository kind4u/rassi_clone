/// 오늘의 시장 종목 도메인 엔티티
class MarketStockItem {
  final String stockName;
  final String stockCode;
  final String rate;

  const MarketStockItem({
    required this.stockName,
    required this.stockCode,
    required this.rate,
  });
}
