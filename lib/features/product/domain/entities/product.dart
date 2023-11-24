import 'package:brik_test/features/product/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class Product extends Equatable {
  const Product({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.sku,
    required this.name,
    required this.description,
    required this.weight,
    required this.width,
    required this.length,
    required this.height,
    required this.image,
    required this.price,
  });

  const Product.empty()
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

  factory Product.fromModel(ProductModel model) {
    return Product(
      id: model.id,
      categoryId: model.categoryId,
      categoryName: model.categoryName,
      sku: model.sku,
      name: model.name,
      description: model.description,
      weight: model.weight,
      width: model.width,
      length: model.length,
      height: model.height,
      image: model.image,
      price: model.price,
    );
  }

  final String id;
  final num categoryId;
  final String categoryName;
  final String sku;
  final String name;
  final String description;
  final num weight;
  final num width;
  final num length;
  final num height;
  final String image;
  final num price;

  @override
  List<Object> get props => [
        id,
        categoryId,
        categoryName,
        sku,
        name,
        description,
        weight,
        width,
        length,
        height,
        image,
        price,
      ];
}
