// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = ChangeNotifierProvider.autoDispose<SearchNotifier>(
  (ref) => SearchNotifier(),
);

class SearchNotifier extends ChangeNotifier {
  bool _isSearching = false;
  String _searchText = '';

  bool get isSearching => _isSearching;
  String get searchText => _searchText;

  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  void reset() {
    _isSearching = false;
    _searchText = '';
    notifyListeners();
  }
}
