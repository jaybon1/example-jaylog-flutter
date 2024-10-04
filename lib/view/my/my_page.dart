import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/view/_component/common/article_card.dart';

import '../_component/layout/default_layout.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tabController = useTabController(initialLength: 2);

    useListenable(tabController);

    return DefaultLayout(
      // body: Column(
      //   children: [
      //     Container(
      //       height: 200,
      //       color: Colors.grey,
      //     ),
      //     Expanded(
      //       child: ListView(
      //         children: [1, 2, 3, 4].map((e) => ArticleCard()).toList(),
      //       ),
      //     ),
      //   ],
      // ),
      body: ListView(
        children: [
          Container(
            height: 200,
            color: Colors.grey,
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
          Text(tabController.index.toString()),
          // ...[1,2,3,4].map((e) => ArticleCard()).toList(),
        ],
      ),
    );
  }
}
