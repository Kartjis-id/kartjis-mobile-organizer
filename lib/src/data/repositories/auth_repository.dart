// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/connections/network_info.dart';
import 'package:kartjis_mobile_organizer/core/errors/exceptions.dart';
import 'package:kartjis_mobile_organizer/core/errors/failures.dart';
import 'package:kartjis_mobile_organizer/core/utils/const.dart';
import 'package:kartjis_mobile_organizer/src/data/datasources/auth_data_sources.dart';

abstract class AuthRepository {
  /// Sign in
  Future<Either<Failure, bool>> signIn({
    required String username,
    required String password,
  });

  /// Log out
  Future<Either<Failure, bool>> logOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> signIn({
    required String username,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authDataSource.signIn(
          username: username,
          password: password,
        );

        return Right(result);
      } catch (e) {
        return Left(failure(e));
      }
    } else {
      return const Left(ConnectionFailure(kNoInternetConnection));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      final result = await authDataSource.logOut();

      return Right(result);
    } on PreferencesException catch (e) {
      return Left(PreferencesFailure(e.message));
    }
  }
}
