import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductState', () {
    const mockProducts = [Product.empty()];
    const mockSelectedProduct = Product.empty();
    const mockUpdateProduct = Product(
        id: "id",
        categoryId: 1,
        categoryName: 'categoryName',
        sku: 'sku',
        name: 'name',
        description: 'description',
        weight: 1,
        width: 1,
        length: 1,
        height: 1,
        image: 'image',
        price: 1);

    ProductState createSubject() {
      return const ProductState(
        products: mockProducts,
        selectedProduct: mockSelectedProduct,
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals(<Object?>[mockProducts, mockSelectedProduct]),
      );
    });

    test('return object with update value', () {
      expect(
        createSubject().copyWith(selectedProduct: mockUpdateProduct),
        const ProductState(products: mockProducts, selectedProduct: mockUpdateProduct),
      );
    });
  });
}
