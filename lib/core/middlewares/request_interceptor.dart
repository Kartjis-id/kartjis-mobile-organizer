// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:http_interceptor/http_interceptor.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/connections/network_info.dart';
import 'package:kartjis_mobile_organizer/core/errors/exception.dart';
import 'package:kartjis_mobile_organizer/core/helpers/credential_saver.dart';
import 'package:kartjis_mobile_organizer/core/utils/const.dart';

class RequestInterceptor implements InterceptorContract {
  final NetworkInfo networkInfo;

  const RequestInterceptor({required this.networkInfo});

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    try {
      if (await networkInfo.isConnected) {
        final path = request.url.path;

        var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

        if (path != '/api/auth/token') {
          headers[HttpHeaders.authorizationHeader] = 'Bearer ${CredentialSaver.token?.accessToken}';
        }

        request.headers.addAll(headers);
      } else {
        throw ConnectionException(kNoInternetConnection);
      }
    } catch (_) {
      rethrow;
    }

    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) => response;

  @override
  FutureOr<bool> shouldInterceptRequest() => true;

  @override
  FutureOr<bool> shouldInterceptResponse() => false;
}
