import 'package:flutter/material.dart';
import 'package:rassi_clone/presentation/components/shared/slide_tab_view.dart';
import 'tabs/today_tab.dart';
import 'tabs/my_pocket_tab.dart';
import 'tabs/my_signal_tab.dart';

class PocketPage extends StatefulWidget {
  const PocketPage({super.key});

  @override
  State<PocketPage> createState() => _PocketPageState();
}

class _PocketPageState extends State<PocketPage> {
  late final PageController _pageController;
  int _selectedTab = 0;
  bool _isProgrammaticScroll = false;

  static const _tabLabels = ['TODAY', '나의 포켓', '나만의 신호'];
  static const _tabStyle = SlideTabStyle(
    primaryColor: Colors.black,
    horizontalPadding: 60,
  );
  static const _tabPages = <Widget>[TodayTab(), MyPocketTab(), MySignalTab()];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    if (index == _selectedTab) return;
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
    setState(() => _selectedTab = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SlideTabBar(
              labels: _tabLabels,
              selectedIndex: _selectedTab,
              style: _tabStyle,
              onTabSelected: _onTabSelected,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _tabPages.length,
                itemBuilder: (context, index) => _tabPages[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
