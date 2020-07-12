import 'package:json_annotation/json_annotation.dart';

part 'dynamicUser.g.dart';

@JsonSerializable()
class DynamicUser {
    DynamicUser();

    String id;
    String username;
    String avatar;
    num sex;
    
    factory DynamicUser.fromJson(Map<String,dynamic> json) => _$DynamicUserFromJson(json);
    Map<String, dynamic> toJson() => _$DynamicUserToJson(this);
}
