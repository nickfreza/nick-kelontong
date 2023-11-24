import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brik_test/features/product/data/datasources/dummy_product.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/domain/usecases/do_add_product.dart';
import 'package:brik_test/features/product/domain/usecases/do_delete_product.dart';
import 'package:brik_test/features/product/domain/usecases/do_get_product.dart';
import 'package:brik_test/features/product/domain/usecases/do_update_product.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required this.doGetProduct,
    required this.doAddProduct,
    required this.doUpdateProduct,
    required this.doDeleteProduct,
  }) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {});
    on<GetProductEvent>(_onGetProductEvent);
    on<AddProductEvent>(_onAddProductEvent);
    on<ViewProductEvent>(_onViewProductEvent);
    on<EditProductEvent>(_onEditProductEvent);
    on<ChangeProductEvent>(_onChangeProductEvent);
    on<SaveProductEvent>(_onSaveProductEvent);
    on<DeleteProductEvent>(_onDeleteProductEvent);
    on<SearchProductEvent>(_onSearchProductEvent);
    on<LoadMoreDataEvent>(_onLoadMoreDataEvent);
  }

  DoGetProduct doGetProduct;
  DoAddProduct doAddProduct;
  DoUpdateProduct doUpdateProduct;
  DoDeleteProduct doDeleteProduct;

  FutureOr<void> _onGetProductEvent(
    GetProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading(state));

    final result = await doGetProduct();

    result.fold(
      (l) => emit(ProductFetchFailed(state)),
      (r) => emit(ProductLoaded(state.copyWith(products: r))),
    );
  }

  FutureOr<void> _onLoadMoreDataEvent(
    LoadMoreDataEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductMoreDataLoading(state));

    emit(
      ProductLoaded(
        state.copyWith(
          products: [...state.products, ...dummyProduct],
        ),
      ),
    );

    // final result = await doGetProduct();

    // result.fold(
    //   (l) => emit(ProductFetchFailed(state)),
    //   (r) => emit(ProductLoaded(state.copyWith(products: r))),
    // );
  }

  FutureOr<void> _onAddProductEvent(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(
      ProductAddState(
        state.copyWith(
          selectedProduct: const Product.empty(),
        ),
      ),
    );
  }

  FutureOr<void> _onViewProductEvent(
    ViewProductEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(
      ProductViewState(
        state.copyWith(
          selectedProduct: event.selectedProduct,
        ),
      ),
    );
  }

  FutureOr<void> _onEditProductEvent(
    EditProductEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(
      ProductEditState(
        state.copyWith(
          selectedProduct: event.selectedProduct,
        ),
      ),
    );
  }

  FutureOr<void> _onChangeProductEvent(
    ChangeProductEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(
      ProductEditState(
        state.copyWith(
          selectedProduct: event.selectedProduct,
        ),
      ),
    );
  }

  FutureOr<void> _onSaveProductEvent(
    SaveProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading(state));

    if (event.selectedProduct.id.isEmpty) {
      final result = await doAddProduct(
        DoAddProductParams(product: event.selectedProduct),
      );
      result.fold(
        (l) => emit(ProductSaveFailed(state)),
        (r) => emit(
          ProductSavedState(
            state.copyWith(
              selectedProduct: event.selectedProduct,
            ),
          ),
        ),
      );
    } else {
      final result = await doUpdateProduct(
        DoUpdateProductParams(product: event.selectedProduct),
      );
      result.fold(
        (l) => emit(ProductSaveFailed(state)),
        (r) => {
          emit(
            ProductSavedState(
              state.copyWith(
                selectedProduct: event.selectedProduct,
              ),
            ),
          ),
          add(const GetProductEvent()),
        },
      );
    }
  }

  FutureOr<void> _onDeleteProductEvent(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading(state));

    final result = await doDeleteProduct(
      DoDeleteProductParams(product: event.selectedProduct),
    );

    result.fold(
      (l) => emit(ProductDeletedFailed(state)),
      (r) => {
        emit(
          ProductDeletedState(
            state.copyWith(
              selectedProduct: event.selectedProduct,
            ),
          ),
        ),
        add(const GetProductEvent()),
      },
    );
  }

  FutureOr<void> _onSearchProductEvent(
    SearchProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading(state));

    var products = <Product>[];
    final result = await doGetProduct();
    // ignore: inference_failure_on_collection_literal
    result.fold((l) => {}, (r) => products = r);

    final searchResults = products
        .where(
          (product) => product.name.toLowerCase().contains(
                event.searchText.toLowerCase(),
              ),
        )
        .toList();

    emit(
      ProductLoaded(
        state.copyWith(
          products: searchResults,
        ),
      ),
    );
  }
}
