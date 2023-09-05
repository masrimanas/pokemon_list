import 'package:dio/dio.dart';
import 'package:pokemon_list/src/common/constants.dart';
import 'package:pokemon_list/src/utils/http_client/http_exceptions.dart';
import 'package:pokemon_list/src/utils/http_client/network_response.dart';
import 'package:pokemon_list/src/utils/utils.dart'
    show
        BadRequestException,
        ConflictException,
        InternalServerErrorException,
        NoInternetConnectionException,
        NotFoundException,
        TimeOutException,
        UnauthorizedException,
        logger;

// ignore: constant_identifier_names
enum RequestType { GET, POST, PUT, PATCH, DELETE }

class HttpClient {
  HttpClient() {
    _dio = createDio();
  }

  late final Dio _dio;

  Dio createDio() {
    final dio = Dio(
      BaseOptions(
        // ignore: avoid_redundant_argument_values
        baseUrl: kBaseUrl,
        receiveTimeout: const Duration(seconds: 120),
        connectTimeout: const Duration(seconds: 120),
        sendTimeout: const Duration(seconds: 120),
      ),
    );

    dio.interceptors.addAll({
      ErrorInterceptors(dio),
    });

    return dio;
  }

  Future<NetworkResponse<dynamic, Exception>?> call<T>({
    required String url,
    required RequestType requestType,
    Map<String, dynamic>? queryParameters,
    T? body,
    Map<String, dynamic>? header,
  }) async {
    late Response<dynamic> result;
    try {
      switch (requestType) {
        case RequestType.GET:
          {
            final options = Options(headers: header ?? _header);
            result = await _dio.get(
              url,
              queryParameters: queryParameters,
              options: options,
            );
            break;
          }
        case RequestType.POST:
          {
            final options = Options(headers: header ?? _header);
            result = await _dio.post(url, data: body, options: options);
            break;
          }
        case RequestType.DELETE:
          {
            final options = Options(headers: header ?? _header);
            result =
                await _dio.delete(url, data: queryParameters, options: options);
            break;
          }
        case RequestType.PUT:
          {
            final options = Options(headers: header ?? _header);
            result = await _dio.put(url, data: body, options: options);
            break;
          }
        case RequestType.PATCH:
          {
            final options = Options(headers: header ?? _header);
            result = await _dio.patch(url, data: body, options: options);
            break;
          }
      }

      if (result.statusCode == 204) {
        throw Exception('Data tidak ditemukan');
      }

      // ignore: unnecessary_null_comparison
      if (result != null) {
        if (result.data is List<dynamic>) {
          return ResponseSuccess(
            result.data as List<dynamic>,
          );
        }
        return ResponseSuccess(result.data as Map<String, dynamic>?);
      } else {
        return ResponseFailure(
          DioException(requestOptions: result.requestOptions),
        );
      }
    } on Exception catch (e) {
      return ResponseFailure(e);
    }
  }
}

class ErrorInterceptors extends Interceptor {
  ErrorInterceptors(this.dio);
  final Dio dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeOutException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
        throw BadCertificateException(err.requestOptions);
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}

class Logging extends Interceptor {
  Logging(this.dio);
  final Dio dio;
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    logger(
      // ignore: lines_longer_than_80_chars
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}

final Map<String, String> _header = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
  'client-secret': 'no-secret',
  'client-id': 'pokemon_list',
  'package-name': 'com.masrimanas.pokemon_list',
  'platform': 'android/ios',
  'Authorization': 'access_token',
};
