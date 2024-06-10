import 'dart:convert';

import 'package:clone_carrot/model/board_item.dart';
import 'package:clone_carrot/screen/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends GetView<DetailPageController> {
  static const routeName = "/detail";

  const DetailPage({super.key});

  @override
  // TODO: implement controller
  DetailPageController get controller => Get.put(DetailPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Text(controller.item.value.title),),
      ),
    );
  }
}

class DetailPageController extends GetxController {
  late Rx<BoardItem> item;
  HomePageController homePageController = Get.find<HomePageController>();

  @override
  void onInit() {
    // TODO : Get BoardItem from route parameter
    item = homePageController.detailItem!.obs;
    super.onInit();
  }

}
