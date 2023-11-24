import 'package:brik_test/core/constans/enum.dart';
import 'package:brik_test/core/error/exception.dart';
import 'package:brik_test/core/utils/http_client_helper.dart';
import 'package:brik_test/features/product/data/models/product_model.dart';
import 'package:brik_test/features/product/domain/entities/product.dart';

abstract class ProductDatasource {
  Future<List<ProductModel>> getProduct();

  Future<ProductModel> addProduct({required Product product});

  Future<bool> updateProduct({required Product product});

  Future<bool> deleteProduct({required Product product});
}

class ProductDatasourceImpl implements ProductDatasource {
  ProductDatasourceImpl({required this.httpClientHelper});

  final HttpClientHelper httpClientHelper;

  @override
  Future<List<ProductModel>> getProduct() async {
    try {
      final response = await httpClientHelper.urlRequest(
        url: '/products',
        method: HttpMethod.get,
        requestParam: {},
      );
      var products = <ProductModel>[];

      response.fold((l) {
        throw ServerException();
      }, (r) {
        final datas = r.data as List<dynamic>;
        products = datas
            .map<ProductModel>(
              (entity) => ProductModel.fromJson(entity as Map<String, dynamic>),
            )
            .toList();
      });

      return products;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> addProduct({required Product product}) async {
    try {
      final response = await httpClientHelper.urlRequest(
        url: '/products',
        method: HttpMethod.post,
        requestParam: {
          'categoryId': product.categoryId,
          'categoryName': product.categoryName,
          'sku': product.sku,
          'name': product.name,
          'description': product.description,
          'weight': product.weight,
          'length': product.length,
          'width': product.width,
          'height': product.height,
          'image': product.image,
          'price': product.price,
        },
      );

      var productModel = const ProductModel.empty();

      response.fold((l) {
        throw ServerException();
      }, (r) {
        final data = r.data as Map<String, dynamic>;
        productModel = ProductModel.fromJson(data);
      });

      return productModel;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateProduct({required Product product}) async {
    try {
      final response = await httpClientHelper.urlRequest(
        url: '/products/${product.id}',
        method: HttpMethod.put,
        requestParam: {
          'categoryId': product.categoryId,
          'categoryName': product.categoryName,
          'sku': product.sku,
          'name': product.name,
          'description': product.description,
          'weight': product.weight,
          'length': product.length,
          'width': product.width,
          'height': product.height,
          'image': product.image,
          'price': product.price,
        },
      );

      response.fold(
        (l) {
          throw ServerException();
        },
        (r) {},
      );

      return true;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteProduct({required Product product}) async {
    try {
      final response = await httpClientHelper.urlRequest(
        url: '/products/${product.id}',
        method: HttpMethod.delete,
        requestParam: {},
      );

      response.fold(
        (l) {
          throw ServerException();
        },
        (r) {},
      );

      return true;
    } catch (e) {
      throw ServerException();
    }
  }
}
