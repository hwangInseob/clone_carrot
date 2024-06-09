// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardItem _$BoardItemFromJson(Map<String, dynamic> json) => BoardItem(
      cid: json['cid'] as String,
      image: json['image'] as String,
      location: json['location'] as String,
      price: json['price'] as String,
      likes: json['likes'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$BoardItemToJson(BoardItem instance) => <String, dynamic>{
      'cid': instance.cid,
      'image': instance.image,
      'location': instance.location,
      'price': instance.price,
      'likes': instance.likes,
      'title': instance.title,
    };
