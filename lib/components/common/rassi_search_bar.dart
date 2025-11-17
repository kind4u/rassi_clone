import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

/// 검색바 컴포넌트
/// iOS의 UISearchBar와 유사한 역할
class RassiSearchBar extends StatelessWidget {
  final bool isCollapsed;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const RassiSearchBar({
    super.key,
    required this.isCollapsed,
    this.controller,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: isCollapsed
          ? _buildCollapsedSearchBar()
          : _buildExpandedSearchBar(),
    );
  }

  Widget _buildExpandedSearchBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              decoration: const InputDecoration(
                hintText: 'AI매매신호와 종목정보를 검색하세요!',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),

          const Icon(Icons.search, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildCollapsedSearchBar() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Color(0xFF6665FD).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Center(
            child: Text(AppConstants.appIcon, style: TextStyle(fontSize: 20)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: _buildExpandedSearchBar()),
      ],
    );
  }
}
