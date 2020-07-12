import 'package:json_annotation/json_annotation.dart';

part 'userInfo.g.dart';

@JsonSerializable()
class UserInfo {
    UserInfo();

    String id;
    String username;
    String introduce;
    num sex;
    String avatar;
    String phone;
    num userLevel;
    num balance;
    num userStatus;
    bool hasNameAuth;
    String createTime;
    
    factory UserInfo.fromJson(Map<String,dynamic> json) => _$UserInfoFromJson(json);
    Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
