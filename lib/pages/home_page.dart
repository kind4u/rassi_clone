import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../components/common/rassi_search_bar.dart';
import '../components/common/rassi_tab_bar.dart';
import '../components/common/home_tab_manager.dart';

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
  
  // 탭 관련 (iOS의 UITabBarController와 유사)
  late final TabController _tabController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _tabController = TabController(
      length: HomeTabManager.tabNames.length,
      initialIndex: HomeTabManager.defaultTabIndex,
      vsync: this,
    );
    _pageController = PageController(initialPage: HomeTabManager.defaultTabIndex);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isCollapsed = _scrollController.offset >= AppConstants.expandedHeight;
    
    if (isCollapsed != _isHeaderCollapsed) {
      setState(() => _isHeaderCollapsed = isCollapsed);
    }
  }

  // 탭 선택 시 PageView도 함께 이동 (iOS의 TabBar delegate와 유사)
  void _onTabSelected(int index) {
    if (HomeTabManager.isValidTabIndex(index)) {
      _tabController.animateTo(index);
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // PageView 스와이프 시 TabBar도 함께 이동
  void _onPageChanged(int index) {
    if (HomeTabManager.isValidTabIndex(index)) {
      _tabController.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildAppBar(),
            _buildStickyHeader(),
          ];
        },
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemCount: HomeTabManager.tabNames.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: HomeTabManager.getTabContent(index),
            );
          },
        ),
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
              ListenableBuilder(
                listenable: _tabController,
                builder: (context, child) {
                  return RassiTabBar(
                    tabs: HomeTabManager.tabNames,
                    selectedIndex: _tabController.index,
                    bottomShape: HomeTabManager.bottomShape,
                    onTabSelected: _onTabSelected,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
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
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
           minHeight != oldDelegate.minExtent;
  }
}
