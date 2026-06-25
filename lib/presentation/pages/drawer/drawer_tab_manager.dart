import 'package:rassi_clone/data/models/tab_item.dart';
import 'tabs/navigation_handle_tab.dart';
import 'tabs/expert_tab.dart';
import 'tabs/my_tab.dart';

class DrawerTabManager {
  static List<TabItem> tabItems({
    required void Function(int tabIndex) onNavigateToHomeTab,
    required void Function(int pageIndex) onNavigateToPage,
    required void Function(int tabIndex) onNavigateToPocketTab,
  }) => [
    TabItem(
      label: '매매비서',
      content: NavigationHandleTab(
        onNavigateToHomeTab: onNavigateToHomeTab,
        onNavigateToPage: onNavigateToPage,
        onNavigateToPocketTab: onNavigateToPocketTab,
      ),
    ),
    const TabItem(label: '엑스퍼트', content: ExpertTab()),
    const TabItem(label: 'MY', content: MyTab()),
  ];
}
