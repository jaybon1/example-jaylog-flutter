import 'package:dio/dio.dart';
import 'package:jaylog/model/article/dto/req/req_article_post_dto.dart';
import 'package:jaylog/model/article/dto/req/req_article_put_dto.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_join_dto.dart';
import 'package:jaylog/util/custom.dart';

class ArticleRepository {
  static const _url = '/article';

  static Future<Response> get(BigInt id) async {
    return await CustomFetch.dio.get("$_url/$id");
  }

  static Future<Response> post(ReqArticlePostDTO reqArticlePostDTO) async {
    return await CustomFetch.dio.post("$_url", data: reqArticlePostDTO);
  }

  static Future<Response> put(
      BigInt id, ReqArticlePutDTO reqArticlePutDTO) async {
    return await CustomFetch.dio.put("$_url/$id", data: reqArticlePutDTO);
  }

  static Future<Response> delete(BigInt id) async {
    return await CustomFetch.dio.delete("$_url/$id");
  }

  static Future<Response> postLike(BigInt id) async {
    return await CustomFetch.dio.post("$_url/$id/like");
  }
}
