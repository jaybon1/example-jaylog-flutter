import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/view/_component/common/article_card.dart';
import 'package:jaylog/view/_component/common/circle_profile_image.dart';

import '../_component/layout/default_layout.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);

    useListenable(tabController);

    return DefaultLayout(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleProfileImage(
                  imageUrl: "https://picsum.photos/50",
                  radius: 50,
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "temp1",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    SizedBox(
                      width: 160,
                      child: const Text(
                        "간단한 자기소개 입니다. 설레이는 이 마음은 뭘까",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).push('/my/info');
                      },
                      child: Text('내 정보 수정'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        foregroundColor: Colors.green,
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     GoRouter.of(context).push("/my/info");
                    //   },
                    //   child: const Text(
                    //     "내 정보 수정",
                    //     style: TextStyle(
                    //       color: Colors.green,
                    //       decoration: TextDecoration.underline,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ),
          TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                text: '내 글',
              ),
              Tab(
                text: '내가 좋아요 한 글',
              ),
            ],
          ),
          ...tabController.index == 0
              ? [ArticleCard(), ArticleCard()]
              : [ArticleCard()],
          // ...[1,2,3,4].map((e) => ArticleCard()).toList(),
        ],
      ),
    );
  }
}
