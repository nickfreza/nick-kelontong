import 'package:brik_test/core/utils/http_client_helper.dart';
import 'package:brik_test/core/utils/network_info.dart';
import 'package:brik_test/features/product/data/datasources/product_data_source.dart';
import 'package:brik_test/features/product/data/repositories/product_repository_impl.dart';
import 'package:brik_test/features/product/domain/repositories/product_repository.dart';
import 'package:brik_test/features/product/domain/usecases/do_add_product.dart';
import 'package:brik_test/features/product/domain/usecases/do_delete_product.dart';
import 'package:brik_test/features/product/domain/usecases/do_get_product.dart';
import 'package:brik_test/features/product/domain/usecases/do_update_product.dart';
import 'package:brik_test/features/product/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory<ProductBloc>(
      () => ProductBloc(
        doGetProduct: sl(),
        doAddProduct: sl(),
        doUpdateProduct: sl(),
        doDeleteProduct: sl(),
      ),
    )
    // Usecases
    ..registerLazySingleton(
      () => DoGetProduct(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => DoAddProduct(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => DoUpdateProduct(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => DoDeleteProduct(
        repository: sl(),
      ),
    )
    // Repository
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        datasource: sl(),
        networkInfo: sl(),
      ),
    )
    // Datasources
    ..registerLazySingleton<ProductDatasource>(
      () => ProductDatasourceImpl(httpClientHelper: sl()),
    )
    // Core
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton<HttpClientHelper>(HttpClientHelper.new)
    ..registerLazySingleton(InternetConnectionChecker.new);
}
