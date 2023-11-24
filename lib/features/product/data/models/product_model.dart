import 'package:brik_test/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.categoryId,
    required super.categoryName,
    required super.name,
    required super.description,
    required super.sku,
    required super.weight,
    required super.length,
    required super.width,
    required super.height,
    required super.image,
    required super.price,
  });

  const ProductModel.empty()
      : this(
          id: '',
          categoryId: 0,
          categoryName: '',
          sku: '',
          name: '',
          description: '',
          weight: 0,
          width: 0,
          length: 0,
          height: 0,
          image: '',
          price: 0,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] as String,
      categoryId: json['categoryId'] as num,
      categoryName: json['categoryName'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      sku: json['sku'] as String,
      weight: json['weight'] as num,
      length: json['length'] as num,
      width: json['width'] as num,
      height: json['height'] as num,
      image: json['image'] as String,
      price: json['price'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'name': name,
      'description': description,
      'sku': sku,
      'weight': weight,
      'length': length,
      'width': width,
      'height': height,
      'image': image,
      'price': price,
    };
  }
}
