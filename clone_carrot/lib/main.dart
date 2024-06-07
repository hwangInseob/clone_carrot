import 'package:clone_carrot/routes.dart';
import 'package:clone_carrot/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  return runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: HomePage.routeName,
      getPages: routes,
    );
  }
}
