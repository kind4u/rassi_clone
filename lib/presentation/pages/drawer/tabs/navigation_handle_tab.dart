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
        _SectionLabel(icon: Icons.smart_toy_rounded, label: '매매비서'),
        _ShortcutItem(label: '마켓뷰', onTap: () => onNavigateToHomeTab(0)),
        _ShortcutItem(label: 'AI매매신호', onTap: () => onNavigateToHomeTab(1)),
        _ShortcutItem(label: '종목캐치', onTap: () => onNavigateToHomeTab(2)),
        SizedBox(height: 8),
        _SectionLabel(icon: Icons.account_balance_wallet, label: '포켓'),
        _ShortcutItem(label: 'TODAY', onTap: () => onNavigateToPage(1)),
        _ShortcutItem(label: '나의 포켓', onTap: () => onNavigateToPage(1)),
        _ShortcutItem(label: '나만의 신호', onTap: () => onNavigateToPage(1)),
        SizedBox(height: 8),
        _SectionLabel(icon: Icons.notifications, label: '알림'),
        _ShortcutItem(label: '전체', onTap: () => onNavigateToPage(2)),
        _ShortcutItem(label: '나의종목', onTap: () => onNavigateToPage(2)),
        _ShortcutItem(label: '종목캐치', onTap: () => onNavigateToPage(2)),
        _ShortcutItem(label: '라씨소식', onTap: () => onNavigateToPage(2)),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Icon(icon, size: 28, color: Color(0xFF6665FD)),
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ShortcutItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ShortcutItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const SizedBox(),
          title: Text(label, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.only(left: 10, right: 20),
          onTap: onTap,
        ),
        Divider(
          color: Colors.grey.shade300,
          height: 1,
          indent: 50,
          endIndent: 20,
        ),
      ],
    );
  }
}
