// import 'dart:convert';
//
// import 'package:json_annotation/json_annotation.dart';
//
// part 'ProductData.g.dart';
//
// @JsonSerializable()
// class ProductData {
//   String? name;
//   String? price;
//
//   ProductData({
//     required this.name,
//     required this.price,
//   });
//
//   factory ProductData.fromJson(Map<String, dynamic> json) =>
//       _$ProductDataFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ProductDataToJson(this);
// }

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'ProductData.g.dart';

@JsonSerializable()
class ProductData {
  String? name;
  String? price;
  String? image;

  ProductData({
    required this.name,
    required this.price,
    this.image,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataToJson(this);
}
