import 'package:flutter/material.dart';

class ResultTopCard extends StatelessWidget {
  const ResultTopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        spacing: 12.0,
        children: [
          _resultTopCard(title: "적중률"),
          _resultTopCard(title: "누적수익률"),
          _resultTopCard(title: "최대수익률"),
          _resultTopCard(title: "평균수익률"),
          _resultTopCard(title: "수익난 매매"),
        ],
      ),
    );
  }
}

class _resultTopCard extends StatelessWidget {
  final String title;

  const _resultTopCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 6,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.workspace_premium_outlined, size: 36.0),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ],
            ),

            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text('TOP', style: TextStyle(fontSize: 14)),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text(
                      '50',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text('종목', style: TextStyle(fontSize: 14)),
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
