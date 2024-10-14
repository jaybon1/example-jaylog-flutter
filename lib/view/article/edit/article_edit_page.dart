import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/article/dto/req/req_article_put_dto.dart';
import 'package:jaylog/util/util_function.dart';
import 'package:jaylog/view/article/_component/button/article_button.dart';
import 'package:jaylog/view/article/_component/layout/article_write_edit_layout.dart';
import 'package:jaylog/viewmodel/article/article_edit_view_model.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';

class ArticleEditPage extends HookConsumerWidget {
  final BigInt id;

  const ArticleEditPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleEditViewModelState = ref.watch(articleEditViewModelLocal);

    final titleTextEditingController = useTextEditingController();
    final markdownTextEditingController = useTextEditingController();

    useEffect(() {
      Future<void> _getArticle() async {
        await articleEditViewModelState.get(
          id: id,
        );
        titleTextEditingController.text = articleEditViewModelState.article?.title ?? '';
        markdownTextEditingController.text = articleEditViewModelState.article?.content ?? '';
        print(articleEditViewModelState.article?.title);
      }

      _getArticle();
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
                minLines: 3,
                maxLines: 10,
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
                      GoRouter.of(context).pop();
                    },
                  ),
                  ArticleButton(
                    color: Colors.green,
                    onPressed: articleEditViewModelState.isPendingPut
                        ? null
                        : () async {
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
                            await articleEditViewModelState.put(
                              id: id,
                              reqArticlePutDTO: ReqArticlePutDTO.of(
                                title: titleTextEditingController.text,
                                content: markdownTextEditingController.text,
                              ),
                              onSuccess: (String message) async {
                                UtilFunction.alert(
                                  context: context,
                                  content: message,
                                  callback: () async {
                                    GoRouter.of(context).pushReplacement("/article/$id");
                                  },
                                );
                              },
                            );
                          },
                    child: articleEditViewModelState.isPendingPut
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          )
                        : const Text("게시하기"),
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
