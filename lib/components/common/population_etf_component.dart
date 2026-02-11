import 'package:flutter/material.dart';

// 데이터 모델
class _PopulationEtfData {
  final String categoryName;
  final String signalRate;
  final IconData? icon;

  const _PopulationEtfData({
    required this.categoryName,
    required this.signalRate,
    this.icon,
  });
}

// 샘플 데이터
const List<_PopulationEtfData> _populationEtfData = [
  _PopulationEtfData(
    categoryName: '월배당',
    signalRate: '1',
    icon: Icons.calendar_month,
  ),
  _PopulationEtfData(
    categoryName: '인공지능',
    signalRate: '3',
    icon: Icons.psychology,
  ),
  _PopulationEtfData(
    categoryName: '미국 국채',
    signalRate: '2',
    icon: Icons.account_balance,
  ),
  _PopulationEtfData(
    categoryName: 'AI 전력/인프라',
    signalRate: '3',
    icon: Icons.electrical_services,
  ),
  _PopulationEtfData(
    categoryName: '한국 회사채',
    signalRate: '2',
    icon: Icons.description,
  ),
  _PopulationEtfData(
    categoryName: '밸류업',
    signalRate: '1',
    icon: Icons.trending_up,
  ),
  _PopulationEtfData(categoryName: '양자 컴퓨터', signalRate: '0'),
];

class PopulationEtfComponent extends StatelessWidget {
  const PopulationEtfComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            height: _PopulationEtfCard.cardHeight + 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _populationEtfData.length,
              itemBuilder: (context, index) {
                return _PopulationEtfCard(data: _populationEtfData[index]);
              },
            ),
          ),
        ),
        _viewMoreSection(),
      ],
    );
  }

  Widget _viewMoreSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("ETF 카테고리 모두보기")],
      ),
    );
  }
}

class _PopulationEtfCard extends StatelessWidget {
  final _PopulationEtfData data;
  static const double cardHeight = 120.0;

  const _PopulationEtfCard({required this.data});

  Widget _buildIconWidget(IconData? icon) {
    const double size = 30.0;

    if (icon != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Center(child: Icon(icon, size: 24, color: Colors.black87)),
      );
    } else {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Color(0xFF6665FD).withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'RASSI',
              style: const TextStyle(
                color: Color(0xFF6665FD),
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth / 3.3;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIconWidget(data.icon),
                  SizedBox(height: 16),
                  Text(
                    data.categoryName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '신호발생',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  Text(
                    data.signalRate,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
