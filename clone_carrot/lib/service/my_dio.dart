import 'package:clone_carrot/model/board_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class MyDio {
  static final _instance = MyDio._internal();

  late final Dio dio;

  factory MyDio() {
    return _instance;
  }

  MyDio._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.45.171:8080",
        contentType: Headers.jsonContentType,
      ),
    );
  }

  Future<void> test() async {
    final response = await dio.get('/test');
    final boardItem = BoardItem.fromJson(response.data);
    debugPrint('....');
  }
}
