// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scannerProvider = ChangeNotifierProvider.autoDispose<ScannerNotifier>(
  (ref) => ScannerNotifier(),
);

class ScannerNotifier extends ChangeNotifier {
  bool _isPaused = false;
  bool _autoConfirm = true;

  bool get isPaused => _isPaused;
  bool get autoConfirm => _autoConfirm;

  set isPaused(bool value) {
    _isPaused = value;
    notifyListeners();
  }

  set autoConfirm(bool value) {
    _autoConfirm = value;
    notifyListeners();
  }

  void reset() {
    _isPaused = false;
    notifyListeners();
  }
}
