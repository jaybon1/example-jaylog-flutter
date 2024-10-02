import 'dart:convert';

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

  void get() {
    MyRepository.get().then((response) {
      final data = response.data["data"];
      _myArticleList = List<_Article>.from(
          data['myArticleList'].map((x) => _Article.fromMap(x)));
      _likeArticleList = List<_Article>.from(
          data['likeArticleList'].map((x) => _Article.fromMap(x)));
      notifyListeners();
    }).onError(UtilFunction.handleDefaultError);
  }
}

class _Article {
  final int id;
  final _Writer writer;
  final String title;
  final String thumbnail;
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
      id: jsonMap['id'],
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
