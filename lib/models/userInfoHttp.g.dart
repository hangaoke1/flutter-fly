// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfoHttp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoHttp _$UserInfoHttpFromJson(Map<String, dynamic> json) {
  return UserInfoHttp()
    ..code = json['code'] as num
    ..data = json['data'] == null
        ? null
        : UserInfo.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserInfoHttpToJson(UserInfoHttp instance) =>
    <String, dynamic>{'code': instance.code, 'data': instance.data};
