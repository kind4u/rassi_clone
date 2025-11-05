// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   late final ScrollController _scrollController;
//   bool _isHeaderCollapsed = false;
//   int _selectedTabIndex = 0;

//   // 상수들
//   static const double _expandedHeight = 150.0;
//   static const double _stickyHeaderHeight = 120.0;
//   static const String _appTitle = '라씨 매매비서';
//   static const String _appIcon = '💹';

//   // 탭 메뉴
//   final List<String> _tabs = ['홈', 'AI매매신호', '종목캐치', '마켓뷰'];

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController()..addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     final isCollapsed = _scrollController.offset >= _expandedHeight;

//     if (isCollapsed != _isHeaderCollapsed) {
//       setState(() => _isHeaderCollapsed = isCollapsed);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         controller: _scrollController,
//         slivers: [_buildAppBar(), _buildStickyHeader(), _buildContentList()],
//       ),
//     );
//   }

//   Widget _buildAppBar() {
//     return SliverAppBar(
//       expandedHeight: _expandedHeight,
//       floating: false,
//       pinned: false,
//       backgroundColor: Colors.white,
//       elevation: 0,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Colors.white, Color(0xFFF8F9FA)],
//             ),
//           ),
//           child: const Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(_appIcon, style: TextStyle(fontSize: 48)),
//                 SizedBox(height: 8),
//                 Text(
//                   _appTitle,
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF6665FD),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStickyHeader() {
//     return SliverPersistentHeader(
//       pinned: true,
//       delegate: _StickyHeaderDelegate(
//         minHeight: _stickyHeaderHeight,
//         maxHeight: _stickyHeaderHeight,
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 offset: Offset(0, 2),
//                 blurRadius: 4,
//               ),
//             ],
//           ),
//           child: Column(children: [_buildSearchBar(), _buildTabBar()]),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: _isHeaderCollapsed
//           ? _buildCollapsedSearchBar()
//           : _buildExpandedSearchBar(),
//     );
//   }

//   Widget _buildExpandedSearchBar() {
//     return Container(
//       height: 44,
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(22),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: const Row(
//         children: [
//           SizedBox(width: 16),
//           Icon(Icons.search, color: Colors.grey),
//           SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: '종목명, 종목코드를 입력하세요',
//                 border: InputBorder.none,
//                 hintStyle: TextStyle(color: Colors.grey),
//               ),
//             ),
//           ),
//           SizedBox(width: 16),
//         ],
//       ),
//     );
//   }

//   Widget _buildCollapsedSearchBar() {
//     return Row(
//       children: [
//         Container(
//           width: 44,
//           height: 44,
//           decoration: BoxDecoration(
//             color: Color(0xFF6665FD).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(22),
//           ),
//           child: const Center(
//             child: Text(_appIcon, style: TextStyle(fontSize: 20)),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Container(
//             height: 44,
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(22),
//               border: Border.all(color: Colors.grey[300]!),
//             ),
//             child: const Row(
//               children: [
//                 SizedBox(width: 16),
//                 Icon(Icons.search, color: Colors.grey),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: '종목명, 종목코드를 입력하세요',
//                       border: InputBorder.none,
//                       hintStyle: TextStyle(color: Colors.grey),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTabBar() {
//     return Container(
//       height: 48,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: _tabs.asMap().entries.map((entry) {
//           final index = entry.key;
//           final tab = entry.value;
//           final isSelected = index == _selectedTabIndex;

//           return Expanded(
//             child: GestureDetector(
//               onTap: () => setState(() => _selectedTabIndex = index),
//               child: Container(
//                 height: 36,
//                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Color(0xFF6665FD) : Colors.transparent,
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Center(
//                   child: Text(
//                     tab,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: isSelected ? Colors.white : Colors.grey[600],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildContentList() {
//     return SliverPadding(
//       padding: const EdgeInsets.all(16.0),
//       sliver: SliverList(delegate: SliverChildListDelegate(_getContentByTab())),
//     );
//   }

//   List<Widget> _getContentByTab() {
//     switch (_selectedTabIndex) {
//       case 0:
//         return _buildHomeContent();
//       case 1:
//         return _buildAISignalContent();
//       case 2:
//         return _buildStockCatchContent();
//       case 3:
//         return _buildMarketViewContent();
//       default:
//         return [];
//     }
//   }

//   // 홈 탭 콘텐츠
//   List<Widget> _buildHomeContent() {
//     return [
//       _buildCard(
//         title: '📊 시장 현황',
//         child: Row(
//           children: [
//             Expanded(
//               child: _buildIndexCard('코스피', '2,480.50', '+12.30', Colors.red),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: _buildIndexCard('코스닥', '850.20', '-5.80', Colors.blue),
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),
//       _buildCard(
//         title: '⭐ 관심 종목',
//         child: Column(
//           children: [
//             _buildStockItem('삼성전자', '70,000', '+1,000', Colors.red),
//             _buildStockItem('LG에너지솔루션', '450,000', '-5,000', Colors.blue),
//             _buildStockItem('NAVER', '180,000', '+2,500', Colors.red),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),
//       _buildCard(
//         title: '📰 투자 뉴스',
//         child: Column(
//           children: [
//             _buildNewsItem('반도체 시장 회복 기대감 확산', '30분 전'),
//             _buildNewsItem('국내 증시, 외국인 순매수 지속', '1시간 전'),
//             _buildNewsItem('금리 인하 기대감으로 상승장 전망', '2시간 전'),
//           ],
//         ),
//       ),
//       const SizedBox(height: 100),
//     ];
//   }

//   // AI매매신호 탭 콘텐츠
//   List<Widget> _buildAISignalContent() {
//     return [
//       _buildCard(
//         title: '🤖 AI 매매 신호',
//         child: Column(
//           children: [
//             _buildSignalItem('삼성전자', '매수', '강력 추천', Colors.red),
//             _buildSignalItem('SK하이닉스', '매도', '위험 신호', Colors.blue),
//             _buildSignalItem('LG에너지솔루션', '보유', '관망', Colors.orange),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),
//       _buildCard(
//         title: '📈 신호 히스토리',
//         child: Column(
//           children: [
//             _buildHistoryItem('2024-01-15', '삼성전자 매수', '+12.5%'),
//             _buildHistoryItem('2024-01-14', 'SK하이닉스 매도', '+8.3%'),
//             _buildHistoryItem('2024-01-13', 'LG에너지 보유', '+0.5%'),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),
//       _buildCard(
//         title: '🔔 최근 신호',
//         child: Column(
//           children: [
//             _buildRecentSignalItem('방금 전', '테슬라', '매수 신호', Colors.red),
//             _buildRecentSignalItem('5분 전', '애플', '매도 신호', Colors.blue),
//             _buildRecentSignalItem('10분 전', '마이크로소프트', '보유 신호', Colors.orange),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),
//       _buildCard(
//         title: '📊 신호 성과',
//         child: Column(
//           children: [
//             _buildPerformanceItem('이번 주', '성공률 78%', '+12.5%'),
//             _buildPerformanceItem('이번 달', '성공률 82%', '+24.8%'),
//             _buildPerformanceItem('3개월', '성공률 75%', '+45.2%'),
//           ],
//         ),
//       ),
//       const SizedBox(height: 100),
//     ];
//   }

//   // 종목캐치 탭 콘텐츠
//   List<Widget> _buildStockCatchContent() {
//     return [
//       _buildCard(
//         title: '🎯 종목 캐치',
//         child: Column(
//           children: [
//             _buildCatchItem('급등 예상주', '테슬라, 애플, 엔비디아', Colors.red),
//             _buildCatchItem('배당주', '코카콜라, 존슨앤존슨', Colors.green),
//             _buildCatchItem('성장주', '구글, 마이크로소프트', Colors.blue),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),
//       _buildCard(
//         title: '🔥 트렌딩 종목',
//         child: Column(
//           children: [
//             _buildTrendingItem('엔비디아', '급등', '+15.2%', Colors.red),
//             _buildTrendingItem('테슬라', '상승', '+8.5%', Colors.red),
//             _buildTrendingItem('애플', '보합', '+1.2%', Colors.grey),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),
//       _buildCard(
//         title: '📈 돌파 종목',
//         child: Column(
//           children: [
//             _buildBreakoutItem('삼성전자', '저항선 돌파', '70,500원'),
//             _buildBreakoutItem('SK하이닉스', '상승 삼각형', '122,000원'),
//             _buildBreakoutItem('LG화학', '박스권 상단', '385,000원'),
//           ],
//         ),
//       ),
//       const SizedBox(height: 100),
//     ];
//   }

//   // 마켓뷰 탭 콘텐츠
//   List<Widget> _buildMarketViewContent() {
//     return [
//       _buildCard(
//         title: '🌍 글로벌 시장',
//         child: Column(
//           children: [
//             _buildMarketViewItem('미국 시장', '상승 +1.2%', Colors.red),
//             _buildMarketViewItem('중국 시장', '하락 -0.8%', Colors.blue),
//             _buildMarketViewItem('유럽 시장', '보합 +0.1%', Colors.grey),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),
//       _buildCard(
//         title: '📊 시장 분석',
//         child: Column(
//           children: [
//             _buildAnalysisItem('시장 심리', '중립', '투자자 심리 지수 50'),
//             _buildAnalysisItem('기술적 분석', '강세', '상승 추세 지속'),
//             _buildAnalysisItem('거시경제', '양호', '금리 안정화'),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16),
//       _buildCard(
//         title: '🌐 해외 주요 지수',
//         child: Column(
//           children: [
//             _buildIndexItem('S&P 500', '4,850.20', '+1.2%', Colors.red),
//             _buildIndexItem('나스닥', '15,200.50', '+1.8%', Colors.red),
//             _buildIndexItem('다우존스', '38,500.80', '+0.9%', Colors.red),
//           ],
//         ),
//       ),
//       const SizedBox(height: 100),
//     ];
//   }

//   // 헬퍼 위젯들
//   Widget _buildCard({required String title, required Widget child}) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),
//             child,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildIndexCard(
//     String name,
//     String value,
//     String change,
//     Color color,
//   ) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             name,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             value,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             change,
//             style: TextStyle(
//               fontSize: 12,
//               color: color,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStockItem(
//     String name,
//     String price,
//     String change,
//     Color color,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             name,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           Row(
//             children: [
//               Text(
//                 price,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 change,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: color,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNewsItem(String title, String time) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Icon(Icons.article, size: 16, color: Colors.grey),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   time,
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSignalItem(
//     String name,
//     String signal,
//     String description,
//     Color color,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             name,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   signal,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: color,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 description,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHistoryItem(String date, String action, String result) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 action,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 date,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ],
//           ),
//           Text(
//             result,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRecentSignalItem(
//     String time,
//     String stock,
//     String signal,
//     Color color,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Container(
//             width: 8,
//             height: 8,
//             decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '$stock - $signal',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   time,
//                   style: const TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPerformanceItem(String period, String success, String return_) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             period,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 success,
//                 style: const TextStyle(fontSize: 12, color: Colors.blue),
//               ),
//               Text(
//                 return_,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Colors.red,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCatchItem(String category, String stocks, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             category,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: color,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               stocks,
//               style: const TextStyle(fontSize: 14, color: Colors.grey),
//               textAlign: TextAlign.end,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTrendingItem(
//     String stock,
//     String trend,
//     String change,
//     Color color,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             stock,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   trend,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: color,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 change,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: color,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBreakoutItem(String stock, String pattern, String price) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 stock,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 pattern,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ],
//           ),
//           Text(
//             price,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMarketViewItem(String market, String trend, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             market,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           Text(
//             trend,
//             style: TextStyle(
//               fontSize: 14,
//               color: color,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAnalysisItem(
//     String category,
//     String status,
//     String description,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 category,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 description,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ],
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: status == '강세'
//                   ? Colors.red.withOpacity(0.1)
//                   : status == '약세'
//                   ? Colors.blue.withOpacity(0.1)
//                   : Colors.grey.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               status,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: status == '강세'
//                     ? Colors.red
//                     : status == '약세'
//                     ? Colors.blue
//                     : Colors.grey,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildIndexItem(
//     String name,
//     String value,
//     String change,
//     Color color,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             name,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           Row(
//             children: [
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 change,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: color,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // SliverPersistentHeader용 Delegate
// class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final double minHeight;
//   final double maxHeight;
//   final Widget child;

//   _StickyHeaderDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });

//   @override
//   double get minExtent => minHeight;

//   @override
//   double get maxExtent => maxHeight;

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return SizedBox.expand(child: child);
//   }

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return maxHeight != oldDelegate.maxExtent ||
//         minHeight != oldDelegate.minExtent;
//   }
// }
