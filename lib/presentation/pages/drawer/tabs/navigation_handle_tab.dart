import 'package:flutter/material.dart';

class NavigationHandleTab extends StatelessWidget {
  final void Function(int tabIndex) onNavigateToHomeTab;
  final void Function(int pageIndex) onNavigateToPage;

  const NavigationHandleTab({
    super.key,
    required this.onNavigateToHomeTab,
    required this.onNavigateToPage,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: [
        _SectionLabel('매매비서'),
        _ShortcutItem(
          icon: Icons.bar_chart_rounded,
          label: '마켓뷰',
          onTap: () => onNavigateToHomeTab(0),
        ),
        _ShortcutItem(
          icon: Icons.smart_toy_outlined,
          label: 'AI매매신호',
          onTap: () => onNavigateToHomeTab(1),
        ),
        _ShortcutItem(
          icon: Icons.radar,
          label: '종목캐치',
          onTap: () => onNavigateToHomeTab(2),
        ),
        const SizedBox(height: 8),
        const Divider(height: 1),
        const SizedBox(height: 8),
        _SectionLabel('메뉴'),
        _ShortcutItem(
          icon: Icons.account_balance_wallet_outlined,
          label: '나의 포켓',
          onTap: () => onNavigateToPage(1),
        ),
        _ShortcutItem(
          icon: Icons.notifications_outlined,
          label: '알림',
          onTap: () => onNavigateToPage(2),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 0, 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ShortcutItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ShortcutItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6665FD), size: 22),
      title: Text(
        label,
        style: const TextStyle(fontSize: 15, color: Colors.black87),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      onTap: onTap,
    );
  }
}
