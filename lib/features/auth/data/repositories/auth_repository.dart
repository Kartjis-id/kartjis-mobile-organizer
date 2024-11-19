// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/errors/failure.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/sources/auth_data_source.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    authDataSource: ref.watch(authDataSourceProvider),
  ),
);

sealed class AuthRepository {
  /// Login
  Future<Either<Failure, bool>> login({
    required String username,
    required String password,
  });

  /// Is already login
  Future<Either<Failure, bool>> isAlreadyLogin();

  /// Logout
  Future<Either<Failure, bool>> logout();

  /// Get user credential
  // Future<Profile> getCredential();
}

final class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  const AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, bool>> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await authDataSource.login(
        username: username,
        password: password,
      );

      return Right(result);
    } on Exception catch (e) {
      return Left(failure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> isAlreadyLogin() async {
    try {
      final result = await authDataSource.isAlreadyLogin();

      return Right(result);
    } on Exception catch (e) {
      return Left(failure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await authDataSource.logout();

      return Right(result);
    } on Exception catch (e) {
      return Left(failure(e));
    }
  }
}
