import 'package:json_annotation/json_annotation.dart';

part 'board_item.g.dart';

@JsonSerializable()
class BoardItem {
  String cid;
  String image;
  String location;
  String price;
  String likes;
  String title;

  BoardItem({
    required this.cid,
    required this.image,
    required this.location,
    required this.price,
    required this.likes,
    required this.title,
  });

  factory BoardItem.fromJson(Map<String, dynamic> json) =>
      _$BoardItemFromJson(json);

  Map<String, dynamic> toJson() => _$BoardItemToJson(this);
}
