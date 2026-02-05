import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/title_bar.dart';
import 'package:rassi_clone/components/common/filter_stock_card.dart';
import 'package:rassi_clone/models/stock_catch_models.dart';

class FilterStockCatchComponent extends StatelessWidget {
  const FilterStockCatchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          TitleBar(title: "최근 3일 매수 종목", titleSize: 16, detailText: "더보기"),
          Text(
            '최근 3일 내 매수한 종목 중 상승률이\n높은 종목입니다.',
            style: TextStyle(fontSize: 15),
          ),

          SizedBox(
            height: FilterStockCard.cardSize,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentPurchaseStocks.length,
              itemBuilder: (context, index) {
                final stock = recentPurchaseStocks[index];
                return FilterStockCard(
                  stockName: stock.stockName,
                  stockCode: stock.stockCode,
                  descriptionName: stock.descriptionName,
                  descriptionDetail: stock.descriptionDetail,
                );
              },
            ),
          ),

          SizedBox(height: 16.0),

          TitleBar(title: "평균보유기간이 짧은 종목", titleSize: 16, detailText: "더보기"),
          Text(
            '단기적인 투자를 지향한다면\n평균 보유 기간이 짧은 종목에 관심을 가져보세요.',
            style: TextStyle(fontSize: 15),
          ),

          SizedBox(
            height: FilterStockCard.cardSize,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: shortHoldingStocks.length,
              itemBuilder: (context, index) {
                final stock = shortHoldingStocks[index];
                return FilterStockCard(
                  stockName: stock.stockName,
                  stockCode: stock.stockCode,
                  descriptionName: stock.descriptionName,
                  descriptionDetail: stock.descriptionDetail,
                );
              },
            ),
          ),

          SizedBox(height: 16.0),

          TitleBar(title: "주간 토픽 중 최근 매수 종목", titleSize: 16, detailText: "더보기"),
          Text(
            '최근 5주간 올라온\n라씨 매매비서의 주간 토픽 종목 중 최근 매수 종목입니다.',
            style: TextStyle(fontSize: 15),
          ),

          SizedBox(
            height: FilterStockCard.cardSize,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weeklyTopicStocks.length,
              itemBuilder: (context, index) {
                final stock = weeklyTopicStocks[index];
                return FilterStockCard(
                  stockName: stock.stockName,
                  stockCode: stock.stockCode,
                  descriptionName: stock.descriptionName,
                  descriptionDetail: stock.descriptionDetail,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "다양한 조건으로",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "다른 종목들도 찾아보세요",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999.0),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 24.0,
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_right_alt, color: Color(0xFF6665FD)),
                        Text(
                          "조건",
                          style: TextStyle(
                            color: Color(0xFF6665FD),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Text(
                          "모두 보기",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
