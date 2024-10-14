import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/store/search_store.dart';
import 'package:jaylog/view/_component/common/article_card.dart';
import 'package:jaylog/view/_component/layout/default_layout.dart';
import 'package:jaylog/viewmodel/main/main_view_model.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLifeCycleState = useAppLifecycleState();

    final searchStoreState = ref.watch(searchStoreGlobal);
    final mainViewModelState = ref.watch(mainViewModelGlobal);

    useEffect(() {
      print('mainViewModelState.get()' + appLifeCycleState.toString());
      if (appLifeCycleState == AppLifecycleState.resumed) {
        mainViewModelState.get(searchValue: searchStoreState.searchValue);
      }
      return null;
    }, [searchStoreState.searchValue, appLifeCycleState]);

    return DefaultLayout(
      body: ListView(
        children: mainViewModelState.articleList == null
            ? const []
            : mainViewModelState.articleList!
                .map((thisArticle) => ArticleCard(
                      key: ValueKey(thisArticle.id),
                      id: thisArticle.id,
                      username: thisArticle.writer.username,
                      profileImage: thisArticle.writer.profileImage,
                      title: thisArticle.title,
                      thumbnail: thisArticle.thumbnail,
                      summary: thisArticle.summary,
                      likeCount: thisArticle.likeCount,
                      isLikeClicked: thisArticle.isLikeClicked,
                      createDate: thisArticle.createDate,
                    ))
                .toList(),
      ),
    );
  }
}
