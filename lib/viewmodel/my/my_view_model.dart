import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/my/repository/my_repository.dart';
import 'package:jaylog/util/util_function.dart';

final myViewModelGlobal = ChangeNotifierProvider<_MyViewModel>((ref) {
  return _MyViewModel();
});

class _MyViewModel extends ChangeNotifier {
  List<_Article>? _myArticleList;
  List<_Article>? _likeArticleList;

  List<_Article>? get myArticleList => _myArticleList;

  List<_Article>? get likeArticleList => _likeArticleList;

  void get({
    Function onError = UtilFunction.handleDefaultError,
  }) async {
    try {
      final response = await MyRepository.get();
      final resDTO = response.data;
      _myArticleList = List<_Article>.from(resDTO['data']['myArticleList']
          .map((thisArticle) => _Article.fromMap(thisArticle)));
      _likeArticleList = List<_Article>.from(resDTO['data']['likeArticleList']
          .map((thisArticle) => _Article.fromMap(thisArticle)));
    } on Exception catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      notifyListeners();
    }
  }
}

class _Article {
  final BigInt id;
  final _Writer writer;
  final String title;
  final String? thumbnail;
  final String summary;
  final int likeCount;
  final bool isLikeClicked;
  final DateTime createDate;

  _Article({
    required this.id,
    required this.writer,
    required this.title,
    required this.thumbnail,
    required this.summary,
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
      summary: jsonMap['summary'],
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
