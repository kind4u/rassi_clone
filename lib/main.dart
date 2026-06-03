import 'package:flutter/material.dart';
import 'package:rassi_clone/presentation/components/shared/slide_tab_view.dart';
import 'package:rassi_clone/presentation/pages/drawer/drawer_tab_manager.dart';
import 'package:rassi_clone/presentation/pages/home/home_page.dart';
import 'package:rassi_clone/presentation/pages/pocket/pocket_page.dart';
import 'package:rassi_clone/presentation/pages/notification/notification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '라씨 클론',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isToggled = false;

  late final ValueNotifier<int> _homeTabNotifier;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _homeTabNotifier = ValueNotifier<int>(0);
    _pages = [
      HomePage(tabNotifier: _homeTabNotifier),
      const PocketPage(),
      const NotificationPage(),
    ];
  }

  @override
  void dispose() {
    _homeTabNotifier.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToHomeTab(BuildContext context, int tabIndex) {
    Navigator.pop(context);
    setState(() => _selectedIndex = 0);
    _homeTabNotifier.value = tabIndex;
  }

  void _navigateToPage(BuildContext context, int pageIndex) {
    Navigator.pop(context);
    setState(() => _selectedIndex = pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _AppDrawer(
        onNavigateToHomeTab: (tabIndex) =>
            _navigateToHomeTab(context, tabIndex),
        onNavigateToPage: (pageIndex) => _navigateToPage(context, pageIndex),
      ),
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        child: Builder(
          builder: (context) => Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.grey),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _TabItem(
                      icon: Icons.smart_toy,
                      label: '매매비서',
                      isSelected: _selectedIndex == 0,
                      onTap: () => _onItemTapped(0),
                    ),
                    _TabItem(
                      icon: Icons.account_balance_wallet,
                      label: '나의 포켓',
                      isSelected: _selectedIndex == 1,
                      onTap: () => _onItemTapped(1),
                    ),
                    _TabItem(
                      icon: Icons.notifications,
                      label: '알림',
                      isSelected: _selectedIndex == 2,
                      onTap: () => _onItemTapped(2),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Icon(
                    _isToggled
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    key: ValueKey(_isToggled),
                    color: _isToggled ? const Color(0xFF6665FD) : Colors.grey,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isToggled = !_isToggled;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? const Color(0xFF6665FD) : Colors.grey;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final void Function(int tabIndex) onNavigateToHomeTab;
  final void Function(int pageIndex) onNavigateToPage;

  const _AppDrawer({
    required this.onNavigateToHomeTab,
    required this.onNavigateToPage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 8, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '전체메뉴',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: SlideTabView(
                tabs: DrawerTabManager.tabItems(
                  onNavigateToHomeTab: onNavigateToHomeTab,
                  onNavigateToPage: onNavigateToPage,
                ),
                style: const SlideTabStyle(
                  primaryColor: Color(0xFF6665FD),
                  horizontalPadding: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
