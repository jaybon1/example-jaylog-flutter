import 'dart:convert';

class ResMainGetDTO {
  final _ArticlePage articlePage;

  ResMainGetDTO._({required this.articlePage});

  factory ResMainGetDTO.fromMap(Map<String, dynamic> jsonMap) {
    return ResMainGetDTO._(
      articlePage: _ArticlePage.fromMap(jsonMap['articlePage']),
    );
  }

  factory ResMainGetDTO.fromJson(String json) {
    return ResMainGetDTO.fromMap(jsonDecode(json));
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
  final int id;
  final _User writer;
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

  factory _Article.fromMap(Map<String, dynamic> jsonMap) {
    return _Article(
      id: jsonMap['id'],
      writer: _User.fromMap(jsonMap['writer']),
      title: jsonMap['title'],
      thumbnail: jsonMap['thumbnail'],
      summary: jsonMap['summary'],
      likeCount: jsonMap['likeCount'],
      isLikeClicked: jsonMap['isLikeClicked'],
      createDate: DateTime.parse(jsonMap['createDate']),
    );
  }
}

class _User {
  final String username;
  final String profileImage;

  _User({
    required this.username,
    required this.profileImage,
  });

  factory _User.fromMap(Map<String, dynamic> jsonMap) {
    return _User(
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

  _Page._({
    required this.size,
    required this.number,
    required this.totalElements,
    required this.totalPages,
  });

  factory _Page.fromMap(Map<String, dynamic> jsonMap) {
    return _Page._(
      size: jsonMap['size'],
      number: jsonMap['number'],
      totalElements: jsonMap['totalElements'],
      totalPages: jsonMap['totalPages'],
    );
  }
}
