// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/src/data/repositories/auth_repository.dart';
import 'package:kartjis_mobile_organizer/src/presentation/features/auth/providers/data_sources_provider/auth_data_source_provider.dart';
import 'package:kartjis_mobile_organizer/src/presentation/shared/providers/generated/network_info_provider.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    authDataSource: ref.watch(authDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}
