// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
    ..userId = json['userId'] as String
    ..username = json['username'] as String
    ..phone = json['phone'] as String
    ..userLevel = json['userLevel'] as num
    ..balance = json['balance'] as num
    ..userStatus = json['userStatus'] as num
    ..hasNameAuth = json['hasNameAuth'] as bool;
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'phone': instance.phone,
      'userLevel': instance.userLevel,
      'balance': instance.balance,
      'userStatus': instance.userStatus,
      'hasNameAuth': instance.hasNameAuth
    };
