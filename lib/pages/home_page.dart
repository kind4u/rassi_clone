import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../components/common/rassi_search_bar.dart';
import '../components/common/rassi_tab_bar.dart';
import '../components/tabs/home_tab_content.dart';
import '../components/tabs/ai_signal_tab_content.dart';
import '../components/tabs/stock_catch_tab_content.dart';
import '../components/tabs/market_view_tab_content.dart';

/// 리팩토링된 홈페이지
/// iOS의 UIViewController - UI Logic 담당
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // 스크롤 관련 (iOS의 UIScrollViewDelegate와 유사)
  late final ScrollController _scrollController;
  bool _isHeaderCollapsed = false;
  
  // 탭 선택 상태
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isCollapsed = _scrollController.offset >= AppConstants.expandedHeight;
    
    if (isCollapsed != _isHeaderCollapsed) {
      setState(() => _isHeaderCollapsed = isCollapsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(),
          _buildStickyHeader(),
          _buildContentList(),
        ],
      ),
    );
  }

  /// 앱바 - iOS의 NavigationBar와 유사
  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: AppConstants.expandedHeight,
      floating: false,
      pinned: false,
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFFF8F9FA)],
            ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppConstants.appIcon,
                  style: TextStyle(fontSize: 48),
                ),
                SizedBox(height: 8),
                Text(
                  AppConstants.appTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  AppConstants.appSubtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 고정 헤더 - 검색바와 탭바를 포함
  Widget _buildStickyHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _StickyHeaderDelegate(
        minHeight: AppConstants.stickyHeaderHeight,
        maxHeight: AppConstants.stickyHeaderHeight,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            children: [
              RassiSearchBar(
                isCollapsed: _isHeaderCollapsed,
                onTap: () {
                  // 검색 페이지로 이동
                },
              ),
              RassiTabBar(
                tabs: AppConstants.homeTabs,
                selectedIndex: _selectedTabIndex,
                onTabSelected: (index) {
                  setState(() => _selectedTabIndex = index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 콘텐츠 리스트 - 선택된 탭에 따라 다른 콘텐츠 표시
  Widget _buildContentList() {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child: _getContentByTab(),
      ),
    );
  }

  /// 탭 인덱스에 따른 콘텐츠 위젯 반환
  Widget _getContentByTab() {
    switch (_selectedTabIndex) {
      case 0:
        return const HomeTabContent();
      case 1:
        return const AISignalTabContent();
      case 2:
        return const StockCatchTabContent();
      case 3:
        return const MarketViewTabContent();
      default:
        return const SizedBox.shrink();
    }
  }
}

/// SliverPersistentHeader용 Delegate
/// iOS의 UICollectionViewFlowLayout과 유사한 역할
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
           minHeight != oldDelegate.minExtent;
  }
}
