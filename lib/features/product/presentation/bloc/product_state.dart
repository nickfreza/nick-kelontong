part of 'product_bloc.dart';

class ProductState extends Equatable {
  const ProductState({required this.products, required this.selectedProduct});

  final List<Product> products;
  final Product selectedProduct;

  @override
  List<Object> get props => [products, selectedProduct];

  ProductState copyWith({
    List<Product>? products,
    Product? selectedProduct,
  }) {
    return ProductState(
      products: products ?? this.products,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }
}

class ProductInitial extends ProductState {
  ProductInitial()
      : super(
          products: [],
          selectedProduct: const Product.empty(),
        );
}

class ProductLoading extends ProductState {
  ProductLoading(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductMoreDataLoading extends ProductState {
  ProductMoreDataLoading(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductLoaded extends ProductState {
  ProductLoaded(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductViewState extends ProductState {
  ProductViewState(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductEditState extends ProductState {
  ProductEditState(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductSavedState extends ProductState {
  ProductSavedState(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductDeletedState extends ProductState {
  ProductDeletedState(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductAddState extends ProductState {
  ProductAddState(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductFetchFailed extends ProductState {
  ProductFetchFailed(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductAddFailed extends ProductState {
  ProductAddFailed(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductSaveFailed extends ProductState {
  ProductSaveFailed(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}

class ProductDeletedFailed extends ProductState {
  ProductDeletedFailed(ProductState state)
      : super(
          products: state.products,
          selectedProduct: state.selectedProduct,
        );
}
