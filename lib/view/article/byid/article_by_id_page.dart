import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/common/constant/constant.dart';
import 'package:jaylog/store/auth_store.dart';
import 'package:jaylog/util/util_function.dart';
import 'package:jaylog/view/_component/common/circle_profile_image.dart';
import 'package:jaylog/view/_component/common/widget_placeholder.dart';
import 'package:jaylog/view/_component/layout/default_layout.dart';
import 'package:jaylog/view/article/_component/button/article_button.dart';
import 'package:jaylog/viewmodel/article/article_by_id_view_model.dart';

class ArticleByIdPage extends HookConsumerWidget {
  final BigInt id;

  const ArticleByIdPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStoreState = ref.watch(authStoreGlobal);
    final articleByIdViewModelState = ref.watch(articleByIdViewModelLocal);

    useEffect(() {
      articleByIdViewModelState.get(
        id: id,
      );
      return null;
    }, []);

    if (articleByIdViewModelState.article == null) {
      return DefaultLayout(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const WidgetPlaceholder(
                  width: double.infinity,
                  height: 50,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                const Row(
                  children: [
                    CircleProfileImage(
                      imageUrl: Constant.defaultProfileImage,
                    ),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    WidgetPlaceholder(
                      width: 50,
                      height: 20,
                    ),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    WidgetPlaceholder(
                      width: 200,
                      height: 20,
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                const Row(
                  children: [],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                const WidgetPlaceholder(
                  width: double.infinity,
                  height: 20,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                const WidgetPlaceholder(
                  width: double.infinity,
                  height: 20,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                const WidgetPlaceholder(
                  width: double.infinity,
                  height: 20,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                const WidgetPlaceholder(
                  width: double.infinity,
                  height: 20,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                const WidgetPlaceholder(
                  width: double.infinity,
                  height: 20,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 15)),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text("목록으로"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return DefaultLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                articleByIdViewModelState.article!.title,
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Row(
                children: [
                  CircleProfileImage(
                    imageUrl:
                        articleByIdViewModelState.article!.writer.profileImage,
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    articleByIdViewModelState.article!.writer.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    articleByIdViewModelState.article!.createDate.toString(),
                    style: const TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Row(
                children: authStoreState.loginUser?.username !=
                        articleByIdViewModelState.article!.writer.username
                    ? []
                    : [
                        ArticleButton(
                          child: const Text("수정"),
                          color: Colors.green,
                          onPressed: () {
                            GoRouter.of(context).push("/article/$id/edit");
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        ArticleButton(
                          color: Colors.red,
                          onPressed: articleByIdViewModelState.isPendingDelete
                              ? null
                              : () async {
                                  final isDelete = await UtilFunction.confirm(
                                    context: context,
                                    content: "정말로 삭제하시겠습니까?",
                                  );
                                  if (isDelete) {
                                    articleByIdViewModelState.delete(
                                      id: id,
                                      onSuccess: (message) {
                                        UtilFunction.alert(
                                          context: context,
                                          content: message,
                                          callback: () {
                                            GoRouter.of(context).pop();
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                          child: articleByIdViewModelState.isPendingDelete
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text("삭제"),
                        ),
                      ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              MarkdownBody(
                data: articleByIdViewModelState.article!.content,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  child: const Text("목록으로"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
