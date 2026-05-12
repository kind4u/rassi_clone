import 'package:flutter/material.dart';

class MarketCategoryCompareComponent extends StatelessWidget {
  const MarketCategoryCompareComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: SizedBox(
        height: 100,
        child: _CategoryRow(
          items: const [
            _CategoryItem(category: '전선', content: '4종목'),
            _CategoryItem(category: '농기계', content: '2종목'),
            _CategoryItem(category: '응급재', content: '3종목'),
          ],
        ),
      ),
    );
    ;
  }
}

class _CategoryItem {
  final String category;
  final String content;

  const _CategoryItem({required this.category, required this.content});
}

class _CategoryRow extends StatelessWidget {
  final List<_CategoryItem> items;

  const _CategoryRow({required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 16.0;
        const horizontalPadding = 16.0;
        final availableWidth = constraints.maxWidth - horizontalPadding * 2;
        final itemWidth =
            (availableWidth - spacing * (items.length - 1)) / items.length;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index > 0) const SizedBox(width: spacing),
                  Container(
                    width: itemWidth,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.category,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          item.content,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
