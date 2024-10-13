import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/common/constant/constant.dart';
import 'package:jaylog/store/auth_store.dart';
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
    final article = useMemoized(() {
      return articleByIdViewModelState.article;
    }, [articleByIdViewModelState.article]);

    useEffect(() {
      articleByIdViewModelState.get(id);
      return null;
    }, []);

    if (article == null) {
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
                article.title,
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Row(
                children: [
                  CircleProfileImage(
                    imageUrl: article.writer.profileImage,
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    article.writer.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    article.createDate.toString(),
                    style: const TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Row(
                children: authStoreState.loginUser?.username !=
                        article.writer.username
                    ? []
                    : [
                        ArticleButton(
                          text: "수정",
                          color: Colors.green,
                          onPressed: () {
                            GoRouter.of(context).push("/article/1/edit");
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        ArticleButton(
                          text: "삭제",
                          color: Colors.red,
                          onPressed: () {},
                        ),
                      ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              MarkdownBody(
                data: article.content,
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
