part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductEvent extends ProductEvent {
  const GetProductEvent();
}

class AddProductEvent extends ProductEvent {
  const AddProductEvent();
}

class ViewProductEvent extends ProductEvent {
  const ViewProductEvent({required this.selectedProduct});

  final Product selectedProduct;

  @override
  List<Object> get props => [selectedProduct];
}

class EditProductEvent extends ProductEvent {
  const EditProductEvent({required this.selectedProduct});

  final Product selectedProduct;

  @override
  List<Object> get props => [selectedProduct];
}

class ChangeProductEvent extends ProductEvent {
  const ChangeProductEvent({required this.selectedProduct});

  final Product selectedProduct;

  @override
  List<Object> get props => [selectedProduct];
}

class SaveProductEvent extends ProductEvent {
  const SaveProductEvent({required this.selectedProduct});

  final Product selectedProduct;

  @override
  List<Object> get props => [selectedProduct];
}

class DeleteProductEvent extends ProductEvent {
  const DeleteProductEvent({required this.selectedProduct});

  final Product selectedProduct;

  @override
  List<Object> get props => [selectedProduct];
}

class SearchProductEvent extends ProductEvent {
  const SearchProductEvent({required this.searchText});

  final String searchText;

  @override
  List<Object> get props => [searchText];
}

class LoadMoreDataEvent extends ProductEvent {
  const LoadMoreDataEvent();
}
