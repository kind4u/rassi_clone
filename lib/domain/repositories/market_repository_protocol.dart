import 'package:rassi_clone/domain/entities/market_stock_item.dart';

/// 오늘의 시장 종목 데이터 접근을 정의하는 프로토콜
/// mainTab: 0=상승종목, 1=하위종목
/// subTab: 0=코스피, 1=코스닥
abstract class MarketRepositoryProtocol {
  List<MarketStockItem> getStocks({
    required int mainTab,
    required int subTab,
  });
}
