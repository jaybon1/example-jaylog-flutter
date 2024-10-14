import 'package:dio/dio.dart';
import 'package:jaylog/model/article/dto/req/req_article_post_dto.dart';
import 'package:jaylog/model/article/dto/req/req_article_put_dto.dart';
import 'package:jaylog/util/custom.dart';

class ArticleRepository {
  static const _url = '/v1/article';

  static Future<Response> get(BigInt id) async {
    return await CustomFetch.dioWithJwt.get("$_url/$id");
  }

  static Future<Response> post(ReqArticlePostDTO reqArticlePostDTO) async {
    return await CustomFetch.dioWithJwt.post(
      _url,
      data: reqArticlePostDTO.toMap(),
    );
  }

  static Future<Response> put(
      BigInt id, ReqArticlePutDTO reqArticlePutDTO) async {
    return await CustomFetch.dioWithJwt.put(
      "$_url/$id",
      data: reqArticlePutDTO.toMap(),
    );
  }

  static Future<Response> delete(BigInt id) async {
    return await CustomFetch.dioWithJwt.delete("$_url/$id");
  }

  static Future<Response> postLike(BigInt id) async {
    return await CustomFetch.dioWithJwt.post("$_url/$id/like");
  }
}
