import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/article/repository/article_repository.dart';
import 'package:jaylog/util/util_function.dart';

final articleByIdViewModelLocal = ChangeNotifierProvider.autoDispose<_ArticleByIdViewModel>((ref) {
  return _ArticleByIdViewModel();
});

class _ArticleByIdViewModel extends ChangeNotifier {
  _Article? _article;
  bool _isPendingDelete = false;
  bool _isPendingPostLike = false;

  _Article? get article => _article;

  bool get isPendingDelete => _isPendingDelete;

  bool get isPendingPostLike => _isPendingPostLike;

  void get({
    required BigInt id,
    onError = UtilFunction.handleDefaultError,
  }) async {
    try {
      final response = await ArticleRepository.get(id);
      final resDTO = response.data;
      _article = _Article.fromMap(resDTO["data"]["article"]);
    } on Exception catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      notifyListeners();
    }
  }

  Future<void> delete({
    required BigInt id,
    required Function onSuccess,
    onError = UtilFunction.handleDefaultError,
  }) async {
    _isPendingDelete = true;
    notifyListeners();
    try {
      final response = await ArticleRepository.delete(id);
      final resDTO = response.data;
      onSuccess(resDTO["message"]);
    } on Exception catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      _isPendingDelete = false;
      notifyListeners();
    }
  }

  Future<void> postLike({
    required BigInt id,
    onError = UtilFunction.handleDefaultError,
  }) async {
    _isPendingPostLike = true;
    notifyListeners();
    try {
      final response = await ArticleRepository.postLike(id);
      final resDTO = response.data;
      _article = _article!.copyWith(
        likeCount: resDTO["data"]["article"]["likeCount"],
        isLikeClicked: resDTO["data"]["article"]["isLikeClicked"],
      );
    } on Exception catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      _isPendingPostLike = false;
      notifyListeners();
    }
  }
}

class _Article {
  final int id;
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

  _Article copyWith({
    int? id,
    _Writer? writer,
    String? title,
    String? thumbnail,
    String? content,
    int? likeCount,
    bool? isLikeClicked,
    DateTime? createDate,
  }) {
    return _Article(
      id: id ?? this.id,
      writer: writer ?? this.writer,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
      isLikeClicked: isLikeClicked ?? this.isLikeClicked,
      createDate: createDate ?? this.createDate,
    );
  }

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
