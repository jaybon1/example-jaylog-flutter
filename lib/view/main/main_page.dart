import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/view/_component/common/article_card.dart';

import '../_component/layout/default_layout.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      body: ListView(
        children: const [
          ArticleCard(),
          ArticleCard(),
          ArticleCard(),
        ],
      ),
    );
  }
}
