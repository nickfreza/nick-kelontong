import 'package:brik_test/core/utils/snackbar.dart';
import 'package:brik_test/core/widgets/empty_data.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/presentation/bloc/product_bloc.dart';
import 'package:brik_test/features/product/presentation/pages/product_detail_screen.dart';
import 'package:brik_test/features/product/presentation/widgets/product_item.dart';
import 'package:brik_test/features/product/presentation/widgets/search_input_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    required this.onChangeDarkMode,
    super.key,
  });

  final void Function() onChangeDarkMode;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _onRefresh();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (!_isLoading) {
          _loadMoreData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kelontong',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: textColor,
              ),
        ),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductInitial) {
            _onRefresh();
          } else if (state is ProductViewState || state is ProductAddState) {
            _selectedProduct(
              context,
              state.selectedProduct,
            );
          } else if (state is ProductLoaded) {
            setState(() {
              _isLoading = false;
            });
          } else if (state is ProductFetchFailed) {
            showFailedToast(context, 'Failed Load Data');
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state is ProductLoading)
                const Center(child: CircularProgressIndicator())
              else if (state.products.isNotEmpty)
                ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: state.products.length + (_isLoading ? 1 : 0),
                  itemBuilder: (ctx, index) {
                    if (index < state.products.length) {
                      return ProductItem(
                        product: state.products[index],
                        onSelectProduct: (product) {
                          context.read<ProductBloc>().add(
                                ViewProductEvent(selectedProduct: product),
                              );
                        },
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                )
              else
                const EmptyData(),
              Positioned(
                top: 5,
                right: 0,
                left: 0,
                child: SearchInputBar(
                  isDark: Theme.of(context).brightness == Brightness.dark,
                  onChangeDarkMode: widget.onChangeDarkMode,
                  onChangeSearch: (value) => {
                    context.read<ProductBloc>().add(
                          SearchProductEvent(searchText: value),
                        ),
                  },
                ),
              ),
              Positioned(
                bottom: 30,
                right: 30,
                child: FloatingActionButton(
                  elevation: 2,
                  highlightElevation: 2,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  foregroundColor: textColor,
                  backgroundColor: colorScheme.surface,
                  onPressed: () => _handleAddProduct(context),
                  child: const Icon(Icons.add, size: 32),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Color get textColor {
    return Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  Future<void> _loadMoreData() async {
    context.read<ProductBloc>().add(const LoadMoreDataEvent());
    setState(() {
      _isLoading = true;
    });
  }

  Future<void> _onRefresh() async {
    context.read<ProductBloc>().add(const GetProductEvent());
  }

  void _handleAddProduct(BuildContext context) {
    context.read<ProductBloc>().add(const AddProductEvent());
  }

  void _selectedProduct(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return ProductDetailScreen(
            product: product,
          );
        },
      ),
    );
  }
}
