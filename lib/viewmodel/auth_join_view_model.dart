
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_join_dto.dart';
import 'package:jaylog/model/auth/repository/auth_repository.dart';
import 'package:jaylog/util/util_function.dart';

final authJoinViewModelLocal = ChangeNotifierProvider.autoDispose<_AuthJoinViewModel>((ref) {
  return _AuthJoinViewModel();
});

class _AuthJoinViewModel extends ChangeNotifier {
  bool _isPendingJoin = false;

  bool get isPendingJoin => _isPendingJoin;

  void postJoin(ReqAuthPostJoinDTO reqAuthPostJoinDTO) {
    _isPendingJoin = true;
    notifyListeners();
    AuthRepository.postJoin(reqAuthPostJoinDTO)
    .then((response) {
      // 성공 시 처리
    })
    .onError(UtilFunction.handleDefaultError)
    .whenComplete(() {
      _isPendingJoin = false;
      notifyListeners();
    });
  }
}