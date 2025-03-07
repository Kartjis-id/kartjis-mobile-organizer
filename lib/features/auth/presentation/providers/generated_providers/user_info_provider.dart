// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/features/auth/data/models/user.dart';
import 'package:kartjis_mobile_organizer/features/auth/data/repositories/auth_repository.dart';

part 'user_info_provider.g.dart';

@riverpod
class UserInfo extends _$UserInfo {
  @override
  FutureOr<User?> build() async {
    state = const AsyncValue.loading();

    final result = await ref.read(authRepositoryProvider).getUserInfo();

    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );

    return state.valueOrNull;
  }
}
