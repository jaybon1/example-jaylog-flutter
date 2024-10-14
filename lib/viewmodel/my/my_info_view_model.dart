import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/my/repository/my_repository.dart';
import 'package:jaylog/util/util_function.dart';

final myInfoViewModelLocal = ChangeNotifierProvider.autoDispose<_MyInfoViewModel>((ref) {
  return _MyInfoViewModel();
});

class _MyInfoViewModel extends ChangeNotifier {
  bool _isPendingPutInfo = false;

  bool get isPendingPutInfo => _isPendingPutInfo;

  void putInfo({
    required FormData formData,
    required Function onSuccess,
    Function onError = UtilFunction.handleDefaultError,
  }) async {
    _isPendingPutInfo = true;
    notifyListeners();
    try {
      final response = await MyRepository.putInfo(formData);
      final resDTO = response.data;
      onSuccess(resDTO["message"]);
    } on Exception catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      _isPendingPutInfo = false;
      notifyListeners();
    }
  }
}
