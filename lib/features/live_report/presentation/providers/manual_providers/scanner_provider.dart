// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scannerProvider = ChangeNotifierProvider.autoDispose<ScannerNotifier>(
  (ref) => ScannerNotifier(),
);

class ScannerNotifier extends ChangeNotifier {
  bool _enableSound = true;
  bool _paused = false;

  bool get enableSound => _enableSound;
  bool get paused => _paused;

  set enableSound(bool value) {
    _enableSound = value;
    notifyListeners();
  }

  set paused(bool value) {
    _paused = value;
    notifyListeners();
  }
}
