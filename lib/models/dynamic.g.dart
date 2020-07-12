// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dynamic _$DynamicFromJson(Map<String, dynamic> json) {
  return Dynamic()
    ..id = json['id'] as num
    ..type = json['type'] as num
    ..user = json['user'] == null
        ? null
        : DynamicUser.fromJson(json['user'] as Map<String, dynamic>)
    ..content = json['content'] as String
    ..imageList = json['imageList'] as List
    ..commentCount = json['commentCount'] as num
    ..like = json['like'] as num
    ..createTime = json['createTime'] as String;
}

Map<String, dynamic> _$DynamicToJson(Dynamic instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'user': instance.user,
      'content': instance.content,
      'imageList': instance.imageList,
      'commentCount': instance.commentCount,
      'like': instance.like,
      'createTime': instance.createTime
    };
