import 'package:brik_test/core/constans/enum.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpClientHelper {
  HttpClientHelper();

  Future<Either<DioException, Response<dynamic>>> urlRequest({
    required String url,
    required HttpMethod method,
    required Map<String, dynamic> requestParam,
  }) async {
    final stringUrl = '${dotenv.env['API_URL']}$url';

    switch (method) {
      case HttpMethod.post:
        try {
          final response = await Dio().post<dynamic>(
            stringUrl,
            data: requestParam,
            options: Options(
              headers: _setHeaders(),
            ),
          );
          return Right(response);
        } on DioException catch (e) {
          return Left(e);
        }
      case HttpMethod.get:
        try {
          final response = await Dio().get<dynamic>(
            stringUrl,
            options: Options(
              headers: _setHeaders(),
            ),
          );
          return Right(response);
        } on DioException catch (e) {
          return Left(e);
        }
      case HttpMethod.put:
        try {
          final response = await Dio().put<dynamic>(
            stringUrl,
            data: requestParam,
            options: Options(
              headers: _setHeaders(),
            ),
          );
          return Right(response);
        } on DioException catch (e) {
          return Left(e);
        }
      case HttpMethod.delete:
        try {
          final response = await Dio().delete<dynamic>(
            stringUrl,
            queryParameters: requestParam,
            options: Options(
              headers: _setHeaders(),
            ),
          );
          return Right(response);
        } on DioException catch (e) {
          return Left(e);
        }
    }
  }

  Map<String, String> _setHeaders() {
    return {
      'content-type': 'application/json',
    };
  }
}
