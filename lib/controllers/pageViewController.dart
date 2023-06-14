import 'package:get/get.dart';
import 'package:haider/views/drawerViews/homeViewsitems/rentOutView.dart';
import 'package:haider/views/drawerViews/homeViewsitems/rentView.dart';

import '../views/addDataScreen.dart';
import '../views/drawerViews/homeViewsitems/catogries/carogrylist.dart';

class PageViewController extends GetxController {
  var activityList = [
    'Home'.tr,
    // 'catogries',
    'Leasing',
    // 'Sell',
  ];

  var pageViewIndex = 0.obs;
  var pageViewItems = [
    catogrylist(),
    RentView(),
    AddDataScreen(
      value: '',
    ),
    RentOutView(),

    // SellView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
