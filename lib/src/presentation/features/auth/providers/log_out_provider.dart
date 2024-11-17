// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/src/data/repositories/auth_repository.dart';

part 'log_out_provider.g.dart';

@riverpod
class LogOut extends _$LogOut {
  @override
  AsyncValue<bool?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> logOut() async {
    state = const AsyncValue.loading();

    final result = await ref.watch(authRepositoryProvider).logOut();

    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}
