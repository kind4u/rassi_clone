import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/title_bar.dart';
import 'package:rassi_clone/components/common/filter_stock_card.dart';

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
            height: FilterStockCard.cardHeight + 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: index < 5 - 1 ? 12 : 0),
                  child: FilterStockCard(
                    stockName: '금양',
                    stockCode: '001570',
                    holdingDays: 3,
                  ),
                );
              },
            ),
          ),
          TitleBar(title: "평균보유기간이 짧은 종목", titleSize: 16, detailText: "더보기"),
          Text(
            '단기적인 투자를 지향한다면\n평균 보유 기간이 짧은 종목에 관심을 가져보세요.',
            style: TextStyle(fontSize: 15),
          ),

          TitleBar(title: "주간 토픽 중 최근 매수 종목", titleSize: 16, detailText: "더보기"),
          Text(
            '최근 5주간 올라온\n라씨 매매비서의 주간 토픽 종목 중 최근 매수 종목입니다.',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
