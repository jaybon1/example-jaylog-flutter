import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/main/repository/main_repository.dart';
import 'package:jaylog/util/util_function.dart';

final mainViewModelGlobal = ChangeNotifierProvider<_MainViewModel>((ref) {
  return _MainViewModel();
});

class _MainViewModel extends ChangeNotifier {
  _ArticlePage? _articlePage;

  List<_Article>? get articleList => _articlePage?.content;

  _Page? get page => _articlePage?.page;

  Future<void> get({
    required String searchValue,
    Function onError = UtilFunction.handleDefaultError,
  }) async {
    try {
      final response = await MainRepository.get(searchValue);
      final resDTO = response.data;
      _articlePage = _ArticlePage.fromMap(resDTO["data"]["articlePage"]);
    } catch (e, stackTrace) {
      onError(e, stackTrace);
    } finally {
      notifyListeners();
    }
  }
}

class _ArticlePage {
  final List<_Article> content;
  final _Page page;

  _ArticlePage({
    required this.content,
    required this.page,
  });

  factory _ArticlePage.fromMap(Map<String, dynamic> jsonMap) {
    return _ArticlePage(
      content: List<_Article>.from(jsonMap['content']
          .map((thisArticle) => _Article.fromMap(thisArticle))),
      page: _Page.fromMap(jsonMap['page']),
    );
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

  factory _Article.fromMap(Map<String, dynamic> jsonMap) {
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

  factory _Writer.fromMap(Map<String, dynamic> jsonMap) {
    return _Writer(
      username: jsonMap['username'],
      profileImage: jsonMap['profileImage'],
    );
  }
}

class _Page {
  final int size;
  final int number;
  final int totalElements;
  final int totalPages;

  _Page({
    required this.size,
    required this.number,
    required this.totalElements,
    required this.totalPages,
  });

  factory _Page.fromMap(Map<String, dynamic> jsonMap) {
    return _Page(
      size: jsonMap['size'],
      number: jsonMap['number'],
      totalElements: jsonMap['totalElements'],
      totalPages: jsonMap['totalPages'],
    );
  }
}
