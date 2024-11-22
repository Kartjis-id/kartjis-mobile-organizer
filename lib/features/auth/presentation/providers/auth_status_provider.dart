// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/features/auth/data/repositories/auth_repository.dart';

part 'auth_status_provider.g.dart';

@riverpod
class AuthStatus extends _$AuthStatus {
  @override
  FutureOr<bool?> build() async {
    state = const AsyncValue.loading();

    final result = await ref.read(authRepositoryProvider).isAlreadyLogin();

    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );

    return null;
  }
}
