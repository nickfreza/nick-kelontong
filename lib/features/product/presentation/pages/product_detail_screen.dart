import 'package:brik_test/core/utils/snackbar.dart';
import 'package:brik_test/core/widgets/delete_button.dart';
import 'package:brik_test/core/widgets/primary_text_field.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({required this.product, super.key});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late TextEditingController idController;
  late TextEditingController categoryIdController;
  late TextEditingController categoryNameController;
  late TextEditingController skuController;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController weightController;
  late TextEditingController widthController;
  late TextEditingController lengthController;
  late TextEditingController heightController;
  late TextEditingController imageController;
  late TextEditingController priceController;

  @override
  void initState() {
    idController = TextEditingController(text: '');
    categoryIdController = TextEditingController(text: '');
    categoryNameController = TextEditingController(text: '');
    skuController = TextEditingController(text: '');
    nameController = TextEditingController(text: '');
    descriptionController = TextEditingController(text: '');
    weightController = TextEditingController(text: '');
    widthController = TextEditingController(text: '');
    lengthController = TextEditingController(text: '');
    heightController = TextEditingController(text: '');
    imageController = TextEditingController(text: '');
    priceController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductSavedState || state is ProductDeletedState) {
          showSuccessToast(
              context, state is ProductDeletedState ? 'Product has been deleted' : 'Product saved successfully');
          _handleBack(context);
        } else if (state is ProductSaveFailed) {
          showFailedToast(context, 'Product saved failed');
        }
      },
      builder: (context, state) {
        _setData(state);
        final isEnabled = state is! ProductViewState;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Detail'),
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => _handleBack(context),
            ),
            actions: [
              if (state is ProductLoading) const CircularProgressIndicator(),
              if (state is ProductViewState ||
                  state is ProductEditState ||
                  state is ProductAddState ||
                  state is ProductSaveFailed)
                IconButton(
                  icon: Icon(
                    state is ProductViewState ? Icons.edit : Icons.save,
                  ),
                  onPressed: () {
                    if (state is ProductViewState) {
                      context.read<ProductBloc>().add(
                            EditProductEvent(
                              selectedProduct: state.selectedProduct,
                            ),
                          );
                    } else if (state is ProductEditState || state is ProductAddState || state is ProductSaveFailed) {
                      context.read<ProductBloc>().add(
                            SaveProductEvent(
                              selectedProduct: updatedProduct,
                            ),
                          );
                    }
                  },
                ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (widget.product.image.isNotEmpty)
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(widget.product.image),
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                  ),
                const SizedBox(height: 14),
                if (state is! ProductAddState && state is! ProductSaveFailed)
                  PrimaryTextField(
                    label: 'ID',
                    textEditingController: idController,
                    enabled: state is ProductAddState || false,
                  ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'Category ID',
                  textEditingController: categoryIdController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'Category Name',
                  textEditingController: categoryNameController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'Name',
                  textEditingController: nameController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'Description',
                  textEditingController: descriptionController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'sku',
                  textEditingController: skuController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'Weight',
                  textEditingController: weightController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'Length',
                  textEditingController: lengthController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'Width',
                  textEditingController: widthController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'Height',
                  textEditingController: heightController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'Image',
                  textEditingController: imageController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 14),
                PrimaryTextField(
                  label: 'Price',
                  textEditingController: priceController,
                  enabled: isEnabled,
                ),
                const SizedBox(height: 25),
                if (state is ProductViewState)
                  DeleteButton(
                    onDelete: () => _handleDelete(
                      context,
                      state.selectedProduct,
                    ),
                  ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
    );
  }

  Product get updatedProduct {
    return Product(
      id: idController.text,
      categoryId: int.parse(categoryIdController.text),
      categoryName: categoryNameController.text,
      sku: skuController.text,
      name: nameController.text,
      description: descriptionController.text,
      weight: int.parse(weightController.text),
      width: int.parse(widthController.text),
      length: int.parse(lengthController.text),
      height: int.parse(heightController.text),
      image: imageController.text,
      price: int.parse(priceController.text),
    );
  }

  void _handleDelete(BuildContext context, Product product) {
    context.read<ProductBloc>().add(
          DeleteProductEvent(selectedProduct: product),
        );
  }

  void _handleBack(BuildContext context) {
    context.read<ProductBloc>().add(const GetProductEvent());
    Navigator.pop(context);
  }

  void _setData(ProductState state) {
    idController = TextEditingController(
      text: state.selectedProduct.id,
    );
    categoryIdController = TextEditingController(
      text: '${state.selectedProduct.categoryId}',
    );
    categoryNameController = TextEditingController(
      text: state.selectedProduct.categoryName,
    );
    skuController = TextEditingController(
      text: state.selectedProduct.sku,
    );
    nameController = TextEditingController(
      text: state.selectedProduct.name,
    );
    descriptionController = TextEditingController(
      text: state.selectedProduct.description,
    );
    weightController = TextEditingController(
      text: '${state.selectedProduct.weight}',
    );
    widthController = TextEditingController(
      text: '${state.selectedProduct.width}',
    );
    lengthController = TextEditingController(
      text: '${state.selectedProduct.length}',
    );
    heightController = TextEditingController(
      text: '${state.selectedProduct.height}',
    );
    imageController = TextEditingController(
      text: state.selectedProduct.image,
    );
    priceController = TextEditingController(
      text: '${state.selectedProduct.price}',
    );
  }
}
