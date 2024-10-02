class ReqArticlePutDTO {
  final _Article article;

  ReqArticlePutDTO._({
    required this.article,
  });

  factory ReqArticlePutDTO.of({
    required String title,
    required String content,
  }) {
    return ReqArticlePutDTO._(
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
