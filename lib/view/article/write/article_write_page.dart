import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/view/article/_component/button/article_button.dart';
import 'package:jaylog/view/article/_component/layout/article_write_edit_layout.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';

class ArticleWritePage extends HookConsumerWidget {
  const ArticleWritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleTextEditingController = useTextEditingController();
    final markdownTextEditingController = useTextEditingController();

    useListenable(titleTextEditingController);
    useListenable(markdownTextEditingController);

    useEffect(() {
      print(markdownTextEditingController.text);
    }, [markdownTextEditingController]);

    return ArticleWriteEditLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(titleTextEditingController.text),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              const TextField(
                decoration: InputDecoration(
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
                      text: "나가기",
                      color: Colors.grey,
                      onPressed: () {
                        print("게시하기");
                      }),
                  Row(
                    children: [
                      ArticleButton(
                          text: "임시저장",
                          color: Colors.blue,
                          onPressed: () {
                            print("임시저장");
                          }),
                      const Padding(padding: EdgeInsets.only(right: 10)),
                      ArticleButton(
                          text: "게시하기",
                          color: Colors.green,
                          onPressed: () {
                            print("게시하기");
                          }),
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
