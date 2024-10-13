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

  void put(BigInt id, ReqArticlePutDTO reqArticlePutDTO) {
    _isPendingPut = true;
    notifyListeners();
    ArticleRepository.put(id, reqArticlePutDTO)
        .then((response) {
          // 성공 시 처리
        })
        .onError(UtilFunction.handleDefaultError)
        .whenComplete(() {
          _isPendingPut = false;
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
