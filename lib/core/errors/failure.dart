// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/errors/exception.dart';
import 'package:kartjis_mobile_organizer/core/utils/const.dart';

sealed class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ClientFailure extends Failure {
  const ClientFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

Failure failure(Exception e) {
  if (e is ServerException) {
    switch (e.message) {
      case kUserNotFound:
        return const ServerFailure('Account not registered yet');
      case kInvalidPassword:
        return const ServerFailure('Invalid password');
      default:
        return ServerFailure(kDebugMode ? e.message : 'Server error');
    }
  } else if (e is ConnectionException) {
    return ConnectionFailure(e.message);
  } else {
    return ClientFailure(kDebugMode ? '$e' : 'Client error');
  }
}
