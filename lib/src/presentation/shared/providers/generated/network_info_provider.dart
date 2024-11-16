// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:kartjis_mobile_organizer/core/connections/network_info.dart';

part 'network_info_provider.g.dart';

@riverpod
NetworkInfo networkInfo(Ref ref) => NetworkInfoImpl(connectionChecker: InternetConnectionChecker());
