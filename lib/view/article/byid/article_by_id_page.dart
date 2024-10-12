import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/view/_component/common/circle_profile_image.dart';
import 'package:jaylog/view/_component/layout/default_layout.dart';
import 'package:jaylog/view/article/_component/button/article_button.dart';

class ArticleByIdPage extends HookConsumerWidget {
  const ArticleByIdPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                '[번역] Node.js 개요: 아키텍처, API, 이벤트 루프, 동시성',
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Row(
                children: [
                  CircleProfileImage(
                    imageUrl: "https://picsum.photos/50",
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    "temp1",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    "2024-10-01T19:18:27.565936",
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Row(
                children: [
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
                data:
                    """![image](https://velog.velcdn.com/images/sehyunny/post/e48644e2-add4-44da-905c-b36a278d9d8f/image.png)

# 세계 최초의 O(1) 자바스크립트 프레임워크 살펴보기

우리는 지금부터 "Qwik" 에 대해 이야기하려고 합니다. Qwik은 크기와 복잡성에 상관없이 즉시 로딩되는 애플리케이션을 제공하고, 규모에 맞게 일관된 성능을 달성할 수 있는 새로운 종류의 웹 프레임워크입니다.

Qwik은 2년간의 개발 기간을 거쳐 현재 베타 단계이며, 완전한 기능, 안정된 API, 블로킹 이슈 제거, 그리고 충분한 문서와 함께 프로덕션에 나갈 준비가 되었습니다. 이제 이 프레임워크가 무엇인지를 살펴보겠습니다.

문제를 해결하기 위한 목적으로 많은 자바스크립트 프레임워크가 존재해왔으며 이들 중 대부분은 비슷한 문제를 해결하려고 합니다. 그러나 Qwik은 다른 프레임워크가 풀지 못한 문제를 해결하려고 합니다. 그 문제에 대해 먼저 알아봅시다.""",
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  child: Text("목록으로"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
