// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/error/exception.dart';
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

  if (e is ServerException) {
    return ServerFailure(e.message);
  }

  if (e is ClientException) {
    switch (e.message) {
      case kUserNotFound:
        return const ClientFailure('Account not registered yet');
      case kInvalidPassword:
        return const ClientFailure('Invalid password');
      default:
        return ClientFailure(e.message);
    }
  }

  return UnknownFailure('$e');
}
