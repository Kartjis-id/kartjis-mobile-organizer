// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences_helper.dart';
import 'package:kartjis_mobile_organizer/core/utils/http_client.dart';
import 'package:kartjis_mobile_organizer/src/data/sources/auth_data_source.dart';

part 'auth_data_source_provider.g.dart';

@riverpod
AuthDataSource authDataSource(Ref ref) {
  return AuthDataSourceImpl(
    client: HttpClient().client,
    authPreferencesHelper: AuthPreferencesHelper(),
  );
}
