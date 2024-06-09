import 'dart:convert';

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

  PreferredSizeWidget _getAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: GestureDetector(
        //TODO: implements on tap
        onTap: () {
          debugPrint('click');
        },
        child: PopupMenuButton<DongMenuItem>(
          offset: Offset(10, 20),
          color: Colors.white,
          splashRadius: 0,
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              3),
          onSelected: (value) {
            controller.currentDong!.value = value;
          },
          itemBuilder: (context) => [
            for (var i in controller.dongMenuItems)
              PopupMenuItem<DongMenuItem>(
                value: i,
                child: Text(i.name),
              ),
          ],
          child: Row(
            children: [
              Obx(
                () => Text(controller.currentDong!.value!.name),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
              ),
            ],
          ),
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
        appBar: _getAppBar(context),
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
  RxList<DongMenuItem> dongMenuItems = <DongMenuItem>[
    DongMenuItem(name: '태전동', value: 0),
    DongMenuItem(name: '구암동', value: 1),
    DongMenuItem(name: '복현동', value: 2),
  ].obs;
  Rx<DongMenuItem?>? currentDong;

  @override
  void onInit() {
    // TODO: implement onInit
    currentDong = dongMenuItems.first.obs;
    super.onInit();
  }
}

class DongMenuItem {
  String name;
  int value;

  factory DongMenuItem.fromJson(Map<String, dynamic> json) {
    return DongMenuItem(name: json['name'], value: json['value']);
  }

  DongMenuItem({
    required this.name,
    required this.value,
  });

  // factory _DongMenuItem.clone() {
  //   return _DongMenuItem.fromJson(jsonDecode(jsonEncode(this)));
  // }
}

class _BottomNaviBarItem {
  String label;
  String svgPath;

  _BottomNaviBarItem({
    required this.label,
    required this.svgPath,
  });
}
