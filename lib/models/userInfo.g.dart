// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
    ..id = json['id'] as String
    ..username = json['username'] as String
    ..introduce = json['introduce'] as String
    ..sex = json['sex'] as num
    ..avatar = json['avatar'] as String
    ..phone = json['phone'] as String
    ..userLevel = json['userLevel'] as num
    ..balance = json['balance'] as num
    ..userStatus = json['userStatus'] as num
    ..hasNameAuth = json['hasNameAuth'] as bool
    ..createTime = json['createTime'] as String;
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'introduce': instance.introduce,
      'sex': instance.sex,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'userLevel': instance.userLevel,
      'balance': instance.balance,
      'userStatus': instance.userStatus,
      'hasNameAuth': instance.hasNameAuth,
      'createTime': instance.createTime
    };
