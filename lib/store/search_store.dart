import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchStoreGlobal = ChangeNotifierProvider<SearchStore>((ref) {
  return SearchStore();
});

class SearchStore extends ChangeNotifier {
  String _searchValue = "";

  String get searchValue => _searchValue;

  void setSearchValue(String searchValue) {
    _searchValue = searchValue;
    notifyListeners();
  }
}
