import 'package:clone_carrot/model/board_item.dart';
import 'package:clone_carrot/screen/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainPage extends GetView<MainPageController> {
  static const routeName = "/home";
  MainPage({super.key});

  @override
  // TODO: implement controller
  MainPageController get controller => Get.put(MainPageController());

  PreferredSizeWidget _getAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      title: GestureDetector(
        //TODO: implements on tap
        onTap: () {
          debugPrint('click');
        },
        child: Row(
          children: [
            Text('태전동'),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 30,
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.tune),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/svg/bell.svg',
            width: 22,
          ),
        ),
      ],
    );
  }

  Widget _getBodyWidget(BuildContext context, int index) {
    switch (index) {
      case 0:
        return HomePage();
        break;
      default:
        return Center(
          child: Text('Try Later'),
        );
    }
  }

  Widget _getBottomNavigationBar(BuildContext context) {
    return Obx(
      () => Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.bottomNavigationBarIndex.value,
          onTap: (value) => controller.bottomNavigationBarIndex.value = value,
          key: controller.bottomBarKey,
          fixedColor: Colors.black,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            for (var i in controller.bottomNaviBarItems)
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/${i.svgPath}off.svg',
                  width: 13,
                  fit: BoxFit.contain,
                ),
                label: i.label,
                activeIcon: SvgPicture.asset(
                  'assets/svg/${i.svgPath}on.svg',
                  width: 13,
                  fit: BoxFit.contain,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _getAppBar(),
        body: Obx(
          () => _getBodyWidget(
              context, controller.bottomNavigationBarIndex.value),
        ),
        bottomNavigationBar: _getBottomNavigationBar(context),
      ),
    );
  }
}

class MainPageController extends GetxController {
  RxList<_BottomNaviBarItem> bottomNaviBarItems = <_BottomNaviBarItem>[
    _BottomNaviBarItem(label: '홈', svgPath: 'home_'),
    _BottomNaviBarItem(label: '동네생활', svgPath: 'notes_'),
    _BottomNaviBarItem(label: '내 근처', svgPath: 'location_'),
    _BottomNaviBarItem(label: '채팅', svgPath: 'chat_'),
    _BottomNaviBarItem(label: '나의 당근', svgPath: 'user_'),
  ].obs;

  GlobalKey bottomBarKey = GlobalKey(debugLabel: 'btm_navi_bar');

  RxInt bottomNavigationBarIndex = 0.obs;
}

class _BottomNaviBarItem {
  String label;
  String svgPath;

  _BottomNaviBarItem({
    required this.label,
    required this.svgPath,
  });
}
