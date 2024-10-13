import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/my/repository/my_repository.dart';
import 'package:jaylog/util/util_function.dart';

final myInfoViewModelLocal =
    ChangeNotifierProvider.autoDispose<_MyInfoViewModel>((ref) {
  return _MyInfoViewModel();
});

class _MyInfoViewModel extends ChangeNotifier {
  bool _isPendingPutInfo = false;

  bool get isPendingPutInfo => _isPendingPutInfo;

  void putInfo(FormData formData) {
    _isPendingPutInfo = true;
    notifyListeners();
    MyRepository.putInfo(formData)
        .then((response) {
          // 성공 시 처리
        })
        .onError(UtilFunction.handleDefaultError)
        .whenComplete(() {
          _isPendingPutInfo = false;
          notifyListeners();
        });
  }
}
