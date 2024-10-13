import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_join_dto.dart';
import 'package:jaylog/model/auth/repository/auth_repository.dart';
import 'package:jaylog/util/util_function.dart';

final authJoinViewModelLocal =
    ChangeNotifierProvider.autoDispose<_AuthJoinViewModel>((ref) {
  return _AuthJoinViewModel();
});

class _AuthJoinViewModel extends ChangeNotifier {
  bool _isPendingJoin = false;

  bool get isPendingJoin => _isPendingJoin;

  Future<void> postJoin({
    required ReqAuthPostJoinDTO reqAuthPostJoinDTO,
    required Function onSuccess,
    Function onError = UtilFunction.handleDefaultError,
  }) async {
    _isPendingJoin = true;
    notifyListeners();
    try {
      final response = await AuthRepository.postJoin(reqAuthPostJoinDTO);
      final resDTO = response.data;
      onSuccess(resDTO["message"]);
    } catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      _isPendingJoin = false;
      notifyListeners();
    }
  }
}
