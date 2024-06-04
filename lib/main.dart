import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartjis_mobile_organizer/app.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: KartjisOrganizerApp(),
    ),
  );
}
