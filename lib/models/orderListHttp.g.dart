// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderListHttp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListHttp _$OrderListHttpFromJson(Map<String, dynamic> json) {
  return OrderListHttp()
    ..code = json['code'] as num
    ..data = (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderListHttpToJson(OrderListHttp instance) =>
    <String, dynamic>{'code': instance.code, 'data': instance.data};
