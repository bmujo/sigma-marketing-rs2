import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../config/constants.dart';
import '../../../config/strings.dart';
import '../../network/result.dart';

typedef EntityMapper<Entity, Model> = Model Function(Entity entity);

abstract class ErrorCode {
  static const error = "Error";
  static const failed = "Failed";
  static const message = "message";
  static const unauthorized = "unauthorized";
}

abstract class BaseRepository {
  final String endpoint = AppConstants.baseUrl;

  final Map<String, String> _headers = {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
  };

  final _logger = Logger();

  Dio get dio => Dio()..options.headers = _headers;

  Future<Result<ResponseType>> safeCall<RequestType, ResponseType>(
      Future<RequestType> call,
      {required EntityMapper<RequestType, ResponseType> entityMapper}) async {
    try {
      var response = await call;
      _logger.d("Api success message -> $response");
      return Success(entityMapper != null
          ? entityMapper(response)
          : response as ResponseType);
    } catch (exception) {
      _logger.e(exception);
      if (exception is DioError) {
        switch (exception.type) {
          case DioErrorType.connectionTimeout:
          case DioErrorType.sendTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.cancel:
            _logger.e("Api error message -> ${AppStrings.poorNetworkError}");
            return Error(AppStrings.poorNetworkError);
          case DioErrorType.unknown:
            _logger.e("Api error message -> ${AppStrings.noNetworkError}");
            return Error(AppStrings.noNetworkError);
          case DioErrorType.badResponse:
            return _getError(exception.response!);
          case DioErrorType.badCertificate:
            _logger.e("Api error message -> ${AppStrings.genericError}");
            break;
          case DioErrorType.connectionError:
            _logger.e("Api error message -> ${AppStrings.poorNetworkError}");
            return Error(AppStrings.poorNetworkError);
        }
      }
      return Error(AppStrings.genericError);
    }
  }

  Result<T> _getError<T>(Response response) {
    if (response.data != null && response.data is Map<String, dynamic>) {
      if ((response.data as Map<String, dynamic>)
          .containsKey(ErrorCode.message)) {
        _logger.e("Api error response -> ${response.data.toString()}");
        final errorMessage = response.data[ErrorCode.message];
        return Error(errorMessage);
      }
    }
    return Error(
      AppStrings.genericError,
    );
  }
}
