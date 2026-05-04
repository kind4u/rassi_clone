import 'package:flutter/material.dart';

class AIKeywordStatsCard extends StatelessWidget {
  const AIKeywordStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A237E), // Navy blue
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatColumn(
              icon: Icons.description,
              number: '76,798',
              label: '문서 추출',
              numberColor: Colors.white,
            ),
          ),
          Expanded(
            child: _buildStatColumn(
              icon: Icons.search,
              number: '2,100',
              label: '분석 종목',
              numberColor: Colors.white,
            ),
          ),
          Expanded(
            child: _buildStatColumn(
              icon: Icons.touch_app,
              number: '48,075',
              label: '키워드 픽',
              numberColor: const Color(0xFF6A1B9A), // Dark purple
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn({
    required IconData icon,
    required String number,
    required String label,
    required Color numberColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          number,
          style: TextStyle(
            color: numberColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}