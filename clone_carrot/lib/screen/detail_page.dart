import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clone_carrot/component/manner_temperature.dart';
import 'package:clone_carrot/model/board_item.dart';
import 'package:clone_carrot/screen/home/home_page.dart';
import 'package:clone_carrot/service/my_dio.dart';
import 'package:clone_carrot/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class DetailPage extends GetView<DetailPageController> {
  static const routeName = "/detail";

  const DetailPage({super.key});

  @override
  // TODO: implement controller
  DetailPageController get controller => Get.put(DetailPageController());

  _getTextStyle1() {
    return TextStyle(fontSize: 12, color: Colors.black38);
  }

  _onClickShare() {
    debugPrint("##################################");
    MyDio().test();
    debugPrint("##################################");
  }

  _onClickMore() {
    debugPrint("##################################");
    debugPrint("IMPLEMENTS MORE MENU !!!");
    debugPrint("##################################");
  }

  _getAnimateIcon(icon) {
    return AnimatedBuilder(
      animation: controller.animation,
      builder: (context, child) => Icon(
        icon,
        color: controller.animation.value,
      ),
    );
  }

  _getAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: _getAnimateIcon(Icons.arrow_back_rounded),
      ),
      backgroundColor: Colors.white.withAlpha(controller.headerAlpha.value),
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [
        IconButton(
          onPressed: _onClickShare,
          icon: _getAnimateIcon(Icons.share_rounded),
        ),
        IconButton(
          onPressed: _onClickMore,
          icon: _getAnimateIcon(Icons.more_vert_sharp),
        ),
      ],
    );
  }

  _getSlideImageWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Hero(
            tag: controller.item.value.cid,
            child: CarouselSlider(
              items: List.generate(
                controller.imageCount,
                (index) => Image.asset(
                  controller.item.value.image,
                  fit: BoxFit.contain,
                ),
              ),
              carouselController: controller.carouselController,
              options: CarouselOptions(
                //시작 페이지
                initialPage: 0,
                //무한 스크롤
                enableInfiniteScroll: false,
                //사용하는 화면 비율
                viewportFraction: 1,
                height: MediaQuery.sizeOf(context).width,
                onPageChanged: (index, reason) {
                  controller.currentImageIndex.value = index;
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.imageCount,
                  (index) => Obx(
                    () => Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: controller.currentImageIndex.value == index
                            ? Colors.white
                            : Colors.white.withOpacity(.4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //작성자 프로필
  _getSellerInfo() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(50),
            //   child: Image.asset(
            //     "assets/images/user.png",
            //     width: 50,
            //   ),
            // )
            /*
            * 아래가 더 간결함*/
            // 프로필
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            SizedBox(
              width: 10,
            ),
            // 닉네임, 주소
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HardFlutter",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('북구 구암동'),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MannerTemperature(
                    mannerTemp: 43.7,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getDivideLine() {
    return Container(
      width: double.infinity,
      color: Colors.black26,
      height: .6,
      margin: EdgeInsets.symmetric(vertical: 10),
    );
  }

  _getContentsDetail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            controller.item.value.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            '디지털/가전 · 23시간 전',
            style: _getTextStyle1(),
          ),
          SizedBox(
            height: 10,
          ),
          Text('선물받은 새상품이고\n상품 꺼내보기만 했습니다.\n거래는 직거래만 합니다.'),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Row(
                children: [
                  Text('채팅', style: _getTextStyle1()),
                  Text('3', style: _getTextStyle1()),
                  Text(' · ', style: _getTextStyle1()),
                  Text('관심', style: _getTextStyle1()),
                  Text('17', style: _getTextStyle1()),
                  Text(' · ', style: _getTextStyle1()),
                  Text('조회', style: _getTextStyle1()),
                  Text('138', style: _getTextStyle1()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getOtherSellGrid() {
    return SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1),
        delegate: SliverChildBuilderDelegate(
          childCount: 15,
          (context, index) => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        controller.item.value.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  controller.item.value.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  controller.item.value.price.formatPrice() + '원',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getBody(context) {
    return CustomScrollView(
      controller: controller.scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _getSlideImageWidget(context),
              _getSellerInfo(),
              _getDivideLine(),
              _getContentsDetail(),
              _getDivideLine(),
              _getOtherSellContents(),
            ],
          ),
        ),
        _getOtherSellGrid(),
      ],
    );
  }

  _getBottomBar() {
    return Container(
      width: double.infinity,
      height: 60,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border_rounded,
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.item.value.price.formatPrice() + '원',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '가격제안불가',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          InkWell(
            child: Container(
              height: 40,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                  ),
                  BoxShadow(
                    color: Colors.orange,
                    spreadRadius: -1,
                    blurRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.orange,
                    spreadRadius: -1,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '채팅으로 거래하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getOtherSellContents() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '판매자의 다른 상품',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '모두보기',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          //앱바 뒷부분까지 사용한다는 옵션
          extendBodyBehindAppBar: true,
          appBar: _getAppBar(),
          body: _getBody(context),
          bottomNavigationBar: _getBottomBar(),
        ),
      ),
    );
  }
}

class DetailPageController extends FullLifeCycleController
    with GetSingleTickerProviderStateMixin {
  late Rx<BoardItem> item;
  HomePageController homePageController = Get.find<HomePageController>();
  RxInt currentImageIndex = 0.obs;
  CarouselController carouselController = CarouselController();
  int imageCount = 5; // 임시

  ScrollController scrollController = ScrollController();

  late AnimationController animationController;
  late Animation animation;

  RxInt headerAlpha = 0.obs;

  @override
  void onInit() {
    // TODO : Get BoardItem from route parameter
    item = homePageController.detailItem!.obs;
    animationController = AnimationController(vsync: this);
    animation = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(animationController);
    scrollController.addListener(onScrollEvent);
    super.onInit();
  }

  onScrollEvent() {
    headerAlpha.value =
        scrollController.offset >= 255 ? 255 : scrollController.offset.round();

    animationController.value = headerAlpha.value / 255;
  }
}
