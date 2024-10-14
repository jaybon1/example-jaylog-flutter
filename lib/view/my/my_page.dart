import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/store/auth_store.dart';
import 'package:jaylog/util/util_function.dart';
import 'package:jaylog/view/_component/common/article_card.dart';
import 'package:jaylog/view/_component/common/circle_profile_image.dart';
import 'package:jaylog/viewmodel/my/my_view_model.dart';

import '../_component/layout/default_layout.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLifeCycleState = useAppLifecycleState();

    final authStoreState = ref.watch(authStoreGlobal);
    final myViewModelState = ref.watch(myViewModelGlobal);
    final loginUser = useMemoized(() {
      return authStoreState.loginUser;
    }, [authStoreState.loginUser]);

    final tabController = useTabController(initialLength: 2);

    useListenable(tabController);

    useEffect(() {
      if (loginUser == null) {
        UtilFunction.alert(
          context: context,
          content: "잘못된 접근입니다.",
        );
        GoRouter.of(context).go('/');
        return;
      }
      print('myViewModelState.get()' + appLifeCycleState.toString());
      if (appLifeCycleState == AppLifecycleState.resumed) {
        myViewModelState.get();
      }
      return null;
    }, [appLifeCycleState]);

    if (loginUser == null) {
      return const SizedBox();
    }

    return DefaultLayout(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleProfileImage(
                  imageUrl: loginUser.profileImage,
                  radius: 50,
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loginUser.username,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    SizedBox(
                      width: 160,
                      child: Text(
                        loginUser.simpleDescription ?? "한 줄 소개가 없습니다.",
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
              ? myViewModelState.myArticleList
                      ?.map((thisArticle) => ArticleCard(
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
                      .toList() ??
                  []
              : myViewModelState.likeArticleList
                      ?.map((thisArticle) => ArticleCard(
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
                      .toList() ??
                  [],
        ],
      ),
    );
  }
}
