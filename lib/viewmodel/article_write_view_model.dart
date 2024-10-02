import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/article/dto/req/req_article_post_dto.dart';
import 'package:jaylog/model/article/repository/article_repository.dart';
import 'package:jaylog/util/util_function.dart';

final articleWriteViewModelLocal =
    ChangeNotifierProvider.autoDispose<_ArticleWriteViewModel>((ref) {
  return _ArticleWriteViewModel();
});

class _ArticleWriteViewModel extends ChangeNotifier {
  bool _isPendingPost = false;

  bool get isPendingPost => _isPendingPost;

  void post(ReqArticlePostDTO reqArticlePostDTO) {
    _isPendingPost = true;
    notifyListeners();
    ArticleRepository.post(reqArticlePostDTO)
        .then((response) {
          // 성공 시 처리
        })
        .onError(UtilFunction.handleDefaultError)
        .whenComplete(() {
          _isPendingPost = false;
          notifyListeners();
        });
  }
}
