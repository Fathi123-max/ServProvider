import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/pageViewController.dart';
import 'package:haider/utills/customColors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  final ValueNotifier<int> _pageIndex = ValueNotifier<int>(0);
  final PageViewController pageViewController = Get.put(PageViewController());

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex.value);
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: _pageIndex.value);
    _pageIndex.addListener(() {
      _pageController.jumpToPage(_pageIndex.value);
      _tabController.animateTo(_pageIndex.value);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    _pageIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        height: 50,
        controller: _tabController,
        backgroundColor: CustomColors.orangeColor,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.design_services_sharp, title: 'Services'),
          TabItem(icon: Icons.add, title: 'Add Service'),
          TabItem(icon: Icons.people, title: 'My Services'),
        ],
        onTap: (int i) {
          _pageIndex.value = i;
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                _pageIndex.value = index;
              },
              controller: _pageController,
              children: pageViewController.pageViewItems,
            ),
          ),
        ],
      ),
    );
  }
}
