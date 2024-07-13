import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'UserData.g.dart';

@JsonSerializable()
class UserData {
  String token;

  UserData({
    required this.token,
    });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
