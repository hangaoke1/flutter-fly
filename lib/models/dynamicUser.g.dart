// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamicUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicUser _$DynamicUserFromJson(Map<String, dynamic> json) {
  return DynamicUser()
    ..id = json['id'] as String
    ..username = json['username'] as String
    ..avatar = json['avatar'] as String
    ..sex = json['sex'] as num;
}

Map<String, dynamic> _$DynamicUserToJson(DynamicUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'sex': instance.sex
    };
