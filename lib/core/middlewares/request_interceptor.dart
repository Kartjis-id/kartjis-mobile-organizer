// Dart imports:
import 'dart:async';

// Package imports:
import 'package:http_interceptor/http_interceptor.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/connections/network_info.dart';
import 'package:kartjis_mobile_organizer/core/errors/exception.dart';
import 'package:kartjis_mobile_organizer/core/helpers/auth_token_saver.dart';
import 'package:kartjis_mobile_organizer/core/utils/const.dart';

class RequestInterceptor implements InterceptorContract {
  final NetworkInfo networkInfo;

  const RequestInterceptor({required this.networkInfo});

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (await networkInfo.isConnected) {
      final headers = {'content-type': 'application/json'};

      if (request.url.path != '/api/auth/token') {
        headers['authorization'] = 'Bearer ${AuthTokenSaver.token?.accessToken}';
      }

      request.headers.addAll(headers);
    } else {
      throw ConnectionException(kNoInternetConnection);
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
