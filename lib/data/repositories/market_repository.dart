import 'package:rassi_clone/domain/entities/market_stock_item.dart';
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
}
