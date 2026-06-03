import 'package:flutter/material.dart';
import 'package:rassi_clone/core/constants/app_constants.dart';
import 'package:rassi_clone/presentation/components/shared/rassi_search_bar.dart';
import 'package:rassi_clone/presentation/components/shared/slide_tab_view.dart';
import 'package:rassi_clone/presentation/components/shared/home_tab_manager.dart';

class HomePage extends StatefulWidget {
  final ValueNotifier<int>? tabNotifier;
  const HomePage({super.key, this.tabNotifier});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late final PageController _pageController;
  bool _isHeaderCollapsed = false;
  int _selectedTab = HomeTabManager.defaultTabIndex;
  bool _isProgrammaticScroll = false;

  static const _tabStyle = SlideTabStyle(
    primaryColor: Colors.black,
    horizontalPadding: 60,
  );

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _pageController = PageController(initialPage: HomeTabManager.defaultTabIndex);
    widget.tabNotifier?.addListener(_onTabNotifierChanged);
  }

  @override
  void dispose() {
    widget.tabNotifier?.removeListener(_onTabNotifierChanged);
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTabNotifierChanged() {
    _onTabSelected(widget.tabNotifier!.value);
  }

  void _onScroll() {
    final isCollapsed = _scrollController.offset >= AppConstants.expandedHeight;
    if (isCollapsed != _isHeaderCollapsed) {
      setState(() => _isHeaderCollapsed = isCollapsed);
    }
  }

  void _onTabSelected(int index) {
    if (!HomeTabManager.isValidTabIndex(index) || index == _selectedTab) return;
    setState(() => _selectedTab = index);
    _isProgrammaticScroll = true;
    _pageController
        .animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        )
        .then((_) {
          if (mounted) _isProgrammaticScroll = false;
        });
  }

  void _onPageChanged(int index) {
    if (_isProgrammaticScroll) return;
    if (HomeTabManager.isValidTabIndex(index)) {
      setState(() => _selectedTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [_buildAppBar(), _buildStickyHeader()];
        },
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemCount: HomeTabManager.tabNames.length,
          itemBuilder: (context, index) {
            return ListView(
              padding: const EdgeInsets.only(top: 16.0),
              children: [HomeTabManager.getTabContent(index)],
            );
          },
        ),
      ),
    );
  }

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppConstants.appIcon, style: TextStyle(fontSize: 30)),
                SizedBox(width: 8),
                Text(
                  AppConstants.appTitle,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6665FD),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                onTap: () {},
              ),
              SlideTabBar(
                labels: HomeTabManager.tabNames,
                selectedIndex: _selectedTab,
                style: _tabStyle,
                onTabSelected: _onTabSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) => true;
}
