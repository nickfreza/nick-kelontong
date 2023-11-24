import 'package:brik_test/core/error/failures.dart';
import 'package:brik_test/core/utils/usecase.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class DoUpdateProduct extends UseCase<bool, DoUpdateProductParams> {
  DoUpdateProduct({required this.repository});
  final ProductRepository repository;

  @override
  Future<Either<Failure, bool>> call(DoUpdateProductParams param) async {
    final result = await repository.updateProduct(product: param.product);
    return result.fold(
      (l) => Left(
        AddProductFailure(),
      ),
      (r) => Right(r),
    );
  }
}

class DoUpdateProductParams {
  DoUpdateProductParams({required this.product});

  final Product product;
}
