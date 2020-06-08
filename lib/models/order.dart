import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
    Order();

    num id;
    String name;
    num price;
    String createTime;
    
    factory Order.fromJson(Map<String,dynamic> json) => _$OrderFromJson(json);
    Map<String, dynamic> toJson() => _$OrderToJson(this);
}
