import 'package:bloc_test/bloc_test.dart';
import 'package:brik_test/features/product/data/datasources/dummy_product.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/domain/usecases/do_add_product.dart';
import 'package:brik_test/features/product/domain/usecases/do_delete_product.dart';
import 'package:brik_test/features/product/domain/usecases/do_get_product.dart';
import 'package:brik_test/features/product/domain/usecases/do_update_product.dart';
import 'package:brik_test/features/product/presentation/bloc/product_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDoGetProduct extends Mock implements DoGetProduct {}

class MockDoAddProduct extends Mock implements DoAddProduct {}

class MockDoUpdateProduct extends Mock implements DoUpdateProduct {}

class MockDoDeleteProduct extends Mock implements DoDeleteProduct {}

void main() {
  group('ProductBloc', () {
    late MockDoGetProduct mockDoGetProduct;
    late MockDoAddProduct mockDoAddProduct;
    late MockDoUpdateProduct mockDoUpdateProduct;
    late MockDoDeleteProduct mockDoDeleteProduct;

    setUp(() {
      mockDoGetProduct = MockDoGetProduct();
      mockDoAddProduct = MockDoAddProduct();
      mockDoUpdateProduct = MockDoUpdateProduct();
      mockDoDeleteProduct = MockDoDeleteProduct();
    });

    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductLoaded] when GetProductEvent is added successfully',
      build: () => ProductBloc(
        doGetProduct: mockDoGetProduct,
        doAddProduct: mockDoAddProduct,
        doUpdateProduct: mockDoUpdateProduct,
        doDeleteProduct: mockDoDeleteProduct,
      ),
      act: (bloc) => {
        when(mockDoGetProduct).thenAnswer((_) async => Right(dummyProduct)),
        bloc.add(GetProductEvent()),
      },
      expect: () => [
        ProductLoading(ProductState(products: [], selectedProduct: Product.empty())),
        ProductLoaded(ProductState(products: dummyProduct, selectedProduct: Product.empty())),
      ],
    );
  });
}
