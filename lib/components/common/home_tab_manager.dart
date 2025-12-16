import 'package:flutter/material.dart';
import '../../pages/home/home_tab_content.dart';
import '../../pages/home/ai_signal_tab_content.dart';
import '../tabs/stock_catch_tab_content.dart';
import '../tabs/market_view_tab_content.dart';
import '../../models/tab_item.dart';

class HomeTabManager {
  static const TabBottomShape bottomShape =
      TabBottomShape.rounded; // TabBar 전체의 bottomShape

  static final List<TabItem> tabItems = [
    const TabItem(label: '홈', content: HomeTabContent()),
    const TabItem(label: 'AI매매신호', content: AISignalTabContent()),
    const TabItem(label: '종목캐치', content: StockCatchTabContent()),
    const TabItem(label: '마켓뷰', content: MarketViewTabContent()),
  ];

  static List<String> get tabNames =>
      tabItems.map((item) => item.label).toList();

  static Widget getTabContent(int index) {
    if (isValidTabIndex(index)) {
      return tabItems[index].getTabContent();
    }
    return const SizedBox.shrink();
  }

  static TabItem getTabItem(int index) {
    if (isValidTabIndex(index)) {
      return tabItems[index];
    }
    return const TabItem(label: '', content: SizedBox.shrink());
  }

  static bool isValidTabIndex(int index) {
    return index >= 0 && index < tabItems.length;
  }

  static int get defaultTabIndex => 0;

  static int get tabCount => tabItems.length;
}
