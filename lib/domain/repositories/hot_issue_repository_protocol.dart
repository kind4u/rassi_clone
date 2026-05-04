import 'package:rassi_clone/domain/entities/hot_issue_item.dart';

/// 핫이슈 데이터 접근을 정의하는 프로토콜
abstract class HotIssueRepositoryProtocol {
  List<HotIssueItem> getItems({
    required String country,
    required int timeGroup,
  });
}
