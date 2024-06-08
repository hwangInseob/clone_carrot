class BoardItem {
  BoardItem({
    required this.cid,
    required this.image,
    required this.location,
    required this.price,
    required this.likes,
    required this.title,
  });

  factory BoardItem.fromJson(Map<String, dynamic> json) {
    return BoardItem(
      cid: json["cid"],
      image: json["image"],
      location: json["location"],
      price: json["price"],
      likes: json["likes"],
      title: json["title"],
    );
  }

  String cid;
  String image;
  String location;
  String price;
  String likes;
  String title;
}
