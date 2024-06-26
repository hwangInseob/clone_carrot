import 'package:clone_carrot/screen/detail_page.dart';
import 'package:clone_carrot/screen/home/main_page.dart';
import 'package:get/get.dart';

final routes = <GetPage>[
  GetPage(
    name: MainPage.routeName,
    page: () => MainPage(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: DetailPage.routeName,
    page: () => DetailPage(),
    transition: Transition.fadeIn,
  ),
];
