class Order {
  int id;
  String name;
  String createTime;
  double price;

  Order.fromJson(Map data) {
    id = data['id'];
    name = data['name'];
    createTime = data['createTime'];
    price = data['price'];
  }
}
