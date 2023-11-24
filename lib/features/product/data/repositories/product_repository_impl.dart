import 'package:brik_test/core/error/failures.dart';
import 'package:brik_test/core/utils/network_info.dart';
import 'package:brik_test/features/product/data/datasources/product_data_source.dart';
import 'package:brik_test/features/product/data/models/product_model.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.datasource, required this.networkInfo});

  final ProductDatasource datasource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<ProductModel>>> getProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.getProduct();
        return Right(result);
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ProductModel>> addProduct({
    required Product product,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.addProduct(product: product);
        return Right(result);
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateProduct({
    required Product product,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.updateProduct(product: product);
        return Right(result);
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct({
    required Product product,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasource.deleteProduct(product: product);
        return Right(result);
      } catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
