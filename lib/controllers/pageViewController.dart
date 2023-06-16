import 'package:get/get.dart';
import 'package:haider/views/drawerViews/homeViewsitems/rentOutView.dart';
import 'package:haider/views/drawerViews/homeViewsitems/rentView.dart';

import '../views/addDataScreen.dart';
import '../views/drawerViews/homeViewsitems/catogries/carogrylist.dart';

class PageViewController extends GetxController {
  var pageViewIndex = 0.obs;
  var pageViewItems = [
    RentView(),
    catogrylist(),
    AddDataScreen(
      value: '',
    ),
    RentOutView(),

    // SellView(),
  ];
}
