import 'package:flutter/material.dart';
import 'package:rassi_clone/components/common/achive_stock_catch_component.dart';
import 'package:rassi_clone/components/common/etf_stock_catch_component.dart';
import 'package:rassi_clone/components/common/filter_stock_catch_component.dart';
import 'package:rassi_clone/components/common/population_etf_component.dart';
import 'package:rassi_clone/components/common/title_bar.dart';
import 'package:rassi_clone/components/common/whale_stock_catch_component.dart';

/// 종목캐치 탭
class StockCatchTabContent extends StatelessWidget {
  const StockCatchTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsetsGeometry.only(top: 16.0),
        child: Column(
          children: [
            _whaleStockCatch(),

            // padding + divider
            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            _achiveStockCatch(),

            // padding + divider
            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            _etfStockCatch(),

            // padding + divider
            const SizedBox(height: 24),
            Container(height: 12, color: Colors.grey.shade100),
            const SizedBox(height: 24),

            _filterStockCatch(),
          ],
        ),
      ),
    );
  }

  Widget _whaleStockCatch() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(
            title: "큰손들의 종목캐치",
            detailIcon: Icons.notifications_none_outlined,
            detailIconColor: Colors.black.withAlpha(80),
            detailIconSize: 22,
            onDetailTap: () {},
          ),

          WhaleStockCatchComponent(),
        ],
      ),
    );
  }

  Widget _achiveStockCatch() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(
            title: "성과 TOP 종목캐치",
            detailIcon: Icons.notifications_none_outlined,
            detailIconColor: Colors.black.withAlpha(80),
            detailIconSize: 22,
            onDetailTap: () {},
          ),

          AchiveStockCatchComponent(),
        ],
      ),
    );
  }

  Widget _etfStockCatch() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(title: "ETF 종목캐치", onDetailTap: () {}),

          EtfStockCatchComponent(),

          TitleBar(title: "인기 ETF", onDetailTap: () {}),

          PopulationEtfComponent(),
        ],
      ),
    );
  }

  Widget _filterStockCatch() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TitleBar(title: "조건 탐색 종목캐치", onDetailTap: () {}),

          FilterStockCatchComponent(),
        ],
      ),
    );
  }
}
