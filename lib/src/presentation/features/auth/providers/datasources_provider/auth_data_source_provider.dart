// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/helpers/auth_preferences_helper.dart';
import 'package:kartjis_mobile_organizer/core/utils/http_client.dart';
import 'package:kartjis_mobile_organizer/src/data/datasources/auth_data_sources.dart';

part 'auth_data_source_provider.g.dart';

@riverpod
AuthDataSource authDataSource(AuthDataSourceRef ref) {
  return AuthDataSourceImpl(
    client: HttpClient.client,
    preferencesHelper: AuthPreferencesHelper(),
  );
}
