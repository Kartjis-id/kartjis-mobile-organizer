// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/features/auth/data/repositories/auth_repository.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  @override
  FutureOr<bool?> build() => null;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final result = await ref.read(authRepositoryProvider).login(
          username: username,
          password: password,
        );

    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}
