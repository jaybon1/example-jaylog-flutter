class ReqArticlePostDTO {
  final _Article article;

  ReqArticlePostDTO._({
    required this.article,
  });

  factory ReqArticlePostDTO.of({
    required String title,
    required String content,
  }) {
    return ReqArticlePostDTO._(
      article: _Article(
        title: title,
        content: content,
      ),
    );
  }
}

class _Article {
  final String title;
  final String content;

  _Article({
    required this.title,
    required this.content,
  });
}
