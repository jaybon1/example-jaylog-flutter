import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/article/dto/req/req_article_post_dto.dart';
import 'package:jaylog/util/util_function.dart';
import 'package:jaylog/view/article/_component/button/article_button.dart';
import 'package:jaylog/view/article/_component/layout/article_write_edit_layout.dart';
import 'package:jaylog/viewmodel/article/article_write_view_model.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleWritePage extends HookConsumerWidget {
  const ArticleWritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleWriteViewModelState = ref.watch(articleWriteViewModelLocal);

    final titleTextEditingController = useTextEditingController();
    final markdownTextEditingController = useTextEditingController();

    useEffect(() {
      Future<void> _getTempArticle() async {
        final sharedPreferences = await SharedPreferences.getInstance();
        final tempArticle = sharedPreferences.getString("tempArticle");
        if (tempArticle != null) {
          final isImport = await UtilFunction.confirm(
            context: context,
            content: "임시저장된 글이 있습니다.\n불러오시겠습니까?\n취소하시면 삭제됩니다.",
          );
          if (!isImport) {
            sharedPreferences.remove("tempArticle");
            return;
          }
          final tempArticleMap = jsonDecode(tempArticle);
          titleTextEditingController.text = tempArticleMap["title"];
          markdownTextEditingController.text = tempArticleMap["content"];
        }
      }

      _getTempArticle();
    }, []);

    return ArticleWriteEditLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: titleTextEditingController,
                decoration: const InputDecoration(
                  // border: OutlineInputBorder(),
                  labelText: '제목을 입력하세요',
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              SplittedMarkdownFormField(
                controller: markdownTextEditingController,
                markdownSyntax: '## Headline',
                minLines: 9,
                maxLines: 9,
                decoration: InputDecoration(
                  hintText: '내용을 입력하세요',
                ),
                emojiConvert: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ArticleButton(
                      child: Text("나가기"),
                      color: Colors.grey,
                      onPressed: () async {
                        final isOut = await UtilFunction.confirm(
                          context: context,
                          content: "정말로 나가시겠습니까?",
                        );
                        if (isOut) {
                          GoRouter.of(context).pop();
                        }
                      }),
                  Row(
                    children: [
                      ArticleButton(
                          child: const Text("임시저장"),
                          color: Colors.blue,
                          onPressed: () async {
                            if (titleTextEditingController.text.isEmpty) {
                              UtilFunction.alert(
                                context: context,
                                content: "제목을 입력하세요.",
                              );
                              return;
                            }
                            if (markdownTextEditingController.text.isEmpty) {
                              UtilFunction.alert(
                                context: context,
                                content: "내용을 입력하세요.",
                              );
                              return;
                            }
                            final sharedPreferences = await SharedPreferences.getInstance();
                            final tempArticle = {
                              "title": titleTextEditingController.text,
                              "content": markdownTextEditingController.text,
                            };
                            sharedPreferences.setString("tempArticle", jsonEncode(tempArticle));
                            UtilFunction.alert(
                              context: context,
                              content: "임시저장되었습니다.",
                            );
                          }),
                      const Padding(padding: EdgeInsets.only(right: 10)),
                      ArticleButton(
                          color: Colors.green,
                          onPressed: articleWriteViewModelState.isPendingPost
                              ? null
                              : () async {
                                  FocusScope.of(context).unfocus();
                                  if (titleTextEditingController.text.isEmpty) {
                                    UtilFunction.alert(
                                      context: context,
                                      content: "제목을 입력하세요.",
                                    );
                                    return;
                                  }
                                  if (markdownTextEditingController.text.isEmpty) {
                                    UtilFunction.alert(
                                      context: context,
                                      content: "내용을 입력하세요.",
                                    );
                                    return;
                                  }
                                  await articleWriteViewModelState.post(
                                    reqArticlePostDTO: ReqArticlePostDTO.of(
                                      title: titleTextEditingController.text,
                                      content: markdownTextEditingController.text,
                                    ),
                                    onSuccess: (String message) async {
                                      UtilFunction.alert(
                                        context: context,
                                        content: message,
                                        callback: () async {
                                          final sharedPreferences = await SharedPreferences.getInstance();
                                          sharedPreferences.remove("tempArticle");
                                          GoRouter.of(context).go("/");
                                        },
                                      );
                                    },
                                  );
                                },
                          child: articleWriteViewModelState.isPendingPost
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text("게시하기")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
