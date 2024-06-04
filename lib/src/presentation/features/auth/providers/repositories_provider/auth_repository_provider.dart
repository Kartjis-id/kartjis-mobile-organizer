// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/src/data/repositories/auth_repository.dart';
import 'package:kartjis_mobile_organizer/src/presentation/features/auth/providers/datasources_provider/auth_data_source_provider.dart';
import 'package:kartjis_mobile_organizer/src/presentation/shared/providers/generated/network_info_provider.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    authDataSource: ref.watch(authDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}
