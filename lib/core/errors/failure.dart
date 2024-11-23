// Package imports:
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/errors/exception.dart';
import 'package:kartjis_mobile_organizer/core/utils/const.dart';

sealed class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class ClientFailure extends Failure {
  const ClientFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

Failure failure(Object e) {
  if (e is ConnectionException) {
    return ConnectionFailure(e.message);
  }

  if (e is ClientException) {
    return ClientFailure(e.message);
  }

  if (e is ServerException) {
    switch (e.message) {
      case kUserNotFound:
        return const ServerFailure('Account not registered yet');
      case kInvalidPassword:
        return const ServerFailure('Invalid password');
      default:
        return ServerFailure(e.message);
    }
  }

  return UnknownFailure('$e');
}
