import 'package:brik_test/features/product/domain/entities/product.dart';
import 'package:brik_test/features/product/presentation/widgets/product_item_trait.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    required this.product,
    required this.onSelectProduct,
    super.key,
  });

  final Product product;
  final void Function(Product product) onSelectProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => onSelectProduct(product),
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(product.image),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      product.description,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProductItemTrait(
                          icon: Icons.line_weight,
                          label: '${product.weight}',
                        ),
                        const SizedBox(width: 12),
                        ProductItemTrait(
                          icon: Icons.width_normal,
                          label: '${product.width}',
                        ),
                        const SizedBox(width: 12),
                        ProductItemTrait(
                          icon: Icons.space_bar,
                          label: '${product.length}',
                        ),
                        const SizedBox(width: 12),
                        ProductItemTrait(
                          icon: Icons.height,
                          label: '${product.height}',
                        ),
                        const SizedBox(width: 12),
                        ProductItemTrait(
                          icon: Icons.money,
                          label: '${product.price}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
