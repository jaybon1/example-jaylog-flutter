import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/article/dto/req/req_article_put_dto.dart';
import 'package:jaylog/model/article/repository/article_repository.dart';
import 'package:jaylog/util/util_function.dart';

final articleEditViewModelLocal =
    ChangeNotifierProvider.autoDispose<_ArticleEditViewModel>((ref) {
  return _ArticleEditViewModel();
});

class _ArticleEditViewModel extends ChangeNotifier {
  _Article? _article;
  bool _isPendingPut = false;

  _Article? get article => _article;

  bool get isPendingPut => _isPendingPut;

  Future<void> get({
    required BigInt id,
    onError = UtilFunction.handleDefaultError,
  }) async {
    try {
      final response = await ArticleRepository.get(id);
      final resDTO = response.data;
      print(resDTO);
      _article = _Article.fromMap(resDTO["data"]["article"]);
    } on Exception catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      notifyListeners();
    }
  }

  Future<void> put({
    required BigInt id,
    required ReqArticlePutDTO reqArticlePutDTO,
    required Function onSuccess,
    Function onError = UtilFunction.handleDefaultError,
  }) async {
    _isPendingPut = true;
    notifyListeners();
    try {
      final response = await ArticleRepository.put(id, reqArticlePutDTO);
      final resDTO = response.data;
      onSuccess(resDTO["message"]);
    } on Exception catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      _isPendingPut = false;
      notifyListeners();
    }
  }
}

class _Article {
  final BigInt id;
  final _Writer writer;
  final String title;
  final String? thumbnail;
  final String content;
  final int likeCount;
  final bool isLikeClicked;
  final DateTime createDate;

  _Article({
    required this.id,
    required this.writer,
    required this.title,
    required this.thumbnail,
    required this.content,
    required this.likeCount,
    required this.isLikeClicked,
    required this.createDate,
  });

  factory _Article.fromMap(dynamic jsonMap) {
    return _Article(
      id: BigInt.from(jsonMap['id']),
      writer: _Writer.fromMap(jsonMap['writer']),
      title: jsonMap['title'],
      thumbnail: jsonMap['thumbnail'],
      content: jsonMap['content'],
      likeCount: jsonMap['likeCount'],
      isLikeClicked: jsonMap['isLikeClicked'],
      createDate: DateTime.parse(jsonMap['createDate']),
    );
  }
}

class _Writer {
  final String username;
  final String profileImage;

  _Writer({
    required this.username,
    required this.profileImage,
  });

  factory _Writer.fromMap(dynamic jsonMap) {
    return _Writer(
      username: jsonMap['username'],
      profileImage: jsonMap['profileImage'],
    );
  }
}
