// ignore_for_file: type_literal_in_constant_pattern

import 'dart:async';
import 'dart:io';
import 'package:bookshelf/domain/error/api_failure.dart';
import 'package:bookshelf/domain/error/exception.dart';

import 'package:flutter/services.dart';

class FailureHandler {
  static ApiFailure handleFailure(Object error) {
    switch (error.runtimeType) {
      case CacheException:
        return ApiFailure.other((error as CacheException).message);
      case ServerException:
        final message = (error as ServerException).message;
        return ApiFailure.serverError(message);
      case SocketException:
        return const ApiFailure.poorConnection();
      case TimeoutException:
        return const ApiFailure.serverTimeout();
      case PlatformException:
        return ApiFailure.other('${(error as PlatformException).message}');
      case OtherException:
        return ApiFailure.other((error as OtherException).message);

      default:
        return ApiFailure.other(error.toString());
    }
  }
}
