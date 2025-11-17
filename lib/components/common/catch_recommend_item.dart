import 'package:flutter/material.dart';

class CatchRecommendItem extends StatelessWidget {
  final IconData icon;
  final String description;
  final String stock;
  final String stockNumber;

  const CatchRecommendItem({
    super.key,
    required this.icon,
    required this.description,
    required this.stock,
    required this.stockNumber,
  });

  List<TextSpan> _buildTextSpans(String text) {
    final List<TextSpan> spans = [];
    final RegExp pattern = RegExp(r'(매수|매도)');
    final matches = pattern.allMatches(text);

    int lastIndex = 0;

    for (final match in matches) {
      // 키워드 이전의 일반 텍스트 추가
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: TextStyle(fontSize: 14, height: 1.0, color: Colors.black),
          ),
        );
      }

      // 키워드에 따라 색상 적용
      final keyword = match.group(0)!;
      final color = keyword == '매수' ? Colors.red : Colors.blue;

      spans.add(
        TextSpan(
          text: keyword,
          style: TextStyle(fontSize: 14, height: 1.0, color: color),
        ),
      );

      lastIndex = match.end;
    }

    // 마지막 키워드 이후의 남은 텍스트 추가
    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: TextStyle(fontSize: 14, height: 1.0, color: Colors.black),
        ),
      );
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(icon, size: 40),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RichText(
                  text: TextSpan(children: _buildTextSpans(description)),
                  softWrap: true,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    stock,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    stockNumber,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
