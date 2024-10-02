import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/main/repository/main_repository.dart';
import 'package:jaylog/util/util_function.dart';

final mainViewModelGlobal = ChangeNotifierProvider<_MainViewModel>((ref) {
  return _MainViewModel();
});

class _MainViewModel extends ChangeNotifier {
  List<_Article>? _articleList;
  Pagination? _pagination;

  List<_Article>? get articleList => _articleList;

  Pagination? get pagination => _pagination;

  void get(String searchValue) {
    MainRepository.get(searchValue).then((response) {
      final data = response.data["data"];
      _articleList = List<_Article>.from(
          data['articlePage']['content'].map((x) => _Article.fromMap(x)));
      _pagination = Pagination.fromMap(data['articlePage']['page']);
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

// factory _Article.fromJson(String json) {
//   return _Article.fromMap(jsonDecode(json));
// }
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

class Pagination {
  final int size;
  final int number;
  final int totalElements;
  final int totalPages;

  Pagination({
    required this.size,
    required this.number,
    required this.totalElements,
    required this.totalPages,
  });

  factory Pagination.fromMap(dynamic jsonMap) {
    return Pagination(
      size: jsonMap['size'],
      number: jsonMap['number'],
      totalElements: jsonMap['totalElements'],
      totalPages: jsonMap['totalPages'],
    );
  }
}
