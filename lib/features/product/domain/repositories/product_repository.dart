import 'package:brik_test/core/error/failures.dart';
import 'package:brik_test/features/product/data/models/product_model.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProduct();

  Future<Either<Failure, ProductModel>> addProduct({
    required Product product,
  });

  Future<Either<Failure, bool>> updateProduct({
    required Product product,
  });

  Future<Either<Failure, bool>> deleteProduct({
    required Product product,
  });
}
