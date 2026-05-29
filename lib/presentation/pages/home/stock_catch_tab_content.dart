import 'package:flutter/material.dart';
import 'package:rassi_clone/presentation/components/stock_catch/achive_stock_catch_component.dart';
import 'package:rassi_clone/presentation/components/stock_catch/etf_stock_catch_component.dart';
import 'package:rassi_clone/presentation/components/stock_catch/filter_stock_catch_component.dart';
import 'package:rassi_clone/presentation/components/stock_catch/population_etf_component.dart';
import 'package:rassi_clone/presentation/components/shared/title_bar.dart';
import 'package:rassi_clone/presentation/components/stock_catch/whale_stock_catch_component.dart';

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
            _divider(),

            _achiveStockCatch(),
            _divider(),

            _etfStockCatch(),
            _divider(),

            _filterStockCatch(),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Column(
      children: [
        const SizedBox(height: 24),
        Container(height: 12, color: Colors.grey.shade100),
        const SizedBox(height: 24),
      ],
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
