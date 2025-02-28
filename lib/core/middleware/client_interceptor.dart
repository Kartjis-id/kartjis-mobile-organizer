// Dart imports:
import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:http_interceptor/http_interceptor.dart' hide ClientException;

// Project imports:
import 'package:kartjis_mobile_organizer/core/connection/network_info.dart';
import 'package:kartjis_mobile_organizer/core/error/exception.dart';
import 'package:kartjis_mobile_organizer/core/helper/auth_token_saver.dart';
import 'package:kartjis_mobile_organizer/core/utils/const.dart';

class ClientInterceptor implements InterceptorContract {
  final NetworkInfo networkInfo;

  const ClientInterceptor({required this.networkInfo});

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (!await networkInfo.isConnected) {
      throw const ConnectionException(kNoInternetConnection);
    }

    final headers = {
      'content-type': 'application/json',
    };

    if (request.url.path != '/api/auth/token') {
      headers['authorization'] = 'Bearer ${AuthTokenSaver.token?.accessToken}';
    }

    request.headers.addAll(headers);

    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    if (response is Response) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;

      switch (response.statusCode) {
        case >= 400 && <= 499:
          throw ClientException("${result['message']}");
        case >= 500 && <= 599:
          throw ServerException("${result['message']}");
      }
    }

    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() => true;

  @override
  FutureOr<bool> shouldInterceptResponse() => true;
}
