import 'dart:convert';

import 'package:clone_carrot/model/board_item.dart';
import 'package:clone_carrot/repository/contents_repo.dart';
import 'package:clone_carrot/screen/detail_page.dart';
import 'package:clone_carrot/screen/home/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  // TODO: implement controller
  HomePageController get controller => Get.put(HomePageController());

  formatPrice(String price) {
    try {
      return NumberFormat('###,###,###,##0').format(int.parse(price));
    } on Exception catch (e) {
      return price;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.boardItems.isNotEmpty) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              controller.detailItem = controller.boardItems[index];
              Get.toNamed(DetailPage.routeName);
            },
            child: Container(
              height: 130,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      image: AssetImage(controller.boardItems[index].image),
                      width: 100,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.boardItems[index].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            controller.boardItems[index].location,
                            style: TextStyle(color: Color(0x7E000000)),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            formatPrice(controller.boardItems[index].price),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/heart_off.svg',
                                  width: 13,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  controller.boardItems[index].likes,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: Color(0x3D000000),
          ),
          itemCount: controller.boardItems.length,
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('잠시후 다시 시도해주세요.'),
              IconButton(
                onPressed: () {
                  controller.refreshContents();
                },
                icon: Icon(Icons.refresh_rounded),
              ),
            ],
          ),
        );
      }
    });
  }
}

class HomePageController extends GetxController {
  List<Map<String, dynamic>>? testData;
  RxList<BoardItem> boardItems = <BoardItem>[].obs;
  RxBool isLoading = true.obs;
  MainPageController mainPageController = Get.find<MainPageController>();
  late DongMenuItem currentDong;
  BoardItem? detailItem;

  @override
  void onInit() {
    // TODO: implement onInit
    currentDong = mainPageController.currentDong!.value!;
    getContents(currentDong.value);
    ever(mainPageController.currentDong!, (value) {
      currentDong = value!;
      getContents(value.value);
    });
    super.onInit();
  }

  refreshContents() {
    getContents(currentDong.value);
  }

  getContents(int key) async {
    isLoading.value = true;
    boardItems = <BoardItem>[].obs;
    try {
      testData = (await ContentsRepo().getContents(key)).obs;
      for (int i = 0; i < testData!.length; i++) {
        boardItems.add(BoardItem.fromJson(testData![i]));
      }
    } on Exception catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
