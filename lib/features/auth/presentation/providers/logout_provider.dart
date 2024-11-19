// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/features/auth/data/repositories/auth_repository.dart';

part 'logout_provider.g.dart';

@riverpod
class Logout extends _$Logout {
  @override
  AsyncValue<bool?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();

    final result = await ref.watch(authRepositoryProvider).logout();

    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}
