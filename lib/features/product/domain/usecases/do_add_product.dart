import 'package:brik_test/core/error/failures.dart';
import 'package:brik_test/core/utils/usecase.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class DoAddProduct extends UseCase<Product, DoAddProductParams> {
  DoAddProduct({required this.repository});
  final ProductRepository repository;

  @override
  Future<Either<Failure, Product>> call(DoAddProductParams param) async {
    final result = await repository.addProduct(product: param.product);
    return result.fold(
      (l) => Left(
        AddProductFailure(),
      ),
      (r) => Right(Product.fromModel(r)),
    );
  }
}

class DoAddProductParams {
  DoAddProductParams({required this.product});

  final Product product;
}
