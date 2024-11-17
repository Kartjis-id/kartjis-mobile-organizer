// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/errors/failures.dart';
import 'package:kartjis_mobile_organizer/src/data/sources/auth_data_source.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    authDataSource: ref.watch(authDataSourceProvider),
  ),
);

sealed class AuthRepository {
  /// Sign in
  Future<Either<Failure, bool>> signIn({
    required String username,
    required String password,
  });

  /// Log out
  Future<Either<Failure, bool>> logOut();
}

final class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, bool>> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final result = await authDataSource.signIn(
        username: username,
        password: password,
      );

      return Right(result);
    } on Exception catch (e) {
      return Left(failure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      final result = await authDataSource.logOut();

      return Right(result);
    } on Exception catch (e) {
      return Left(failure(e));
    }
  }
}
