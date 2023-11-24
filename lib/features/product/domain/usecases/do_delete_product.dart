import 'package:brik_test/core/error/failures.dart';
import 'package:brik_test/core/utils/usecase.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class DoDeleteProduct extends UseCase<bool, DoDeleteProductParams> {
  DoDeleteProduct({required this.repository});
  final ProductRepository repository;

  @override
  Future<Either<Failure, bool>> call(DoDeleteProductParams param) async {
    final result = await repository.deleteProduct(product: param.product);
    return result.fold(
      (l) => Left(
        AddProductFailure(),
      ),
      (r) => Right(r),
    );
  }
}

class DoDeleteProductParams {
  DoDeleteProductParams({required this.product});

  final Product product;
}
