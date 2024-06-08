import 'package:clone_carrot/model/board_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  // TODO: implement controller
  HomePageController get controller => Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => Container(
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
                        "${NumberFormat('###,###,###,##0').format(int.parse(controller.boardItems[index].price))}원",
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
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: Color(0x3D000000),
        ),
        itemCount: controller.boardItems.length,
      ),
    );
  }
}

class HomePageController extends GetxController {
  List<Map<String, dynamic>> testData = <Map<String, dynamic>>[
    {
      "cid": "1",
      "image": "assets/images/ara-1.jpg",
      "title": "네메시스 축구화275",
      "location": "제주 제주시 아라동",
      "price": "30000",
      "likes": "2"
    },
    {
      "cid": "2",
      "image": "assets/images/ara-2.jpg",
      "title": "LA갈비 5kg팔아요~",
      "location": "제주 제주시 아라동",
      "price": "100000",
      "likes": "5"
    },
    {
      "cid": "3",
      "image": "assets/images/ara-3.jpg",
      "title": "치약팝니다",
      "location": "제주 제주시 아라동",
      "price": "5000",
      "likes": "0"
    },
    {
      "cid": "4",
      "image": "assets/images/ara-4.jpg",
      "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
      "location": "제주 제주시 아라동",
      "price": "2500000",
      "likes": "6"
    },
    {
      "cid": "5",
      "image": "assets/images/ara-5.jpg",
      "title": "디월트존기임팩",
      "location": "제주 제주시 아라동",
      "price": "150000",
      "likes": "2"
    },
    {
      "cid": "6",
      "image": "assets/images/ara-6.jpg",
      "title": "갤럭시s10",
      "location": "제주 제주시 아라동",
      "price": "180000",
      "likes": "2"
    },
    {
      "cid": "7",
      "image": "assets/images/ara-7.jpg",
      "title": "선반",
      "location": "제주 제주시 아라동",
      "price": "15000",
      "likes": "2"
    },
    {
      "cid": "8",
      "image": "assets/images/ara-8.jpg",
      "title": "냉장 쇼케이스",
      "location": "제주 제주시 아라동",
      "price": "80000",
      "likes": "3"
    },
    {
      "cid": "9",
      "image": "assets/images/ara-9.jpg",
      "title": "대우 미니냉장고",
      "location": "제주 제주시 아라동",
      "price": "30000",
      "likes": "3"
    },
    {
      "cid": "10",
      "image": "assets/images/ara-10.jpg",
      "title": "멜킨스 풀업 턱걸이 판매합니다.",
      "location": "제주 제주시 아라동",
      "price": "50000",
      "likes": "7"
    },
  ];
  RxList<BoardItem> boardItems = <BoardItem>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    for (int i = 0; i < testData.length; i++) {
      boardItems.add(BoardItem.fromJson(testData[i]));
    }
    super.onInit();
  }
}
