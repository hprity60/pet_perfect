class ShopData {
  List<ShopItem> shopItems;

  ShopData({this.shopItems});
  void addProduct(ShopItem p) {
    shopItems.add(p);
  }

  void remProduct(ShopItem p) {
    shopItems.remove(p);
  }

  factory ShopData.fromJson(Map<String, dynamic> json) => ShopData(
        shopItems: List<ShopItem>.from(
            json["foodsInsights"].map((x) => ShopItem.fromJson(x))),
      );
}

class ShopItem {
  String imageUrl;
  String thumbnail;
  String title;
  double price;
  int quantity;
  ShopItem({
    this.imageUrl,
    this.thumbnail,
    this.price,
    this.title,
    this.quantity,
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) => ShopItem(
        imageUrl: json['imageUrl'],
        price: json['price'],
        title: json['title'],
        quantity: json['quantity'],
        thumbnail: json['thumbnail']
      );
}
