import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductEvent', () {
    test('GetProductEvent props are correct', () {
      expect(
        GetProductEvent(),
        equals(GetProductEvent()),
      );
    });

    test('AddProductEvent props are correct', () {
      expect(
        AddProductEvent(),
        equals(AddProductEvent()),
      );
    });

    test('ViewProductEvent props are correct', () {
      expect(
        ViewProductEvent(selectedProduct: Product.empty()),
        equals(ViewProductEvent(selectedProduct: Product.empty())),
      );
    });

    test('EditProductEvent props are correct', () {
      expect(
        EditProductEvent(selectedProduct: Product.empty()),
        equals(EditProductEvent(selectedProduct: Product.empty())),
      );
    });

    test('ChangeProductEvent props are correct', () {
      expect(
        ChangeProductEvent(selectedProduct: Product.empty()),
        equals(ChangeProductEvent(selectedProduct: Product.empty())),
      );
    });

    test('SaveProductEvent props are correct', () {
      expect(
        SaveProductEvent(selectedProduct: Product.empty()),
        equals(SaveProductEvent(selectedProduct: Product.empty())),
      );
    });

    test('DeleteProductEvent props are correct', () {
      expect(
        DeleteProductEvent(selectedProduct: Product.empty()),
        equals(DeleteProductEvent(selectedProduct: Product.empty())),
      );
    });

    test('SearchProductEvent props are correct', () {
      expect(
        SearchProductEvent(searchText: 'test'),
        equals(SearchProductEvent(searchText: 'test')),
      );
    });

    test('LoadMoreDataEvent props are correct', () {
      expect(
        LoadMoreDataEvent(),
        equals(LoadMoreDataEvent()),
      );
    });
  });
}
