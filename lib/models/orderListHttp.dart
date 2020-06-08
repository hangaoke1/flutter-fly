import 'package:json_annotation/json_annotation.dart';
import "order.dart";
part 'orderListHttp.g.dart';

@JsonSerializable()
class OrderListHttp {
    OrderListHttp();

    num code;
    List<Order> data;
    
    factory OrderListHttp.fromJson(Map<String,dynamic> json) => _$OrderListHttpFromJson(json);
    Map<String, dynamic> toJson() => _$OrderListHttpToJson(this);
}
