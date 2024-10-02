import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/article/repository/article_repository.dart';
import 'package:jaylog/util/util_function.dart';

final articleByIdViewModelLocal =
    ChangeNotifierProvider.autoDispose<_ArticleByIdViewModel>((ref) {
  return _ArticleByIdViewModel();
});

class _ArticleByIdViewModel extends ChangeNotifier {
  _Article? _article;
  bool _isPendingDelete = false;
  bool _isPendingPostLike = false;

  _Article? get article => _article;

  bool get isPendingDelete => _isPendingDelete;

  bool get isPendingPostLike => _isPendingPostLike;

  void get(BigInt id) {
    ArticleRepository.get(id).then((response) {
      final data = response.data["data"];
      _article = _Article.fromMap(data['article']);
      notifyListeners();
    }).onError(UtilFunction.handleDefaultError);
  }

  void delete(BigInt id) {
    _isPendingDelete = true;
    notifyListeners();
    ArticleRepository.delete(id)
        .then((response) {
          // 성공 시 처리
        })
        .onError(UtilFunction.handleDefaultError)
        .whenComplete(() {
          _isPendingDelete = false;
          notifyListeners();
        });
  }

  void postLike(BigInt id) {
    _isPendingPostLike = true;
    notifyListeners();
    ArticleRepository.postLike(id)
        .then((response) {
          // 성공 시 처리
        })
        .onError(UtilFunction.handleDefaultError)
        .whenComplete(() {
          _isPendingPostLike = false;
          notifyListeners();
        });
  }
}

class _Article {
  final int id;
  final _Writer writer;
  final String title;
  final String thumbnail;
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
      id: jsonMap['id'],
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
