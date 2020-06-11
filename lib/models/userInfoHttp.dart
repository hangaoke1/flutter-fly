import 'package:json_annotation/json_annotation.dart';
import "userInfo.dart";
part 'userInfoHttp.g.dart';

@JsonSerializable()
class UserInfoHttp {
    UserInfoHttp();

    num code;
    UserInfo data;
    
    factory UserInfoHttp.fromJson(Map<String,dynamic> json) => _$UserInfoHttpFromJson(json);
    Map<String, dynamic> toJson() => _$UserInfoHttpToJson(this);
}
