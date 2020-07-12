import 'package:json_annotation/json_annotation.dart';
import "dynamicUser.dart";
part 'dynamic.g.dart';

@JsonSerializable()
class Dynamic {
    Dynamic();

    num id;
    num type;
    DynamicUser user;
    String content;
    List imageList;
    num commentCount;
    num like;
    String createTime;
    
    factory Dynamic.fromJson(Map<String,dynamic> json) => _$DynamicFromJson(json);
    Map<String, dynamic> toJson() => _$DynamicToJson(this);
}
