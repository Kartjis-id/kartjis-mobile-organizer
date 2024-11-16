// Package imports:
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/errors/exceptions.dart';
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

class PreferencesFailure extends Failure {
  const PreferencesFailure(super.message);
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
      case kUnauthorized:
        return const ServerFailure('Token atau header otorisasi tidak ditemukan');
      case kUserNotFound:
        return const ServerFailure('Akun belum terdaftar');
      default:
        return ServerFailure(e.message);
    }
  } else if (e is PreferencesException) {
    return PreferencesFailure(e.message);
  } else {
    return ClientFailure((e as ClientException).message);
  }
}
