// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/errors/failure.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/models/user.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/sources/auth_data_source.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
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

  /// Get user info
  Future<Either<Failure, User>> getUserInfo();

  /// Is already login
  Future<Either<Failure, bool>> isAlreadyLogin();

  /// Logout
  Future<Either<Failure, bool>> logout();
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
  Future<Either<Failure, User>> getUserInfo() async {
    try {
      final result = await authDataSource.getUserInfo();

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
