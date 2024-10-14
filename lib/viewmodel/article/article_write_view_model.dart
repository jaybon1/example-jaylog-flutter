import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/article/dto/req/req_article_post_dto.dart';
import 'package:jaylog/model/article/repository/article_repository.dart';
import 'package:jaylog/util/util_function.dart';

final articleWriteViewModelLocal = ChangeNotifierProvider.autoDispose<_ArticleWriteViewModel>((ref) {
  return _ArticleWriteViewModel();
});

class _ArticleWriteViewModel extends ChangeNotifier {
  bool _isPendingPost = false;

  bool get isPendingPost => _isPendingPost;

  Future<void> post({
    required ReqArticlePostDTO reqArticlePostDTO,
    required Function onSuccess,
    Function onError = UtilFunction.handleDefaultError,
  }) async {
    _isPendingPost = true;
    notifyListeners();
    try {
      final response = await ArticleRepository.post(reqArticlePostDTO);
      final resDTO = response.data;
      onSuccess(resDTO["message"]);
    } on Exception catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      _isPendingPost = false;
      notifyListeners();
    }
  }
}
