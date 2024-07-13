import 'package:json_annotation/json_annotation.dart';

part 'CreateProductData.g.dart';

@JsonSerializable()
class CreateProductData {
  String? name;
  String? price;

  CreateProductData({
    required this.name,
    required this.price,
  });

  factory CreateProductData.fromJson(Map<String, dynamic> json) =>
      _$CreateProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductDataToJson(this);
}
