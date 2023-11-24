import 'package:brik_test/core/error/failures.dart';
import 'package:brik_test/core/utils/usecase.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class DoGetProduct extends UseCaseNoParam<List<Product>> {
  DoGetProduct({required this.repository});

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<Product>>> call() async {
    final result = await repository.getProduct();
    return result.fold(
      (l) => Left(l),
      (r) => Right(
        r.map((e) => Product.fromModel(e)).toList(),
      ),
    );
  }
}
